//
//  PeriodVC.swift
//  Weather_Reminder
//
//  Created by allen on 2019/4/1.
//  Copyright © 2019 comp208.team4. All rights reserved.
//

import UIKit

class PeriodVC: UIViewController {

    @IBOutlet weak var pickStart: UIDatePicker!
    @IBOutlet weak var pickEnd: UIDatePicker!
    @IBOutlet weak var ifEveryday: UISwitch!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    
    var now = NSDate()
    var startDate = String()
    var endDate = String()
    
    
    override func viewDidLoad() {
        let nowTimeStamp = now.timeIntervalSince1970
        startDate = String(Int(nowTimeStamp))
        endDate = String(Int(nowTimeStamp))
        super.viewDidLoad()
        pickStart.addTarget(self, action: #selector(chooseStartDate( _:)), for: UIControl.Event.valueChanged)
        pickEnd.addTarget(self, action: #selector(chooseEndDate( _:)), for: UIControl.Event.valueChanged)
    }
    
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
    
    @IBAction func periodDone(_ sender: Any) {
        self.performSegue(withIdentifier: "periodDone", sender: nil)
    }

}
