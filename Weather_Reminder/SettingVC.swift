//
//  SettingVC.swift
//  Weather_Reminder
//
//  Created by Congwei Ni on 24/04/2019.
//  Copyright © 2019 comp208.team4. All rights reserved.
//

import UIKit

class SettingVC: UIViewController {
    var login = true;
    @IBOutlet weak var userInfoView: UIView!
    @IBOutlet weak var loginView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(login == true){
            loginView.alpha = 1
            userInfoView.alpha = 0
        }else{
            userInfoView.alpha = 1
            loginView.alpha = 0
        }
        // Do any additional setup after loading the view.
    }
    



}
