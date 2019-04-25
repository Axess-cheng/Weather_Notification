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
var gsPStart = String()
var gsPEnd = String()
var gsAlertDays = Int()
var sunny = ","
var cloudy = ",,"
var windy = ","
var rainy = ""
var snow = ""
var uvIndex = ","
var humidity = ","
var loc = [String : String]()
var locName = ""
var weatherSelected = [String]()

var start = ""
var end = ""


class createEventVC: UIViewController {
    
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var periodText: UILabel!
    @IBOutlet weak var remindTimeText: UILabel!
    @IBOutlet weak var alertText: UILabel!
    @IBOutlet weak var locationText: UILabel!
    @IBOutlet weak var weatherText: UILabel!
    
//    var weatherType:String?
//    var intensity: String?
//    var uvIndex:Int?
//    var humidityStatus:String?
//    var humidityValue:String?
    func setTitile(){
        eventTitle = titleText.text!
    }
    
    @IBAction func periodBtn(_ sender: Any) {
        setTitile()
    }
    @IBAction func remindTimeBtn(_ sender: Any) {
        setTitile()
    }
    @IBAction func alertBtn(_ sender: Any) {
        setTitile()
    }
    @IBAction func locBtn(_ sender: Any) {
        setTitile()
    }
    @IBAction func weatherBtn(_ sender: Any) {
        setTitile()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if eventTitle != "" {
            titleText.text = eventTitle
        }
        if(gsPeriod.isEmpty){
            periodText.text = "Everyday"
        }else{
            periodText.text = "\(start) to \(end)"
        }
        if(gsRemindTime != ""){
            remindTimeText.text = gsRemindTime
        }else{
            remindTimeText.text = gsRemindTime
        }
        if(loc.isEmpty){
            locationText.text = ""
        }else{
            locationText.text = locName
        }
        if(weatherSelected.isEmpty){
            weatherText.text = ""
        }else{
            var weather = ""
            let space = " "
            for i in 0..<weatherSelected.count{
                weather = weather + space + weatherSelected[i]
            }
            weatherText.text = weather
        }
        
        print(gsSenario)
        print(eventTitle)
    }
    
    @IBAction func setAlert(_ sender: Any) {
        let actionSheet=UIAlertController(title:"Alert days",message:"select the alert days before the event",preferredStyle:.actionSheet)
        let cancel=UIAlertAction(title:"cancel",style:.cancel)
        let confirm1=UIAlertAction(title:"on that day",style:.default){ (act) -> Void in
            self.alertText.text = "on that day"
            gsAlertDays = 0
            NotificationCenter.default.removeObserver(self)
        }
        let confirm2=UIAlertAction(title:"1 day",style:.default){ (act) -> Void in
            self.alertText.text = "1 day"
            gsAlertDays = 1
            NotificationCenter.default.removeObserver(self)
        }
        let confirm3=UIAlertAction(title:"3 day",style:.default){ (act) -> Void in
            self.alertText.text = "3 day"
            gsAlertDays = 3
            NotificationCenter.default.removeObserver(self)
        }
        let confirm4=UIAlertAction(title:"7 day",style:.default){ (act) -> Void in
            self.alertText.text = "7 day"
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
        id = id + 1
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
        eventTitle = ""
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
        locName = ""
        start = ""
        end = ""
    }
    
    // using post method to upload event details
    func postUpload(){
        let session = URLSession.shared
        let url = URL(string: "https://student.csc.liv.ac.uk/~sgsche20/testForAPP.php")!
        //let url = URL(string: "https://www.url.com/path/to/file.php")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        //request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "name=\(snow)".data(using:.utf8)
        
        
        
        
        // send the request
        let dataTask = session.dataTask(with: request) {
            (data, response, error) in
            if error == nil {
                print(response ?? "should be response")
            }else {print(error ?? "error!!!")}
        }
        dataTask.resume()
        
    }
    
}
