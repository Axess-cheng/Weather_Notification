//
//  TabBarVC.swift
//  Weather_Reminder
//
//  Created by Congwei Ni on 24/04/2019.
//  Copyright © 2019 comp208.team4. All rights reserved.
//

import UIKit

class TabBarVC: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        // Do any additional setup after loading the view.
    }
    

    // UITabBarDelegate
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print("Selected item: \(item.title!)")
    }
    
    // UITabBarControllerDelegate
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("Selected index: \(tabBarController.selectedIndex)")
        print("Selected view controller")
    }

}
