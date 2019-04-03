//
//  crateEventVC.swift
//  Weather_Reminder
//
//  Created by allen on 2019/3/31.
//  Copyright © 2019 comp208.team4. All rights reserved.
//

import UIKit
var gsSenario = String()
var gsRemindTime = String()
var gsPStart = String()
var gsPEnd = String()
var gsEveryday = Bool()
var gsAlertDays = Int()
var gsWeatherTypeDic = [String:Any]()
var weatherSelected = [String]()

class createEventVC: UIViewController {

    var weatherType:String?
    var intensity: String?
    var uvIndex:Int?
    var humidityStatus:String?
    var humidityValue:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(gsSenario)
        //print("remindTime: " + gsRemindTime)
        //print(gsEveryday)
        //print("start: " + gsPStart)
        //print("end: " + gsPEnd)
        //print(gsAlertDays)
        print(weatherSelected.isEmpty)
        for i in 0..<weatherSelected.count{
            print(i)
            print(weatherSelected[i])
        }
        //print(gsWeatherTypeDic.isEmpty)
    }

    @IBAction func setAlert(_ sender: Any) {
        let actionSheet=UIAlertController(title:"Alert days",message:"select the alert days before the event",preferredStyle:.actionSheet)
        let cancel=UIAlertAction(title:"cancel",style:.cancel)
        let confirm1=UIAlertAction(title:"on that day",style:.default){ (act) -> Void in
            gsAlertDays = 0
            NotificationCenter.default.removeObserver(self)
        }
        let confirm2=UIAlertAction(title:"1 day",style:.default){ (act) -> Void in
            gsAlertDays = 1
            NotificationCenter.default.removeObserver(self)
        }
        let confirm3=UIAlertAction(title:"3 day",style:.default){ (act) -> Void in
            gsAlertDays = 3
            NotificationCenter.default.removeObserver(self)
        }
        let confirm4=UIAlertAction(title:"7 day",style:.default){ (act) -> Void in
            gsAlertDays = 7
            NotificationCenter.default.removeObserver(self)
        }
        actionSheet.addAction(cancel)
        actionSheet.addAction(confirm1)
        actionSheet.addAction(confirm2)
        actionSheet.addAction(confirm3)
        actionSheet.addAction(confirm4)
        present(actionSheet, animated: true, completion: nil)
    }
}
