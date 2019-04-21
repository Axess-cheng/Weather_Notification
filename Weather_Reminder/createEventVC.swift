//
//  crateEventVC.swift
//  Weather_Reminder
//
//  Created by allen on 2019/3/31.
//  Copyright © 2019 comp208.team4. All rights reserved.
//

import UIKit

var events: [Event] = []


var id = 0
// change from title to eventTitle
var eventTitle = ""
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
var uvIndex = ","
var humidity = ","
var loc = [String : String]()
var weatherSelected = [String]()



class createEventVC: UIViewController {

    @IBOutlet weak var titleText: UITextField!
//    var weatherType:String?
//    var intensity: String?
//    var uvIndex:Int?
//    var humidityStatus:String?
//    var humidityValue:String?
    
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
        // the button create should be change to done- Congwei Ni
        id = events.count+1
        eventTitle = titleText.text!
        var startDate: String = ""
        var endDate: String = ""
        if let start = gsPeriod["startDate"]{
            startDate = start
        }
        if let end = gsPeriod["endDate"]{
            endDate = end
        }
        
        insertEvent(id: id, title: eventTitle, gsSenario: gsSenario, gsRemindTime: gsRemindTime, gsStartDate: startDate, gsEndDate: endDate, gsAlertDays: gsAlertDays, sunny: sunny, cloudy: cloudy, windy: windy, rainy: rainy, snow: snow, uvIndex: uvIndex, humidity: humidity, lat: "53.406566", long: "-2.966531")
        
        //save to core data
        saveCoreData()
        
        // initialize all global data as default empty value
        initialData()
        
        // performSegue to event list view
    }
    
    func initialData() {
        title = ""
        gsSenario = ""
        gsRemindTime = ""
        gsPeriod = [String:String]()
//        gsPStart = String()
//        gsPEnd = String()
        gsAlertDays = Int()
        sunny = ","
        cloudy = ",,"
        windy = ","
        rainy = ""
        snow = ""
        uvIndex = ","
        humidity = ","
        loc = [String : String]()
    }
    
}
