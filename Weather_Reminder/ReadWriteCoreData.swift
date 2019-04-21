//
//  ReadWriteCoreData.swift
//  Weather_Reminder
//
//  Created by Congwei Ni on 21/04/2019.
//  Copyright © 2019 comp208.team4. All rights reserved.
//

import Foundation
import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as! AppDelegate
var context: NSManagedObjectContext?

func readCoreData(){
    context = appDelegate.persistentContainer.viewContext
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Event")
    request.returnsObjectsAsFaults = false
    do{
        let eventsFetched = try context?.fetch(request)
        if (eventsFetched?.count)! > 0{
            events = eventsFetched as! [Event]
        }else{
            print("Nothing store in Core Data!")
        }
    }catch{
        print("Couldn't fetch result")
    }
}

func insertEvent(id: Int, title: String, gsSenario: String, gsRemindTime: String, gsStartDate: String, gsEndDate: String, gsAlertDays: Int, sunny: String, cloudy: String, windy: String, rainy: String, snow: String, uvIndex: String, humidity: String, lat: String, long: String){
    let newEvent = NSEntityDescription.insertNewObject(forEntityName: "Event", into: context!) as! Event
    newEvent.setValue(id, forKey: "id")
    newEvent.setValue(title, forKey: "title")
    newEvent.setValue(gsSenario, forKey: "gsSenario")
    newEvent.setValue(gsRemindTime, forKey: "gsRemindTime")
    newEvent.setValue(gsStartDate, forKey: "gsStartDate")
    newEvent.setValue(gsEndDate, forKey: "gsEndDate")
    newEvent.setValue(gsAlertDays, forKey: "gsAlertDays")
    newEvent.setValue(sunny, forKey: "sunny")
    newEvent.setValue(cloudy, forKey: "cloudy")
    newEvent.setValue(windy, forKey: "windy")
    newEvent.setValue(rainy, forKey: "rainy")
    newEvent.setValue(snow, forKey: "snow")
    newEvent.setValue(uvIndex, forKey: "uvIndex")
    newEvent.setValue(humidity, forKey: "humidity")
    newEvent.setValue(lat, forKey: "lat")
    newEvent.setValue(long, forKey: "long")
    events.append(newEvent)
}

func saveCoreData(){
    do {
        try context?.save()
    } catch {
        print("There was an error")
    }
}
