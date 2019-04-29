//
//  crateEventVC.swift
//  Weather_Reminder
//
//  Created by allen on 2019/3/31.
//  Copyright © 2019 comp208.team4. All rights reserved.
//
//This class is the main class to control the event
//initialize the global paramters and recieve data from other VC
//use core data and use the back server
import UIKit
//the global parameters th event use


var events: [Event] = []

//the data the coredata and back server use
//the UI also use part
var id = 0
var eventTitle = ""
var gsSenario = ""
var gsRemindTime = "08:00"
var gsPeriod = [String:String]() // startDate , endDate
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
var location2D = [String : String]() // lat long
var locName = ""

//the data that just UI use
var weatherSelected = [String:String]()
var start = ""
var end = ""

var globalEvent : Event?


class createEventVC: UIViewController {
    
    // sended from event list if click cell
    var event: Event?
    
    //var from UI
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var periodText: UILabel!
    @IBOutlet weak var remindTimeText: UILabel!
    @IBOutlet weak var alertText: UILabel!
    @IBOutlet weak var locationText: UILabel!
    @IBOutlet weak var weatherText: UILabel!
    @IBOutlet weak var backBtn: UIBarButtonItem!
    
    
    //    var weatherType:String?
    //    var intensity: String?
    //    var uvIndex:Int?
    //    var humidityStatus:String?
    //    var humidityValue:String?
    
    //the function to make the title the user type pass to parameters
    func setTitile(){
        eventTitle = titleText.text!
    }
    
    //5 TBAction to keep the title show event if jump the pages
    //every button make a memory
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
        
        //define the way of a new line of a label
        weatherText.lineBreakMode = NSLineBreakMode.byWordWrapping
        weatherText.numberOfLines = 0
        
        //print for test use
        //the the parameteris is passed
        print("locName \(locName) in create event vc")
        print("lat \(location2D["lat"]) in create event vc")
        print("current \(location2D["long"]) in create event vc")
        print("location2D isEmpty \(location2D.isEmpty)")
        
        print("event is not nil \(self.event != nil) in view did load")
        
        if(event != nil){
            globalEvent = self.event
            self.assignData()
            backBtn.isEnabled = false
            backBtn.tintColor = UIColor.clear
        }
        
        //below is to check if the data is set and show the content
        if eventTitle != "" {
            titleText.text = eventTitle
        }
        if(gsPeriod.isEmpty){
            periodText.text = "Everyday"
        }else if(start != end){
            periodText.text = "\(start) to \(end)"
        }else if(start == end){
            periodText.text = start
        }
        if(gsRemindTime != ""){
            remindTimeText.text = gsRemindTime
        }else{
            remindTimeText.text = gsRemindTime
        }
        if (gsAlertDays == 0) {
            alertText.text = "On that day"
        }
        if (gsAlertDays == 1) {
            alertText.text = "1 day"
        }
        if (gsAlertDays == 3) {
            alertText.text = "3 days"
        }
        if (gsAlertDays == 7) {
            alertText.text = "7 days"
        }
        
        if(location2D.isEmpty){
            locationText.text = ""
        }else{
            print("location in else statement: \(locName)")
            locationText.text = locName
        }
        if(weatherSelected.isEmpty){
            weatherText.text = ""
        }else{
            var weather = ""
            let newline = "\n"
            for (key,value) in weatherSelected {
                if value != nil {
                weather = weather  + "\(value) \(key)" + newline
                }
            }
            weatherText.text = "We will inform you when \n" + weather
        }
        //end check and show
        
        //for test use
        print("gsSenario: \(gsSenario)")
        print("locaName:\(locName)")
        print("event title: \(eventTitle)")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let tap = UITapGestureRecognizer(target: self.view, action: Selector("endEditing:"))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    //IBAction to set alert days
    //use a choice sheet
    //1.click and jump from bottom
    //2.4 choice and 1 cancel
    //3.cancel will do nothing
    //4. if choose choice pass the parameters and show the choice
    @IBAction func setAlert(_ sender: Any) {
        let actionSheet=UIAlertController(title:"Alert days",message:"select the alert days before the event",preferredStyle:.actionSheet)
        let cancel=UIAlertAction(title:"Cancel",style:.cancel)
        let confirm1=UIAlertAction(title:"On that day",style:.default){ (act) -> Void in
            self.alertText.text = "On that day"
            gsAlertDays = 0
            NotificationCenter.default.removeObserver(self)
        }
        let confirm2=UIAlertAction(title:"1 day",style:.default){ (act) -> Void in
            self.alertText.text = "1 day"
            gsAlertDays = 1
            NotificationCenter.default.removeObserver(self)
        }
        let confirm3=UIAlertAction(title:"3 days",style:.default){ (act) -> Void in
            self.alertText.text = "3 days"
            gsAlertDays = 3
            NotificationCenter.default.removeObserver(self)
        }
        let confirm4=UIAlertAction(title:"7 days",style:.default){ (act) -> Void in
            self.alertText.text = "7 days"
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
    //end set alert days
    
    
    func createBtnFunc(){
        // the button create should be change to done- Congwei Ni
        //        print("event is not nil \(self.event != nil) when click done button")
        if(locName == ""){
            // alter
            print("no location")
            let alert = UIAlertController(title: "Warning!", message: "Please select your location!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alert, animated: true)
            return
        }else{
            eventTitle = titleText.text!
            var startDate: String = ""
            var endDate: String = ""
            if let validStart = gsPeriod["startDate"]{
                startDate = validStart
            }
            if let validEnd = gsPeriod["endDate"]{
                endDate = validEnd
            }
            if(globalEvent != nil){
                print("edit event")
                editEvent(event: globalEvent!, id: id, title: eventTitle, gsSenario: gsSenario, gsRemindTime: gsRemindTime, gsStartDate: startDate, gsEndDate: endDate, gsAlertDays: gsAlertDays, sunny: sunny, cloudy: cloudy, windy: windy, rainy: rainy, snow: snow, uvIndex: uvIndex, humidity: humidity, lat: location2D["lat"]!, long: location2D["long"]!, locName: locName)
            }else{
                print("insert event")
                if(user_id != 0){
                    // upload (add) this event into server
                    uploadEvent()
                    semaphore.wait()
                }else{
                    print("send failed, havent log in")
                }
                insertEvent(id: id, title: eventTitle, gsSenario: gsSenario, gsRemindTime: gsRemindTime, gsStartDate: startDate, gsEndDate: endDate, gsAlertDays: gsAlertDays, sunny: sunny, cloudy: cloudy, windy: windy, rainy: rainy, snow: snow, uvIndex: uvIndex, humidity: humidity, lat: location2D["lat"]!, long: location2D["long"]!, locName: locName)
                
            }
            
            //save to core data
            saveCoreData()
            
            // initialize all global data as default empty value
            initialData()
            
            // performSegue to event list view
            //performSegue(withIdentifier: "createToList", sender: nil)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "createToList"{
            self.createBtnFunc()
        }
    }
    
    //clear the data
    //after one event is create clear the data that the next event will use
    //set to empty structure and "" and nil accordingly
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
        location2D = [String : String]()
        locName = ""
        start = ""
        end = ""
        weatherSelected = [String:String]()
        globalEvent = nil
    }
    
    func assignData(){
        eventTitle = (event?.title)!
        //        gsSenario = ""
        gsRemindTime = (event?.gsRemindTime)!
        //        print("assign data gsStartDate: \(event?.gsStartDate)")
        //        print("assign data gsEndDate: \(event?.gsEndDate)")
        if((event?.gsStartDate)! != "" && (event?.gsEndDate)! != ""){
            gsPeriod["startDate"] = (event?.gsStartDate)!
            gsPeriod["endDate"] = (event?.gsEndDate)!
        }else{
            print("empty period")
            gsPeriod = [String:String]()
        }
        gsAlertDays = Int(exactly: (event?.gsAlertDays)!)!
        sunny = (event?.sunny)!
        cloudy = (event?.cloudy)!
        windy = (event?.windy)!
        rainy = (event?.rainy)!
        snow = (event?.snow)!
        uvIndex = (event?.uvIndex)!
        humidity = (event?.humidity)!
        location2D["lat"] = (event?.lat)!
        location2D["long"] = (event?.long)!
        locName = (event?.locName)!
        // 存的是unix还是YYYYMMDD？
        let formatter = DateFormatter.init()
        formatter.dateFormat = "yyyy-MM-dd"
        let doubleStart = Double((event?.gsStartDate)!)
        let doubleEnd = Double((event?.gsEndDate)!)
        if(doubleStart != nil && doubleEnd != nil){
            start = formatter.string(from: Date(timeIntervalSince1970: doubleStart!))
            end = formatter.string(from: Date(timeIntervalSince1970: doubleEnd!))
        }else{
            start = ""
            end = ""
        }
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
