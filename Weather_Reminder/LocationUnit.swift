//
//  LocationUnit.swift
//  Weather_Reminder
//
//  Created by macbook on 2019/4/22.
//  Copyright © 2019 comp208.team4. All rights reserved.
//

import Foundation
import CoreLocation

typealias LocationResultBlock = (_ loc: CLPlacemark?, _ errorMsg: String?) -> ()

typealias LocationPointResultBlock = (_ loc: CLLocation?, _ errorMsg: String?) -> ()

class LocationUtil: NSObject {
    
    var isOnce: Bool = false
    
    var isLocation = false
    
    var locationCode : CLPlacemark?
    
    static let share = LocationUtil()
    
    lazy var locationM: CLLocationManager = {
        
        let locationM = CLLocationManager()
        locationM.requestAlwaysAuthorization()
        //improve the accuracy
        locationM.desiredAccuracy = kCLLocationAccuracyBest
        locationM.distanceFilter = kCLLocationAccuracyKilometer
        locationM.delegate = self
        
        // ask for authorization
        if #available(iOS 8.0, *) {
            guard let infoDic = Bundle.main.infoDictionary else { return locationM }

            let whenInUse = infoDic["NSLocationWhenInUseUsageDescription"]
            let always = infoDic["NSLocationAlwaysUsageDescription"]
            if always != nil {
                locationM.requestAlwaysAuthorization()
            }else if whenInUse != nil {
                locationM.requestWhenInUseAuthorization()
                let backModes = infoDic["UIBackgroundModes"]
                if backModes != nil {
                    let resultBackModel = backModes as! [String]
                    
                    if resultBackModel.contains("location") {
                        
                        if #available(iOS 9.0, *){
                            locationM.allowsBackgroundLocationUpdates = true
                        }
                    }
                }
            }else {
                print("error of authorization")
            }
            //reload the location every 100 m
            locationM.distanceFilter = 100
            
        }
        return locationM
        
    }()
    
    var resultBlock: LocationResultBlock?
    
    func getCurrentLocation(isOnce: Bool,resultBlock: @escaping LocationResultBlock) -> () {
        
        self.isOnce = isOnce
        self.resultBlock = resultBlock
        
        if locationCode != nil && self.resultBlock != nil {
            
            resultBlock(locationCode, nil)
        }
        if CLLocationManager.locationServicesEnabled() {
            if isOnce == true {
                if #available(iOS 9.0, *) {
                    locationM.requestLocation()
                } else {
                    locationM.startUpdatingLocation()
                }
            }else{
                locationM.startUpdatingLocation()
            }
        }else {
            if self.resultBlock != nil {
                self.resultBlock!(nil, "location serve is unavailability")
            }
        }
    }
    
    var resultPointBlock: LocationPointResultBlock?

    func getCurrentPointLocation(isOnce: Bool,resultPointBlock: @escaping LocationPointResultBlock) -> () {
        
        self.isOnce = isOnce
        self.resultPointBlock = resultPointBlock
        self.isLocation = true
        if CLLocationManager.locationServicesEnabled() {
            if isOnce == true {
                if #available(iOS 9.0, *) {
                    locationM.requestLocation()
                } else {
                    locationM.startUpdatingLocation()
                }
            }else{
                locationM.startUpdatingLocation()
            }
        }else {
            if self.resultPointBlock != nil {
                self.resultPointBlock!(nil, "location serve is unavailability")
            }
        }
    }
}

extension LocationUtil: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: "closeLoading"), object: nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let loc = locations.last else {
            if isLocation == false {
                if resultBlock != nil {
                    resultBlock!(nil, "no location information")
                }
                if resultPointBlock != nil {
                    resultPointBlock!(nil, "no location information")
                }
            }
            return
        }
        
        if resultPointBlock != nil {
            resultPointBlock!(loc, nil)
        }
        
        if isLocation == false {
            let geoCoder = CLGeocoder()
            
            geoCoder.reverseGeocodeLocation(loc, completionHandler: {(placemarks, error)->Void in
                var placemark:CLPlacemark!
                
                if error == nil && (placemarks?.count)! > 0 {
                    placemark = (placemarks?[0])! as CLPlacemark
                    self.locationCode = placemark
                    self.resultBlock!(placemark, nil)
                }
            })
            if isOnce {
                manager.stopUpdatingLocation()
            }
        }
    }
    
    private func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        guard let resultBlock2 = resultBlock else {return}
        
        switch status {
        case .denied:        resultBlock2(nil, "denide")
        case .restricted:    resultBlock2(nil, "limited")
        case .notDetermined: resultBlock2(nil, "no decition")
        default: print("nono")
        }
    }
}
