package com.github.naaathan.weatherreminder.timer;

import com.github.naaathan.weatherreminder.WeatherReminder;
import com.github.naaathan.weatherreminder.model.Event;
import com.github.naaathan.weatherreminder.model.WebAlert;
import com.github.naaathan.weatherreminder.model.WebUser;
import com.notnoop.apns.APNS;

import lombok.Setter;

import java.io.IOException;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;
import java.util.TimeZone;

public class EventTimer extends Timer {

    @Setter
    private Map<Integer, Map<Integer, Event>> events = new HashMap<>();

    public EventTimer(long interval) {
        super(interval, -1);
    }

    @Override
    public void tick() {
        Calendar calendar = Calendar.getInstance(TimeZone.getDefault());

        if (calendar.get(Calendar.SECOND) > 0 || events.isEmpty()) {
            return;
        }

        Map<Integer, Map<Integer, Event>> events = new HashMap<>(this.events);
        String hour = "" + calendar.get(Calendar.HOUR_OF_DAY);
        String minute = "" + calendar.get(Calendar.MINUTE);

        if (hour.length() == 1) {
            hour = "0" + hour;
        }

        if (minute.length() == 1) {
            minute = "0" + minute;
        }

        for (Map.Entry<Integer, Map<Integer, Event>> userIdAndEvents : events.entrySet()) {
            int userId = userIdAndEvents.getKey();
            Map<Integer, Event> userEvents = userIdAndEvents.getValue();

            if (events.isEmpty()) {
                continue;
            }

            String deviceToken = null;

            for (Map.Entry<Integer, Event> eventIdAndEvent : userEvents.entrySet()) {
                Event event = eventIdAndEvent.getValue();
                String[] hoursMinutes = event.remindTime.split(":");

                if (hoursMinutes.length != 2) {
                    continue;
                }

                if (hoursMinutes[0].equals(hour) && hoursMinutes[1].equals(minute)) {
                    String payload = getPayload(event);

                    if (payload == null) {
                        continue;
                    }

                    if (deviceToken == null) {
                        deviceToken = getDeviceToken(userId);

                        if (deviceToken == null) {
                            break;
                        }
                    }

                    WeatherReminder.getInstance().sendPushNotification(true, payload, deviceToken);
                }
            }
        }
    }

    private String getDeviceToken(int userId) {
        String urlString = WeatherReminder.DB_REQUEST_URL + "get_user.php";
        String parameters = "id_field=id&id_data=" + userId + "&id_type=i&token=" + WeatherReminder.SUPERUSER_TOKEN;

        try {
            String response = WeatherReminder.getInstance().sendWebRequest("GET", urlString, parameters, false);
            WebUser webUser = WeatherReminder.GSON.fromJson(response, WebUser.class);

            return webUser.device_token;
        } catch (IOException e) {
            WeatherReminder.getLogger().severe("GETDEVICETOKEN EXCEPTION:");
            e.printStackTrace();
        }

        return null;
    }

    private String getPayload(Event event) {
        String urlString = WeatherReminder.DB_REQUEST_URL + "check_event.php";
        String parameters = "event=" + WeatherReminder.GSON.toJson(event);

        try {
            String response = WeatherReminder.getInstance().sendWebRequest("GET", urlString, parameters, false);
            WebAlert alert = WeatherReminder.GSON.fromJson(response, WebAlert.class);

            return APNS.newPayload().alertBody(alert.alert).build();
        } catch (IOException e) {
            WeatherReminder.getLogger().severe("GETPAYLOAD EXCEPTION:");
            e.printStackTrace();
        }

        return null;
    }

}
