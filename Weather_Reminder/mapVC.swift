//
//  mapVC.swift
//  Weather_Reminder
//
//  Created by allen on 2019/3/31.
//  Copyright © 2019 comp208.team4. All rights reserved.
//

import UIKit

class mapVC: UIViewController,UITableViewDelegate,UITableViewDataSource{
 @IBOutlet weak var text: UITextField!
    @IBOutlet weak var currentLoctionLabel: UILabel!
    @IBOutlet weak var tblPlaces: UITableView!
    @IBOutlet weak var currentLocationButton: UIButton!
    var resultsArray:[Dictionary<String, AnyObject>] = Array()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        text.addTarget(self, action: #selector(searchPlaceFromGoogle(_:)), for: .editingChanged)
        currentLocationButton.addTarget(self, action: #selector(getMessage(_:)), for: .touchUpInside)
        tblPlaces.estimatedRowHeight = 44.0
        tblPlaces.dataSource = self
        tblPlaces.delegate = self
        
    }
    
    @IBAction func getMessage(_ sender: Any) {
        
        LocationUtil.share.getCurrentLocation(isOnce: false) { (loc, errorMsg) -> () in
            if errorMsg == nil {
                self.currentLoctionLabel.text = String(format: "%@", (loc?.name)!)
            }
        }
        print("select the button")
        
        
    }
    
    
    //MARK:- UITableViewDataSource and UItableViewDelegates
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "placecell")
        if let lblPlaceName = cell?.contentView.viewWithTag(102) as? UILabel {
            
            let place = self.resultsArray[indexPath.row]
            lblPlaceName.text = "\(place["name"] as! String) \(place["formatted_address"] as! String)"
        }
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let place = self.resultsArray[indexPath.row]
        if let locationGeometry = place["geometry"] as? Dictionary<String, AnyObject> {
            if let location = locationGeometry["location"] as? Dictionary<String, AnyObject> {
                if let latitude = location["lat"] as? Double {
                    if let longitude = location["lng"] as? Double {
                        UIApplication.shared.open(URL(string: "https://www.google.com/maps/@\(latitude),\(longitude),16z")!, options: [:])
                    }
                }
            }
        }
    }
    
    
    
    @objc func searchPlaceFromGoogle(_ textField:UITextField) {
        
        if let searchQuery = textField.text {
            var strGoogleApi = "https://maps.googleapis.com/maps/api/place/textsearch/json?query=\(searchQuery)&key= AIzaSyCRI17aiHDgxNUUCz1cnprifJh8rTpZQuw"
            strGoogleApi = strGoogleApi.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            
            var urlRequest = URLRequest(url: URL(string: strGoogleApi)!)
            urlRequest.httpMethod = "GET"
            let task = URLSession.shared.dataTask(with: urlRequest) { (data, resopnse, error) in
                if error == nil {
                    
                    if let responseData = data {
                        let jsonDict = try? JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                        
                        if let dict = jsonDict as? Dictionary<String, AnyObject>{
                            
                            if let results = dict["results"] as? [Dictionary<String, AnyObject>] {
                                print("json == \(results)")
                                self.resultsArray.removeAll()
                                for dct in results {
                                    self.resultsArray.append(dct)
                                }
                                
                                DispatchQueue.main.async {
                                    self.tblPlaces.reloadData()
                                }
                                
                            }
                        }
                        
                    }
                } else {
                    //we have error connection google api
                }
            }
            task.resume()
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
