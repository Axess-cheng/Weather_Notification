//
//  PeriodVC.swift
//  Weather_Reminder
//
//  Created by allen on 2019/4/1.
//  Copyright © 2019 comp208.team4. All rights reserved.
//
//This class is to control the view of select the period
//and pass paramters to createEventVC
import UIKit

class PeriodVC: UIViewController {

    //The var from UI
    @IBOutlet weak var pickStart: UIDatePicker!
    @IBOutlet weak var pickEnd: UIDatePicker!
    @IBOutlet weak var ifEveryday: UISwitch!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    
    var now = NSDate()//now time
    var startDate = String()//record strat
    var endDate = String()//record end
    
    
    override func viewDidLoad() {
        let nowTimeStamp = now.timeIntervalSince1970
        startDate = String(Int(nowTimeStamp))//get time stamp
        endDate = String(Int(nowTimeStamp))
        super.viewDidLoad()
        pickStart.addTarget(self, action: #selector(chooseStartDate( _:)), for: UIControl.Event.valueChanged)
        pickEnd.addTarget(self, action: #selector(chooseEndDate( _:)), for: UIControl.Event.valueChanged)
    }
    
    //swithc button of evenry dat option
    //1.check the switch button
    //2.control the show of start and end of the period selector
    //3.show if every day not select else show
    //4.send parameters to createEventVC
    //5.if switch is on send everyday
    //6.if is off, send the two time in time stamp and yyyy-MM-dd format seperately
    @IBAction func switchBtn(_ sender: Any) {
        if ifEveryday.isOn {
            gsPeriod = [String:String]()
            label1.isHidden = true
            label2.isHidden = true
            pickStart.isHidden = true
            pickEnd.isHidden = true
        }else{
            gsPeriod["startDate"] = String(Int(now.timeIntervalSince1970))
            gsPeriod["endDate"] = String(Int(now.timeIntervalSince1970))
            label1.isHidden = false
            label2.isHidden = false
            pickStart.isHidden = false
            pickEnd.isHidden = false
            view1.isHidden = false
            view2.isHidden = false
            view3.isHidden = false
        }
    }
    
    //two UIDatePicker function is to control the format of time
    //format should be "yyyy-MM-dd"
    @objc func chooseStartDate(_ datePicker:UIDatePicker){
        startDate = String(Int(datePicker.date.timeIntervalSince1970))
        gsPeriod["startDate"] = startDate
        let formatter = DateFormatter.init()
        formatter.dateFormat = "yyyy-MM-dd"
        start = formatter.string(from: datePicker.date)
    }
    
    @objc func chooseEndDate(_ datePicker:UIDatePicker){
        endDate = String(Int(datePicker.date.timeIntervalSince1970))
        gsPeriod["endDate"] = endDate
        let formatter = DateFormatter.init()
        formatter.dateFormat = "yyyy-MM-dd"
        end = formatter.string(from: datePicker.date)
    }
    
    //perform segue
    @IBAction func periodDone(_ sender: Any) {
        self.performSegue(withIdentifier: "periodDone", sender: nil)
    }

}
