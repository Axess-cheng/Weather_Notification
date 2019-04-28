//
//  ConnectServer.swift
//  Weather_Reminder
//
//  Created by allen on 2019/4/27.
//  Copyright © 2019 comp208.team4. All rights reserved.
//

import Foundation

let id_field = "email"
let id_data = "axess971230@gmail.com"
let id_type = "s"
let device_token = "4d5ce7cf5539ab82dfc93e39ed125308c7232e64b1b61a4e1ad810600ec6dd13"
let password = "123abc"
let SUPERTOKEN = "XvgcNiTgSPABTVqf"

func checkUser(){
    var isSucess = false
    
    var url = URL(string: "http://142.93.34.33/check_user.php?id_field=\(id_field)&id_data=\(id_data)&id_type=\(id_type)&device_token=\(device_token)&password=\(password)&token=\(SUPERTOKEN)")!
    var request = URLRequest(url: url)
    
    request.httpMethod = "GET"
    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    
    DispatchQueue.main.async {
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            guard let data2 = data, error == nil else{ return }
            
            let responseString = String(data: data2, encoding: .utf8)
            print("responseString = \(String(describing: responseString))")
            
            // Todo: check if success
            
            
            do{
                let jsonResponse = try JSONSerialization.jsonObject(with: data2, options: JSONSerialization.ReadingOptions()) as? NSDictionary
            }catch let err {
                print("error here ", err)
            }
        }
        task.resume()
    }
}
