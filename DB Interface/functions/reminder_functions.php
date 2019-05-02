<?php

function daysDiff($date1, $date2)
{
    $diff = ($date1 - $date2) / (60 * 60 * 24);
    return ($diff);
}

function outDate($timeStamp)
{
    $date = (date('j/F', $timeStamp));
    $dateSplit = explode("/", $date);
    $return = $dateSplit[0];

    switch ($dateSplit[0]) {
        case "1":
        case "21":
            $return .= "st ";
            break;
        case "2":
        case "22":
            $return .= "nd ";
            break;
        case "3":
        case "23":
            $return .= "rd ";
            break;
        default:
            $return .= "th ";
    }

    return $return . $dateSplit[1];
}

function outTime($timeStamp)
{
    return (date('h:i:sa', $timeStamp));
}

function callAPI($input1, $input2)
{// the input can be lat&long, also can be cityName and countryName
    $response = file_get_contents("https://api.aerisapi.com/forecasts/" . $input1 . "," . $input2 . "?&format=json&filter=day&limit=14&client_id=mMCICSZlYcdeXQYRss2h6&client_secret=ptiwpiqFVgrKg2wEqRtVshnTj1KKzEEpIc5S70vz");
    $json = json_decode($response);
    if ($json->success == true) {
        return ($json->response[0]);
    } else {
        return ("FALSE");
    }
}

function getLoc($API)
{
    $long = $API->loc->long;
    $lat = $API->loc->lat;
    return ([$long, $lat]);
}

function getPeriods($API)
{
    $periods = $API->periods;
    return ($periods);
}

function getForcasteDate($periods, $date)
{
    for ($i = 0; $i < sizeof($periods); $i++) {
        $timeStamp = $periods[$i]->timestamp;
        if (outDate($date) == outDate((int)$timeStamp)) {
            return ($periods[$i]);
        }
    }
}

function getTemperature($date, $temCode)
{
    if ($temCode == "C") {
        return (["Max" => $date->maxTempC, "Min" => $date->minTempC, "temCode" => $temCode]);
    } elseif ($temCode == "F") {
        return (["Max" => $date->maxTempF, "Min" => $date->minTempF, "temCode" => $temCode]);
    }
}

function getWeatherCode($date)
{
    $primaryWeather = $date->weatherPrimaryCoded;
    $weatherCode = $date->weatherCoded;
    $weatherList = [];
    for ($j = 0; $j < sizeof($weatherCode); $j++) {
        $weatherList[$weatherCode[$j]->timestamp] = $weatherCode[$j]->wx;
    }
    return (["primaryWeather" => $primaryWeather, "weatherList" => $weatherList]);
}

function getWindSpeed($date)
{
    return ($date->windSpeedMPH);
}

function getSnowAmount($date)
{
    return ($date->snowCM);
}

function getHumidity($date)
{
    return (["max" => $date->maxHumidity, "min" => $date->minHumidity]);
}

function getUVIndex($date)
{
    return ($date->uvi);
}

function reqAlert($usrReq)
{
    //usr requirement
    $usrReq = json_decode($usrReq, true);
    $periodReq = $usrReq['period'];
    $startDate = (int)$periodReq["startDate"];
    $endDate = (int)$periodReq["endDate"];
    $loc = $usrReq["loc"];
    $weatherReq = ["rainy" => $usrReq["rainy"], "sunny" => $usrReq["sunny"], "cloudy" => $usrReq["cloudy"], "snow" => $usrReq["snow"]];
    $usrReq["weather"] = $weatherReq;

    //get the API information
    $weatherAPI = callAPI($loc["lon"], $loc["lat"]);
    $forcastePeriods = getPeriods($weatherAPI);
    $returnString = "";

    if ($startDate == null) {
        $dateNow = strtotime("now");
        $forcasteDate = getForcasteDate($forcastePeriods, $dateNow);
        if ($forcasteDate == null) {
            return json_encode(
                array(
                    "success" => false
                )
            );
        }
        $forcasteInfo = getForcasteInfo($forcasteDate);
        $returnString = $returnString . checkForcasteInfo($usrReq, $forcasteInfo, $forcasteDate->timestamp);
    } else {
        for ($i = 0; $i < sizeof($forcastePeriods); $i++) {
            $forcasteDate = $forcastePeriods[$i];
            $timeStamp = $forcasteDate->timestamp;
            if (daysDiff($startDate, $timeStamp) <= 0.25 && daysDiff($endDate, $timeStamp) >= -0.25) {
                $forcasteInfo = getForcasteInfo($forcasteDate);
                $returnString = $returnString . checkForcasteInfo($usrReq, $forcasteInfo, $forcasteDate->timestamp);
            }
        }
    }

    if ($returnString == "") {
        return json_encode(
            array(
                "success" => false
            )
        );
    }

    return json_encode(
        array(
            "success" => true,
            "alert" => $returnString
        )
    );
}

function checkForcasteInfo($usrReq, $forcasteInfo, $timestamp)
{
    $windyRet = checkWindSpeed($usrReq["windy"], $forcasteInfo["windy"]);
    $weatherRet = checkWeather($usrReq["weather"], $forcasteInfo["weather"]);
    return ("On " . outDate($timestamp) . " in " . $usrReq["locName"] . " " . $weatherRet . $windyRet);
}

function getForcasteInfo($forcasteDate)
{
    $forcasteWindy = getWindSpeed($forcasteDate);
    $forcasteTemp = getTemperature($forcasteDate, "C");
    $forcasteWeather = getWeatherCode($forcasteDate);
    $forcasteUVI = getUVIndex($forcasteDate);
    $forcasteHum = getHumidity($forcasteDate);
    return (["windy" => $forcasteWindy, "temp" => $forcasteTemp, "weather" => $forcasteWeather, "uvi" => $forcasteUVI, "hum" => $forcasteHum]);
}

function checkWeather($weatherReq, $dateWeather)
{
    $weathercoded = ["R" => "rain", "RW" => "rain", "S" => "snow", "SW" => "snow"];
    $cloudycoded = ["CL" => 0, "FW" => 1, "SC" => 2, "BK" => 3, "OV" => 4];
    $weatherlevel = ["VL" => 0, "L" => 1, "H" => 2, "VH" => 3];
    $weatherlevelcoded = ["VL" => "very light", "L" => "light", "H" => "heavy", "VH" => "very heavy"];
    $primaryWeather = $dateWeather["primaryWeather"];
    //check the primary weather
    $primaryWeather = explode(":", $primaryWeather);
    if ($primaryWeather[0] == null && $primaryWeather[1] == null) {
        $sunnyReq = $weatherReq["sunny"];
        $sunnyReq = explode(",", $sunnyReq);
        $cloudyReq = $weatherReq["cloudy"];
        $cloudyReq = explode(",", $cloudyReq);
        if (in_array($primaryWeather[2], $sunnyReq)) {
            return ("it will be sunny.");
        } elseif (in_array($primaryWeather[2], $cloudyReq)) {
            return ("it will be cloudy with a chance of rain.");
        }
    } else {
        $theweather = $weathercoded[$primaryWeather[2]];
        $theReq = $weatherReq[$theweather];
        $theReqlevel = $weatherlevel[$theReq];
        $forcastlevel = $primaryWeather[1];
        if ($forcastlevel >= $theReqlevel) {
            $retString = "there will be " . $weatherlevelcoded[$forcastlevel] . " " . $theweather . " ";
            if ($theweather == "rain") {
                $alertStr = ", don't forget to take an umbrella!";
            } else {
                $alertStr = ", don't forget to keep warm!";
            }
            return ($retString . $alertStr);
        }
    }

    return ("");
}

function checkWindSpeed($windReq, $dateWind)
{
    $windReq = explode(",", $windReq);
    if ((int)$windReq[0] < (int)$dateWind) {
        //make the unit to be m/s
        $dateWindMs = (int)$dateWind * 0.278;

        if ($dateWindMs >= 1 && $dateWindMs <= 7) {
            // slight breeze
            return " There will be a slight breeze.";
        } else if ($dateWindMs <= 18) {
            // quite windy
            return " It will be quite windy with speeds of " . $dateWind . "km/s.";
        } else if ($dateWindMs <= 31) {
            // very windy
            return " It will be very windy with speeds of " . $dateWind . "km/s.";
        } else {
            // be careful
            return " It will be very windy with speeds of " . $dateWind . "km/s, make sure to be careful.";
        }
    }

    return "";
}

