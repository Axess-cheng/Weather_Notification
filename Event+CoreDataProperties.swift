//
//  Event+CoreDataProperties.swift
//  Weather_Reminder
//
//  Created by Congwei Ni on 21/04/2019.
//  Copyright © 2019 comp208.team4. All rights reserved.
//
//

import Foundation
import CoreData


extension Event {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Event> {
        return NSFetchRequest<Event>(entityName: "Event")
    }

    @NSManaged public var id: Int16
    @NSManaged public var title: String?
    @NSManaged public var gsSenario: String?
    @NSManaged public var gsRemindTime: String?
    @NSManaged public var gsStartDate: String?
    @NSManaged public var gsEndDate: String?
    @NSManaged public var gsAlertDays: Int16
    @NSManaged public var sunny: String?
    @NSManaged public var cloudy: String?
    @NSManaged public var windy: String?
    @NSManaged public var rainy: String?
    @NSManaged public var snow: String?
    @NSManaged public var uvIndex: String?
    @NSManaged public var humidity: String?
    @NSManaged public var long: String?
    @NSManaged public var lat: String?

}
