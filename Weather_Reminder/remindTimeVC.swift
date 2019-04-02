//
//  remindTimeVC.swift
//  Weather_Reminder
//
//  Created by allen on 2019/4/1.
//  Copyright © 2019 comp208.team4. All rights reserved.
//

import UIKit

class remindTimeVC: UIViewController {

    var time = String()
    
    @IBOutlet weak var timePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timePicker.addTarget(self, action: #selector(chooseDate( _:)), for: UIControl.Event.valueChanged)
        time = "8:00"
        gsRemindTime = time
    }
    
    @objc func chooseDate(_ datePicker:UIDatePicker){
        let formatter = DateFormatter.init()
        formatter.dateFormat = "HH:mm"
        time = formatter.string(from: datePicker.date)
        gsRemindTime = time
    }

    
    @IBAction func doneBtn(_ sender: Any) {
        self.performSegue(withIdentifier: "remindTimeDone", sender: nil)
    }

}
