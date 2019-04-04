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
            return
        }
        sunny = "CL,FW"
    }
    
    @IBAction func cloudySWB(_ sender: Any) {
        guard cloudyBtn.isOn else{
            cloudy = ",,"
            return
        }
        cloudy = "SC,BK,OV"
    }
    
    @IBAction func windySWB(_ sender: Any) {
        guard windyBtn.isOn else{
            windy = ","
            return}
        let windyLevelSheet=UIAlertController(title:"Windy Level",message:"select the windy level",preferredStyle:.actionSheet)
        let cancel=UIAlertAction(title:"cancel",style:.cancel){ (act) -> Void in
            self.windyBtn.setOn(false, animated: true)
            NotificationCenter.default.removeObserver(self)
            windy = ","
            return
        }
        let level1=UIAlertAction(title:"Light",style:.default){ (act) -> Void in
            windy = "0,20"
            NotificationCenter.default.removeObserver(self)
        }
        let level2=UIAlertAction(title:"High",style:.default){ (act) -> Void in
            windy = "21,60"
            NotificationCenter.default.removeObserver(self)
        }
        let level3=UIAlertAction(title:"Very High",style:.default){ (act) -> Void in
            windy = "60,200"
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
            return}
        let rainyLevelSheet=UIAlertController(title:"Rainy Level",message:"select the rainy level",preferredStyle:.actionSheet)
        let cancel=UIAlertAction(title:"cancel",style:.cancel){ (act) -> Void in
            rainy = ""
            self.rainyBtn.setOn(false, animated: true)
            NotificationCenter.default.removeObserver(self)
            return
        }
        let level1=UIAlertAction(title:"Very Low",style:.default){ (act) -> Void in
            rainy = "VL"
            NotificationCenter.default.removeObserver(self)
        }
        let level2=UIAlertAction(title:"Low",style:.default){ (act) -> Void in
            rainy = "L"
            NotificationCenter.default.removeObserver(self)
        }
        let level3=UIAlertAction(title:"High",style:.default){ (act) -> Void in
            rainy = "H"
            NotificationCenter.default.removeObserver(self)
        }
        let level4=UIAlertAction(title:"Very High",style:.default){ (act) -> Void in
            rainy = "VH"
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
            return}
        let snowLevelSheet=UIAlertController(title:"Snow Level",message:"select the snow level",preferredStyle:.actionSheet)
        let cancel=UIAlertAction(title:"cancel",style:.cancel){ (act) -> Void in
            snow = ""
            self.snowBtn.setOn(false, animated: true)
            NotificationCenter.default.removeObserver(self)
            return
        }
        let level1=UIAlertAction(title:"Light",style:.default){ (act) -> Void in
            snow = "L"
            NotificationCenter.default.removeObserver(self)
        }
        let level2=UIAlertAction(title:"High",style:.default){ (act) -> Void in
            snow = "H"
            NotificationCenter.default.removeObserver(self)
        }
        let level3=UIAlertAction(title:"Very High",style:.default){ (act) -> Void in
            snow = "VH"
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
            return
        }
        let humidityLevelSheet=UIAlertController(title:"Humididt Level",message:"select the humidity level",preferredStyle:.actionSheet)
        let cancel=UIAlertAction(title:"cancel",style:.cancel){ (act) -> Void in
            humidity = ","
            self.humidityBtn.setOn(false, animated: true)
            NotificationCenter.default.removeObserver(self)
            return
        }
        let level1=UIAlertAction(title:"Dry",style:.default){ (act) -> Void in
            humidity = "0,30,"
            NotificationCenter.default.removeObserver(self)
        }
        let level2=UIAlertAction(title:"Moderate",style:.default){ (act) -> Void in
            humidity = "31,60"
            NotificationCenter.default.removeObserver(self)
        }
        let level3=UIAlertAction(title:"Lamp",style:.default){ (act) -> Void in
            humidity = "61,100"
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
            uvindex = ","
            return
        }
        let uvLevelSheet=UIAlertController(title:"UV Index Level",message:"select the UV Index level",preferredStyle:.actionSheet)
        let cancel=UIAlertAction(title:"cancel",style:.cancel){ (act) -> Void in
            uvindex = ","
            self.uvBtn.setOn(false, animated: true)
            NotificationCenter.default.removeObserver(self)
            return
        }
        let level1=UIAlertAction(title:"Low",style:.default){ (act) -> Void in
            uvindex = "0,2"
            NotificationCenter.default.removeObserver(self)
        }
        let level2=UIAlertAction(title:"Moderate",style:.default){ (act) -> Void in
            uvindex = "4,6"
            NotificationCenter.default.removeObserver(self)
        }
        let level3=UIAlertAction(title:"High",style:.default){ (act) -> Void in
            uvindex = "7,9"
            NotificationCenter.default.removeObserver(self)
        }
        let level4=UIAlertAction(title:"Very High",style:.default){ (act) -> Void in
            uvindex = "10,12"
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
        if segue.identifier == "weatherConditionDone"{
            let createEvent = segue.destination as! createEventVC
            
            if sunnyBtn.isOn{
                weatherSelected.append("sunny")
            }
            if cloudyBtn.isOn{
                weatherSelected.append("cloudy")
            }
            if windyBtn.isOn{
                weatherSelected.append("windy")
            }
            if rainyBtn.isOn{
                weatherSelected.append("rainy")
            }
            if snowBtn.isOn{
                weatherSelected.append("snow")
            }
            if humidityBtn.isOn{
                weatherSelected.append("humidity")
            }
            if uvBtn.isOn{
                weatherSelected.append("uvIndex")
            }

        }
    }

}
