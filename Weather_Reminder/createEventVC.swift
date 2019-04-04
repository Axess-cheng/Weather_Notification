//
//  crateEventVC.swift
//  Weather_Reminder
//
//  Created by allen on 2019/3/31.
//  Copyright © 2019 comp208.team4. All rights reserved.
//

import UIKit
var id = 0
var title = ""
var gsSenario = ""
var gsRemindTime = ""
var gsPeriod = [String:String]()
//var gsPStart = String()
//var gsPEnd = String()
var gsAlertDays = Int()
var sunny = ","
var cloudy = ",,"
var windy = ","
var rainy = ""
var snow = ""
var uvindex = ","
var humidity = ","
var loc = [String : Float32]()
var weatherSelected = [String]()



class createEventVC: UIViewController {

    @IBOutlet weak var titleText: UITextField!
    var weatherType:String?
    var intensity: String?
    var uvIndex:Int?
    var humidityStatus:String?
    var humidityValue:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(gsSenario)
        print("remindTime: " + gsRemindTime)
        print("start:  \(String(describing: gsPeriod["startDate"]))")
        print("end:  \(String(describing: gsPeriod["endDate"]))")
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
        print(gsAlertDays)
    }
    
    @IBAction func createBtn(_ sender: Any) {
        id += 1
        title = titleText.text
        initialData()
    }
    
    func initialData() {
        var title = ""
        var gsSenario = ""
        var gsRemindTime = ""
        var gsPeriod = [String:Int]()
        var gsPStart = String()
        var gsPEnd = String()
        var gsAlertDays = Int()
        var sunny = ","
        var cloudy = ",,"
        var windy = ","
        var rainy = ""
        var snow = ""
        var uvindex = ","
        var humidity = ","
        var loc = [String : Float32]()
    }
    
}
