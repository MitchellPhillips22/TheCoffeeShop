//
//  HomeViewController.swift
//  TheCoffeeShop
//
//  Created by Mitchell Phillips on 4/5/16.
//  Copyright © 2016 Wasted Potential LLC. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {

    var codeRef = Firebase(url: "https://the-coffee-shop.firebaseio.com/code")
    var openMicRef = Firebase(url: "https://the-coffee-shop.firebaseio.com/openmic")
    var openMic = OpenMic()
    override func viewDidLoad() {
        super.viewDidLoad()
//       seedAuthCode()
    }
    override func viewDidAppear(animated: Bool) {
        let value = UIInterfaceOrientation.Portrait.rawValue
        UIDevice.currentDevice().setValue(value, forKey: "orientation")
    }
    
    override func shouldAutorotate() -> Bool {
        if UIInterfaceOrientationIsLandscape(self.interfaceOrientation) {
            return true
        }
        return false
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return .Portrait
    }
    
    override func preferredInterfaceOrientationForPresentation() -> UIInterfaceOrientation {
        return .Portrait
    }

    func seedAuthCode() {
        let c = AuthCode()
        
        c.code = "12345"
        c.save()
    }
    func observeOpenMic() {
        
        self.openMicRef.observeEventType(.Value, withBlock: { snapshot in
            
            print(snapshot.value)
            
            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                
                for snap in snapshots {
                    
                    if let dict = snap.value as? Dictionary<String, AnyObject> {
                        
                        
                        let key = snap.key
                        
                        let openMic = OpenMic(key: key, dict: dict)
                        
                        openMic.ref = Firebase(url: "\(self.openMicRef)/\(key)")
                        
                        self.openMic = openMic
                    }
                    
                }
            }
            
        })
    }
}

