//
//  TimeSlot.swift
//  TheCoffeeShop
//
//  Created by Mitchell Phillips on 4/11/16.
//  Copyright © 2016 Wasted Potential LLC. All rights reserved.
//

import Foundation
import Firebase

class TimeSlot {
    
    var timeSlotRef = Firebase(url: "https://the-coffee-shop.firebaseio.com/timeslot")
    
    var key = ""
    var startTime = NSDate()
    var endTime = NSDate()
    var name = ""
    
    init() {
        
    }
    
    init(key: String, dict: Dictionary<String, AnyObject>) {
        
        self.key = key
        
        if let name = dict["name"] as? String {
            self.name = name
        }
        if let startTime = dict["startTime"] as? NSDate {
            self.startTime = startTime
        }
        if let endTime = dict["endTime"] as? NSDate {
            self.endTime = endTime
        }
        
         self.timeSlotRef = self.timeSlotRef.childByAppendingPath(self.key)
        
    }
    
    func save() {
        
        let dict: [String: AnyObject] = [
            "name": self.name,
            "endTime": self.endTime,
            "startTime": self.startTime
        ]
        let firebaseTimeSlot = self.timeSlotRef.childByAutoId()
        firebaseTimeSlot.setValue(dict)
    }
}