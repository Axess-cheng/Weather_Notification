//
//  TTableViewController.swift
//  Weather_Reminder
//
//  Created by allen on 2019/4/2.
//  Copyright © 2019 comp208.team4. All rights reserved.
//

import UIKit

class TTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var sunnyBtn: UISwitch!
    @IBOutlet weak var cloudyBtn: UISwitch!
    @IBOutlet weak var windyBtn: UISwitch!
    @IBOutlet weak var rainyBtn: UISwitch!
    @IBOutlet weak var snowBtn: UISwitch!
    @IBOutlet weak var humidityBtn: UISwitch!
    @IBOutlet weak var uvBtn: UISwitch!
    
    
    @IBAction func sunnySWB(_ sender: Any) {
        guard sunnyBtn.isOn else{
            sunny = ","
            weatherSelected["sunny"] = nil
            return
        }
        sunny = "CL,FW"
        weatherSelected["sunny"] = "  "
    }
    
    @IBAction func cloudySWB(_ sender: Any) {
        guard cloudyBtn.isOn else{
            cloudy = ",,"
            weatherSelected["cloudy"] = nil
            return
        }
        cloudy = "SC,BK,OV"
        weatherSelected["cloudy"] = "  "
    }
    
    @IBAction func windySWB(_ sender: Any) {
        guard windyBtn.isOn else{
            windy = ","
            weatherSelected["windy"] = nil
            return}
        let windyLevelSheet=UIAlertController(title:"Windy Level",message:"select the windy level",preferredStyle:.actionSheet)
        let cancel=UIAlertAction(title:"cancel",style:.cancel){ (act) -> Void in
            self.windyBtn.setOn(false, animated: true)
            NotificationCenter.default.removeObserver(self)
            windy = ","
            weatherSelected["windy"] = nil
            return
        }
        let level1=UIAlertAction(title:"Light",style:.default){ (act) -> Void in
            windy = "0,19"
            weatherSelected["windy"] = "light"
            NotificationCenter.default.removeObserver(self)
        }
        let level2=UIAlertAction(title:"High",style:.default){ (act) -> Void in
            windy = "20,49"
            weatherSelected["windy"] = "high"
            NotificationCenter.default.removeObserver(self)
        }
        let level3=UIAlertAction(title:"Very High",style:.default){ (act) -> Void in
            windy = "50,_"
            weatherSelected["windy"] = "very high"
            NotificationCenter.default.removeObserver(self)
        }
        windyLevelSheet.addAction(cancel)
        windyLevelSheet.addAction(level1)
        windyLevelSheet.addAction(level2)
        windyLevelSheet.addAction(level3)
        present(windyLevelSheet, animated: true, completion: nil)
    }
    
    @IBAction func rainySWB(_ sender: Any) {
        guard rainyBtn.isOn else{
            rainy = ""
            weatherSelected["rainy"] = nil
            return}
        let rainyLevelSheet=UIAlertController(title:"Rainy Level",message:"select the rainy level",preferredStyle:.actionSheet)
        let cancel=UIAlertAction(title:"cancel",style:.cancel){ (act) -> Void in
            rainy = ""
            weatherSelected["rainy"] = nil
            self.rainyBtn.setOn(false, animated: true)
            NotificationCenter.default.removeObserver(self)
            return
        }
        let level1=UIAlertAction(title:"Very Low",style:.default){ (act) -> Void in
            rainy = "VL"
            weatherSelected["rainy"] = "very low"
            NotificationCenter.default.removeObserver(self)
        }
        let level2=UIAlertAction(title:"Low",style:.default){ (act) -> Void in
            rainy = "L"
            weatherSelected["rainy"] = "low"
            NotificationCenter.default.removeObserver(self)
        }
        let level3=UIAlertAction(title:"High",style:.default){ (act) -> Void in
            rainy = "H"
            weatherSelected["rainy"] = "high"
            NotificationCenter.default.removeObserver(self)
        }
        let level4=UIAlertAction(title:"Very High",style:.default){ (act) -> Void in
            rainy = "VH"
            weatherSelected["rainy"] = "very high"
            NotificationCenter.default.removeObserver(self)
        }
        rainyLevelSheet.addAction(cancel)
        rainyLevelSheet.addAction(level1)
        rainyLevelSheet.addAction(level2)
        rainyLevelSheet.addAction(level3)
        rainyLevelSheet.addAction(level4)
        present(rainyLevelSheet, animated: true, completion: nil)
    }

    @IBAction func snowSWB(_ sender: Any) {
        guard snowBtn.isOn else{
            snow = ""
            weatherSelected["snow"] = nil
            return}
        let snowLevelSheet=UIAlertController(title:"Snow Level",message:"select the snow level",preferredStyle:.actionSheet)
        let cancel=UIAlertAction(title:"cancel",style:.cancel){ (act) -> Void in
            snow = ""
            weatherSelected["snow"] = nil
            self.snowBtn.setOn(false, animated: true)
            NotificationCenter.default.removeObserver(self)
            return
        }
        let level1=UIAlertAction(title:"Light",style:.default){ (act) -> Void in
            snow = "L"
            weatherSelected["snow"] = "light"
            NotificationCenter.default.removeObserver(self)
        }
        let level2=UIAlertAction(title:"High",style:.default){ (act) -> Void in
            snow = "H"
            weatherSelected["snow"] = "high"
            NotificationCenter.default.removeObserver(self)
        }
        let level3=UIAlertAction(title:"Very High",style:.default){ (act) -> Void in
            snow = "VH"
            weatherSelected["snow"] = "very high"
            NotificationCenter.default.removeObserver(self)
        }
        snowLevelSheet.addAction(cancel)
        snowLevelSheet.addAction(level1)
        snowLevelSheet.addAction(level2)
        snowLevelSheet.addAction(level3)
        present(snowLevelSheet, animated: true, completion: nil)
    }
    
    @IBAction func humiditySWB(_ sender: Any) {
        guard humidityBtn.isOn else{
            humidity = ","
            weatherSelected["humidity"] = nil
            return
        }
        let humidityLevelSheet=UIAlertController(title:"Humididt Level",message:"select the humidity level",preferredStyle:.actionSheet)
        let cancel=UIAlertAction(title:"cancel",style:.cancel){ (act) -> Void in
            humidity = ","
            weatherSelected["humidity"] = nil
            self.humidityBtn.setOn(false, animated: true)
            NotificationCenter.default.removeObserver(self)
            return
        }
        let level1=UIAlertAction(title:"Dry",style:.default){ (act) -> Void in
            humidity = "0,30,"
            weatherSelected["humidity"] = "dry"
            NotificationCenter.default.removeObserver(self)
        }
        let level2=UIAlertAction(title:"Moderate",style:.default){ (act) -> Void in
            humidity = "31,60"
            weatherSelected["humidity"] = "moderate"
            NotificationCenter.default.removeObserver(self)
        }
        let level3=UIAlertAction(title:"Lamp",style:.default){ (act) -> Void in
            humidity = "61,100"
            weatherSelected["humidity"] = "lamp"
            NotificationCenter.default.removeObserver(self)
        }
        humidityLevelSheet.addAction(cancel)
        humidityLevelSheet.addAction(level1)
        humidityLevelSheet.addAction(level2)
        humidityLevelSheet.addAction(level3)
        present(humidityLevelSheet, animated: true, completion: nil)
    }
    
    @IBAction func uvSWB(_ sender: Any) {
        guard uvBtn.isOn else{
            uvIndex = ","
            weatherSelected["UV index"] = nil
            return
        }
        let uvLevelSheet=UIAlertController(title:"UV Index Level",message:"select the UV Index level",preferredStyle:.actionSheet)
        let cancel=UIAlertAction(title:"cancel",style:.cancel){ (act) -> Void in
            uvIndex = ","
            weatherSelected["UV index"] = nil
            self.uvBtn.setOn(false, animated: true)
            NotificationCenter.default.removeObserver(self)
            return
        }
        let level1=UIAlertAction(title:"Low",style:.default){ (act) -> Void in
            uvIndex = "0,2"
            weatherSelected["UV index"] = "low"
            NotificationCenter.default.removeObserver(self)
        }
        let level2=UIAlertAction(title:"Moderate",style:.default){ (act) -> Void in
            uvIndex = "4,6"
            weatherSelected["UV index"] = "moderate"
            NotificationCenter.default.removeObserver(self)
        }
        let level3=UIAlertAction(title:"High",style:.default){ (act) -> Void in
            uvIndex = "7,9"
            weatherSelected["UV index"] = "high"
            NotificationCenter.default.removeObserver(self)
        }
        let level4=UIAlertAction(title:"Very High",style:.default){ (act) -> Void in
            uvIndex = "10,12"
            weatherSelected["UV index"] = "very high"
            NotificationCenter.default.removeObserver(self)
        }
        uvLevelSheet.addAction(cancel)
        uvLevelSheet.addAction(level1)
        uvLevelSheet.addAction(level2)
        uvLevelSheet.addAction(level3)
        uvLevelSheet.addAction(level4)
        present(uvLevelSheet, animated: true, completion: nil)
    }
    
    
    
    @IBAction func weatherConditionDone(_ sender: Any) {
        self.performSegue(withIdentifier: "weatherConditionDone", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "weatherConditionDone"{
            let createEvent = segue.destination as! createEventVC
            
            if sunnyBtn.isOn == false{
                weatherSelected["sunny"] = nil
            }
            if cloudyBtn.isOn == false{
                weatherSelected["cloudy"] = nil
            }
            if windyBtn.isOn == false{
                weatherSelected["windy"] = nil
            }
            if rainyBtn.isOn == false{
                weatherSelected["rainy"] = nil
            }
            if snowBtn.isOn == false{
                weatherSelected["snow"] = nil
            }
            if humidityBtn.isOn == false{
                weatherSelected["humidity"] = nil
            }
            if uvBtn.isOn == false{
                weatherSelected["UV index"] = nil
            }

        }
    }

}
