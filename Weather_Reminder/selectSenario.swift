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
    
    var senario = String()
    var senarioData:[String] =  [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.pickSenario.delegate = self
        self.pickSenario.dataSource = self
        
        senarioData = ["Bring umbrella","Travel","Crop reminder","Disease alerting"]
        // Do any additional setup after loading the view.
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
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        senario = senarioData[row]
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "senarioToCreateEvent"{
            let createEvent = segue.destination as! createEventVC
            createEvent.senario = senario
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
