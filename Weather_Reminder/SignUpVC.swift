//
//  SignUpVC.swift
//  Weather_Reminder
//
//  Created by Congwei Ni on 24/04/2019.
//  Copyright © 2019 comp208.team4. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var confirmField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUpBtn(_ sender: Any) {
        print(passwordField.text!)
        if passwordField.text == confirmField.text {
            let mailPattern = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"
            let matcher = MyRegex(mailPattern)
            let emailAdd = emailField.text!
            if matcher.match(input: emailAdd) {
                // need to test with real iphone.
                //addUser(emailAdd: emailField.text!, password: passwordField.text!)
//                id_data = emailAdd
//                Password = passwordField.text!
                print("add user")
                
                // todo: jump to user info page
                UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
                let SettingVC = self.storyboard?.instantiateViewController(withIdentifier: "SettingVC") as! SettingVC
                self.definesPresentationContext = true
                SettingVC.modalPresentationStyle = .overCurrentContext
                self.present(SettingVC, animated: false, completion: nil)
                
                
                // check user and get some info.
//                checkUser()
//                UserDefaults.standard.set(user_id, forKey: "userID")
//                UserDefaults.standard.set(user_token, forKey: "userToken")
            }else{
                print("wrong email")
            }
            
        }else{
            // todo: alert
            print("wrong password and confirm password")
            
        }
    }
    
    @IBAction func haveAccountBtn(_ sender: Any) {
        let SettingVC = self.storyboard?.instantiateViewController(withIdentifier: "SettingVC") as! SettingVC
        self.definesPresentationContext = true
        SettingVC.modalPresentationStyle = .overCurrentContext
        self.present(SettingVC, animated: false, completion: nil)
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
