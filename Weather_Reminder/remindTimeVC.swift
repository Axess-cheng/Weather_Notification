//
//  remindTimeVC.swift
//  Weather_Reminder
//
//  Created by allen on 2019/4/1.
//  Copyright © 2019 comp208.team4. All rights reserved.
//
//This class control the view of selet the remind time.
//and pass the globel parameters to createEventVC
import UIKit

class remindTimeVC: UIViewController {

    var time = String()// record the time
    
    @IBOutlet weak var timePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timePicker.addTarget(self, action: #selector(chooseDate( _:)), for: UIControl.Event.valueChanged)
        time = "8:00"//default value of time
        gsRemindTime = time
    }
    
    //this function is to set the format of the time
    //1.the format is "HH:mm"
    //2.pass the time String to createEventVC
    @objc func chooseDate(_ datePicker:UIDatePicker){
        let formatter = DateFormatter.init()
        formatter.dateFormat = "HH:mm"
        time = formatter.string(from: datePicker.date)
        gsRemindTime = time
    }

    //perform segue
    @IBAction func doneBtn(_ sender: Any) {
        self.performSegue(withIdentifier: "remindTimeDone", sender: nil)
    }

}
