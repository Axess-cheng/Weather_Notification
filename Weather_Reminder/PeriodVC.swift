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
    
    var startDate = String()
    var endDate = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickStart.addTarget(self, action: #selector(chooseStartDate( _:)), for: UIControl.Event.valueChanged)
        pickEnd.addTarget(self, action: #selector(chooseEndDate( _:)), for: UIControl.Event.valueChanged)
        gsEveryday = false
    }
    
    @IBAction func switchBtn(_ sender: Any) {
        if ifEveryday.isOn {
            gsEveryday = true
            label1.isHidden = true
            label2.isHidden = true
            pickStart.isHidden = true
            pickEnd.isHidden = true
        }else{
            gsEveryday = false
            label1.isHidden = false
            label2.isHidden = false
            pickStart.isHidden = false
            pickEnd.isHidden = false
        }
    }
    
    
    @objc func chooseStartDate(_ datePicker:UIDatePicker){
        let formatter = DateFormatter.init()
        formatter.dateFormat = "yyyyMMdd"
        startDate = formatter.string(from: datePicker.date)
        gsPStart = startDate
    }
    
    @objc func chooseEndDate(_ datePicker:UIDatePicker){
        let formatter = DateFormatter.init()
        formatter.dateFormat = "yyyyMMdd"
        endDate = formatter.string(from: datePicker.date)
        gsPEnd = endDate
    }

    //override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //    if segue.identifier == "periodDone"{
    //        let createEvent = segue.destination as! createEventVC
    //        createEvent.pStart = startDate ?? ""
    //        createEvent.pEnd = endDate ?? ""
    //    }
    //}
    
    @IBAction func periodDone(_ sender: Any) {
        self.performSegue(withIdentifier: "periodDone", sender: nil)
    }

}
