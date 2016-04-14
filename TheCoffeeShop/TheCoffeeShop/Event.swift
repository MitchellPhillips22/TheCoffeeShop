//
//  TimeSlot.swift
//  TheCoffeeShop
//
//  Created by Mitchell Phillips on 4/11/16.
//  Copyright © 2016 Wasted Potential LLC. All rights reserved.
//

import Foundation
import Firebase

class Event {
    
    var eventRef = Firebase(url: "https://the-coffee-shop.firebaseio.com/event")
    
    var eventDate = NSDate()
    var key = ""
    var startDate = NSDate()
    var endDate = NSDate()
    var name = ""
    var ref: Firebase?
    
    init() {
        
    }
    
    init(key: String, dict: Dictionary<String, AnyObject>) {
        
        self.key = key
        
        if let eventDate = dict["eventDate"] as? NSDate {
            self.eventDate = eventDate
        }
        if let name = dict["name"] as? String {
            self.name = name
        }
        if let startTime = dict["startTime"] as? NSDate {
            self.startDate = startTime
        }
        if let endTime = dict["endTime"] as? NSDate {
            self.endDate = endTime
        }
        
         self.eventRef = self.eventRef.childByAppendingPath(self.key)
        
    }
    
    func save() {
        
        let dict: [String: AnyObject] = [
            "eventDate": self.eventDate,
            "name": self.name,
            "endTime": self.endDate,
            "startTime": self.startDate
        ]
        let firebaseEvent = self.eventRef.childByAutoId()
        firebaseEvent.setValue(dict)
    }
}