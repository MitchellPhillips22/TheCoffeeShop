//
//  Timeslot.swift
//  TheCoffeeShop
//
//  Created by Mitchell Phillips on 4/13/16.
//  Copyright © 2016 Wasted Potential LLC. All rights reserved.
//

import Foundation
import Firebase

class Timeslot {
    
    var timeslotRef = Firebase(url: "https://the-coffee-shop.firebaseio.com/timeslot")
    
    var key: String = ""
    var artist: String = ""
    var time: String = ""
    var eventKey: String = ""
    var ref: Firebase?
    
    init() {
        
    }
    init(key: String, dict: Dictionary<String, AnyObject>) {
        
        self.key = key
        
        if let artist = dict["artist"] as? String {
            self.artist = artist
        }
        if let eventKey = dict["eventKey"] as? String {
            self.eventKey = eventKey
        }
        if let time = dict["time"] as? String {
            self.time = time 
        }
        
        self.timeslotRef = timeslotRef.childByAppendingPath(self.key)
    }
    
    func save() {
        
        let dict: [String: AnyObject] = [
            "artist": self.artist,
            "time": self.time, 
            "eventKey": self.eventKey
        ]
        let firebaseTimeSlot = self.timeslotRef.childByAutoId()
        firebaseTimeSlot.setValue(dict)
    }

}