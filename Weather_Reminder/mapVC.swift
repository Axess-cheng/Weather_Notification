//
//  mapVC.swift
//  Weather_Reminder
//
//  Created by allen on 2019/3/31.
//  Copyright © 2019 comp208.team4. All rights reserved.
//

import UIKit
import MapKit

class mapVC: UIViewController, UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var text: UITextField!
    @IBOutlet weak var useCurrentLocation: UIButton!
    @IBOutlet weak var tblPlaces: UITableView!
    var lng = String()
    var lat = String()
    var currentName = String()
    var resultsArray:[Dictionary<String, AnyObject>] = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view, typically from a nib.
        text.addTarget(self, action: #selector(searchPlaceFromGoogle(_:)), for: .editingChanged)
        
        useCurrentLocation.addTarget(self, action: #selector(useCurrentLocation(_:)), for: .touchUpInside)
        tblPlaces.estimatedRowHeight = 44.0
        tblPlaces.dataSource = self
        tblPlaces.delegate = self
        
        
        var latitude = Double()
        var longitude = Double()
        LocationUtil.share.getCurrentPointLocation(isOnce: false) { (loc, errorMsg) in
            if errorMsg == nil {
                
                self.lat = String(format: "%f,%f", (loc?.coordinate.latitude)!)
                self.lng = String(format: "%f,%f", (loc?.coordinate.longitude)!)
                latitude = (loc?.coordinate.latitude)!
                longitude = (loc?.coordinate.longitude)!
                location2D["lat"] = String(latitude)
                location2D["long"] = String(longitude)
                let location = CLLocation(latitude: latitude, longitude: longitude)
                self.fetchCityAndCountry(from: location) { city, country, error in
                    guard let validCity = city, let validCountry = country, error == nil else { return }
                    
                    
                    locName = "\(validCity)"
                    //print("current locName is \(locName)")
                    //                    print("current lat is \(location2D["lat"])")
                    //                    print("current long is \(location2D["long"])")
                }
            }
        }
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let tap = UITapGestureRecognizer(target: self.view, action: Selector("endEditing:"))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    func fetchCityAndCountry(from location: CLLocation, completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            completion(placemarks?.first?.locality,
                       placemarks?.first?.country,
                       error)
        }
    }
    
    
    
    
    @IBAction func useCurrentLocation(_ sender: Any){

        
            performSegue(withIdentifier: "fromMapToCreatEvent", sender: nil)
 
  
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
                        
                        location2D["long"] = String(longitude)
                        location2D["lat"] = String(latitude)
                        //print(location2D["long"])
                        locName = "\(place["name"] as! String)"
                        performSegue(withIdentifier: "fromMapToCreatEvent", sender: nil)
                        
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
