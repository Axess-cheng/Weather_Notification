//
//  selectSenario.swift
//  Weather_Reminder
//
//  Created by allen on 2019/3/31.
//  Copyright © 2019 comp208.team4. All rights reserved.
//

import UIKit

class selectSenario: UIViewController, UIPickerViewDelegate,UIPickerViewDataSource {

    @IBOutlet weak var pickSenario: UIPickerView!
    
    var senario:String!
    var senarioData:[String] =  [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.pickSenario.delegate = self
        self.pickSenario.dataSource = self
        pickSenario.selectRow(0, inComponent: 0, animated: true)
        senarioData = ["Other","Bring umbrella","Travel","Crop reminder","Disease alerting"]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return senarioData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return senarioData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        senario = senarioData[row]
    }

    @IBAction func nextBtn(_ sender: Any) {
        self.performSegue(withIdentifier: "senarioToCreateEvent", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "senarioToCreateEvent"{
            let createEvent = segue.destination as! createEventVC
            if senario == nil{
                senario = "Other"
            }
            gsSenario = senario
        }
    }

}
