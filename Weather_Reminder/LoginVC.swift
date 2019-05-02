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
    
    override func viewDidAppear(_ animated: Bool) {
        let tap = UITapGestureRecognizer(target: self.view, action: Selector("endEditing:"))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    
    @IBAction func authenticateUser(_ sender: Any) {
        // get email and password
        id_data = email.text ?? ""
        Password = password.text ?? ""
        print("password = "+Password)
        checkUser()
        // check users and wait response here.
        semaphore.wait()
        if loginIsSucc{
            UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
            UserDefaults.standard.set(user_id, forKey: "userID")
            UserDefaults.standard.set(user_token, forKey: "userToken")
            UserDefaults.standard.set(id_data, forKey: "userEmail")
            print("user logged in")
            let SettingVC = self.storyboard?.instantiateViewController(withIdentifier: "SettingVC") as! SettingVC
            self.definesPresentationContext = true
            SettingVC.modalPresentationStyle = .overCurrentContext
            self.present(SettingVC, animated: false, completion: nil)
            //
            
            // download all events when users login
            getEvents()
            semaphore.wait()
            for event in eventList{
                insertEvent(id: event.id, title: event.title, gsSenario: "", gsRemindTime: event.remindTime, gsStartDate: event.period.startDate ?? "", gsEndDate: event.period.endDate ?? "", gsAlertDays: event.alertDays, sunny: event.sunny, cloudy: event.cloudy, windy: event.windy, rainy: event.rainy, snow: event.snow, uvIndex: event.uvIndex, humidity: event.humidity, lat: event.loc.lat, long: event.loc.lon, locName: event.locName)
            }
            saveCoreData()
            readCoreData()
        }else{
            print("logged failed")
            let alert = UIAlertController(title: "Failed!", message: "Wrong email or password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alert, animated: true)
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
