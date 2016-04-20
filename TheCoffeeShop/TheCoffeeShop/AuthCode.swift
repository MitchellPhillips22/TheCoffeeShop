//
//  AuthCode.swift
//  TheCoffeeShop
//
//  Created by Mitchell Phillips on 4/17/16.
//  Copyright © 2016 Wasted Potential LLC. All rights reserved.
//

import Foundation
import Firebase

class AuthCode {
    //MARK: - Variables
    var codeRef = Firebase(url: "https://the-coffee-shop.firebaseio.com/code")
    var key = ""
    var code = ""
    var ref: Firebase? 
    //MARK: - Initializers
    init() {
        
    }
    init(key: String, dict: Dictionary<String, AnyObject>) {
        
        self.key = key 
        
        if let code = dict["code"] as? String {
            self.code = code
            
        self.codeRef = codeRef.childByAppendingPath(self.key)
        }
    }
    //MARK: - Save 
    func save() {
        
        let dict: [String: AnyObject] = [
            "code": self.code
        ]
        let firebaseAuthCode = self.codeRef.childByAutoId()
        firebaseAuthCode.setValue(dict)
    }

}