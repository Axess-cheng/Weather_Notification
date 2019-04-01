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
    }
    
    func datePickerDateChanged(paramDatePicker: UIDatePicker){
        let formatter = DateFormatter.init()
        formatter.dateFormat = "HH : mm"
        time = formatter.string(from: paramDatePicker.date)
        print(time)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "remindTimeDone"{
            let createEvent = segue.destination as! createEventVC
            createEvent.remindTime = time
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
