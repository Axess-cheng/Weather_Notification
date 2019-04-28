//
//  LoginVC.swift
//  Weather_Reminder
//
//  Created by Congwei Ni on 24/04/2019.
//  Copyright © 2019 comp208.team4. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func authenticateUser(_ sender: Any) {
        if email.text == "test" && password.text == "test"{
            UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
            
            print("user logged in")
            let SettingVC = self.storyboard?.instantiateViewController(withIdentifier: "SettingVC") as! SettingVC
            self.definesPresentationContext = true
            SettingVC.modalPresentationStyle = .overCurrentContext
            self.present(SettingVC, animated: false, completion: nil)
            
        }
    }
    

    @IBAction func signupBtn(_ sender: Any) {
        let SignupVC = self.storyboard?.instantiateViewController(withIdentifier: "signupVC") as! SignUpVC
        self.definesPresentationContext = true
        SignupVC.modalPresentationStyle = .overCurrentContext
        self.present(SignupVC, animated: false, completion: nil)
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
