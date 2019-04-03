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
    
    var sunnyLevel = ""
    var cloudyLevel = ""
    var windyLevel = String()
    var rainnyLevel = String()
    var snowLevel = String()
    var humidityStatus = String()
    var uvLevel = String()
    var weatherCondition = [String:Any]()
    var weatherType = [[String:String]]()
    var humidity = [String:String]()
    var uvIndex = [String:String]()
    
    @IBAction func sunnySWB(_ sender: Any) {
        guard sunnyBtn.isOn else{return}
        
    }
    
    @IBAction func cloudySWB(_ sender: Any) {
        guard cloudyBtn.isOn else{return}
        
    }
    
    @IBAction func windySWB(_ sender: Any) {
        guard windyBtn.isOn else{return}
        let windyLevelSheet=UIAlertController(title:"Windy Level",message:"select the windy level",preferredStyle:.actionSheet)
        let cancel=UIAlertAction(title:"cancel",style:.cancel){ (act) -> Void in
            self.cloudyBtn.setOn(false, animated: true)
            NotificationCenter.default.removeObserver(self)
            return
        }
        let level1=UIAlertAction(title:"Light",style:.default){ (act) -> Void in
            self.windyLevel = "Light"
            NotificationCenter.default.removeObserver(self)
        }
        let level2=UIAlertAction(title:"High",style:.default){ (act) -> Void in
            self.windyLevel = "High"
            NotificationCenter.default.removeObserver(self)
        }
        let level3=UIAlertAction(title:"Very High",style:.default){ (act) -> Void in
            self.windyLevel = "Very High"
            NotificationCenter.default.removeObserver(self)
        }
        windyLevelSheet.addAction(cancel)
        windyLevelSheet.addAction(level1)
        windyLevelSheet.addAction(level2)
        windyLevelSheet.addAction(level3)
        present(windyLevelSheet, animated: true, completion: nil)
    }
    
    @IBAction func rainySWB(_ sender: Any) {
        guard rainyBtn.isOn else{return}
        let rainyLevelSheet=UIAlertController(title:"Rainy Level",message:"select the rainy level",preferredStyle:.actionSheet)
        let cancel=UIAlertAction(title:"cancel",style:.cancel){ (act) -> Void in
            self.rainyBtn.setOn(false, animated: true)
            NotificationCenter.default.removeObserver(self)
            return
        }
        let level1=UIAlertAction(title:"Light",style:.default){ (act) -> Void in
            self.rainnyLevel = "Light"
            NotificationCenter.default.removeObserver(self)
        }
        let level2=UIAlertAction(title:"High",style:.default){ (act) -> Void in
            self.rainnyLevel = "High"
            NotificationCenter.default.removeObserver(self)
        }
        let level3=UIAlertAction(title:"Very High",style:.default){ (act) -> Void in
            self.rainnyLevel = "Very High"
            NotificationCenter.default.removeObserver(self)
        }
        rainyLevelSheet.addAction(cancel)
        rainyLevelSheet.addAction(level1)
        rainyLevelSheet.addAction(level2)
        rainyLevelSheet.addAction(level3)
        present(rainyLevelSheet, animated: true, completion: nil)
    }

    @IBAction func snowSWB(_ sender: Any) {
        guard snowBtn.isOn else{return}
        let snowLevelSheet=UIAlertController(title:"Snow Level",message:"select the snow level",preferredStyle:.actionSheet)
        let cancel=UIAlertAction(title:"cancel",style:.cancel){ (act) -> Void in
            self.snowBtn.setOn(false, animated: true)
            NotificationCenter.default.removeObserver(self)
            return
        }
        let level1=UIAlertAction(title:"Light",style:.default){ (act) -> Void in
            self.snowLevel = "Light"
            NotificationCenter.default.removeObserver(self)
        }
        let level2=UIAlertAction(title:"High",style:.default){ (act) -> Void in
            self.snowLevel = "High"
            NotificationCenter.default.removeObserver(self)
        }
        let level3=UIAlertAction(title:"Very High",style:.default){ (act) -> Void in
            self.snowLevel = "Very High"
            NotificationCenter.default.removeObserver(self)
        }
        snowLevelSheet.addAction(cancel)
        snowLevelSheet.addAction(level1)
        snowLevelSheet.addAction(level2)
        snowLevelSheet.addAction(level3)
        present(snowLevelSheet, animated: true, completion: nil)
    }
    
    @IBAction func humiditySWB(_ sender: Any) {
        guard humidityBtn.isOn else{return}
        let humidityLevelSheet=UIAlertController(title:"Humididt Level",message:"select the humidity level",preferredStyle:.actionSheet)
        let cancel=UIAlertAction(title:"cancel",style:.cancel){ (act) -> Void in
            self.humidityBtn.setOn(false, animated: true)
            NotificationCenter.default.removeObserver(self)
            return
        }
        let level1=UIAlertAction(title:"Dry",style:.default){ (act) -> Void in
            self.humidityStatus = "Dry"
            NotificationCenter.default.removeObserver(self)
        }
        let level2=UIAlertAction(title:"Moderate",style:.default){ (act) -> Void in
            self.humidityStatus = "Moderate"
            NotificationCenter.default.removeObserver(self)
        }
        let level3=UIAlertAction(title:"Lamp",style:.default){ (act) -> Void in
            self.humidityStatus = "Lamp"
            NotificationCenter.default.removeObserver(self)
        }
        humidityLevelSheet.addAction(cancel)
        humidityLevelSheet.addAction(level1)
        humidityLevelSheet.addAction(level2)
        humidityLevelSheet.addAction(level3)
        present(humidityLevelSheet, animated: true, completion: nil)
    }
    
    @IBAction func uvSWB(_ sender: Any) {
        guard uvBtn.isOn else{return}
        let uvLevelSheet=UIAlertController(title:"UV Index Level",message:"select the UV Index level",preferredStyle:.actionSheet)
        let cancel=UIAlertAction(title:"cancel",style:.cancel){ (act) -> Void in
            self.uvBtn.setOn(false, animated: true)
            NotificationCenter.default.removeObserver(self)
            return
        }
        let level1=UIAlertAction(title:"Low",style:.default){ (act) -> Void in
            self.humidityStatus = "Low"
            NotificationCenter.default.removeObserver(self)
        }
        let level2=UIAlertAction(title:"Moderate",style:.default){ (act) -> Void in
            self.humidityStatus = "Moderate"
            NotificationCenter.default.removeObserver(self)
        }
        let level3=UIAlertAction(title:"High",style:.default){ (act) -> Void in
            self.humidityStatus = "High"
            NotificationCenter.default.removeObserver(self)
        }
        let level4=UIAlertAction(title:"Very High",style:.default){ (act) -> Void in
            self.humidityStatus = "Very High"
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
        weatherSelected = [String]()
        gsWeatherTypeDic = [String:Any]()
        if segue.identifier == "weatherConditionDone"{
            let createEvent = segue.destination as! createEventVC
            
            if sunnyBtn.isOn{
                weatherType.append(["type":"sunny","intensity":sunnyLevel])
                weatherSelected.append("sunny")
            }
            if cloudyBtn.isOn{
                weatherType.append(["type":"cloudy","intensity":cloudyLevel])
                weatherSelected.append("cloudy")
            }
            if windyBtn.isOn{
                weatherType.append(["type":"windy","intensity":windyLevel])
                weatherSelected.append("windy")
            }
            if rainyBtn.isOn{
                weatherType.append(["type":"rainy","intensity":rainnyLevel])
                weatherSelected.append("rainy")
            }
            if snowBtn.isOn{
                weatherType.append(["type":"snow","intensity":snowLevel])
                weatherSelected.append("snow")
            }
            if humidityBtn.isOn{
                humidity["status"] = humidityStatus
                weatherCondition["humidity"] = humidity
                weatherSelected.append("humidity")
            }
            if uvBtn.isOn{
                weatherCondition["uvIndex"] = uvIndex
                weatherSelected.append("uvIndex")
            }
            if weatherType.isEmpty != true{
                weatherCondition["weatherType"] = weatherType
            }
            gsWeatherTypeDic = weatherCondition
        }
    }

}
