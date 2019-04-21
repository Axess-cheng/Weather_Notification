//
//  mapVC.swift
//  Weather_Reminder
//
//  Created by allen on 2019/3/31.
//  Copyright © 2019 comp208.team4. All rights reserved.
//

import UIKit

class mapVC: UIViewController, UITextFieldDelegate {
 @IBOutlet weak var text: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        text.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchPlaceFromGoogelAPI(place: textField.text!)
        return true
    }
   
    func searchPlaceFromGoogelAPI(place: String){
       var strGoogleAPI = ""
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
