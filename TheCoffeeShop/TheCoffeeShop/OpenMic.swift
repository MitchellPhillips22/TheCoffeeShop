//
//  OpenMic.swift
//  TheCoffeeShop
//
//  Created by Mitchell Phillips on 4/14/16.
//  Copyright © 2016 Wasted Potential LLC. All rights reserved.
//

import Foundation
import Firebase
class OpenMic {
 
    var openMicRef = Firebase(url: "https://the-coffee-shop.firebaseio.com/openmic")
    var hasPopulated = false
    var key = ""
    var ref: Firebase?
    
    init() {
        
    }
    
    init(key: String, dict: Dictionary<String, AnyObject>) {
        
        self.key = key
        
        if let hasPopulated = dict["hasPopulated"] as? Bool {
            self.hasPopulated = hasPopulated
        }
        self.openMicRef = openMicRef.childByAppendingPath(self.key)
    }
    
    func save() {
        
        let dict: [String: AnyObject] = [
            "hasPopulated": self.hasPopulated
        ]
        let firebaseOpenMic = self.openMicRef.childByAutoId()
        firebaseOpenMic.setValue(dict)
    }
    
}