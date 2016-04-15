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
    
    var eventDescription = ""
    var key = ""
    var name = ""
    var ref: Firebase?
    
    init() {
        
    }
    
    init(key: String, dict: Dictionary<String, AnyObject>) {
        
        self.key = key
        
        if let eventDescription = dict["eventDescription"] as? String {
            self.eventDescription = eventDescription
        }
        if let name = dict["name"] as? String {
            self.name = name
        }
         self.eventRef = self.eventRef.childByAppendingPath(self.key)
        
    }
    
    func save() {
        
        let dict: [String: AnyObject] = [
            "eventDescription": eventDescription,
            "name": self.name
        ]
        let firebaseEvent = self.eventRef.childByAutoId()
        firebaseEvent.setValue(dict)
    }
}