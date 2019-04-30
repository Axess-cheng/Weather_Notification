//
//  UserInfoVC.swift
//  Weather_Reminder
//
//  Created by Congwei Ni on 24/04/2019.
//  Copyright © 2019 comp208.team4. All rights reserved.
//

import UIKit

class UserInfoVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logoutUser(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "isUserLoggedIn")
        let SettingVC = self.storyboard?.instantiateViewController(withIdentifier: "SettingVC") as! SettingVC
        self.definesPresentationContext = true
        SettingVC.modalPresentationStyle = .overCurrentContext
        self.present(SettingVC, animated: false, completion: nil)
        // clear events
        if(events.count > 0){
            var ii = events.count
            for _ in Range(0..<events.count) {
                print(events.count)
                ii -= 1
                let itemToRemove = events[ii]
                context?.delete(itemToRemove)
                events.remove(at: ii)
                saveCoreData()
            }
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
