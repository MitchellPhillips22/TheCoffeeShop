//
//  EventsHomeViewController.swift
//  TheCoffeeShop
//
//  Created by Mitchell Phillips on 4/6/16.
//  Copyright © 2016 Wasted Potential LLC. All rights reserved.
//

import UIKit
import Firebase

class EventsHomeViewController: UIViewController {

    var openMicRef = Firebase(url: "https://the-coffee-shop.firebaseio.com/openmic")
    
    @IBAction func goBack(sender: UIButton) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    var openMic = OpenMic()
    
    override func viewDidLoad() {
        super.viewDidLoad()

     
        observeOpenMic()
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showOpenMicSegue" {
            let controller = segue.destinationViewController as! OpenMicTableViewController
            controller.openMic = self.openMic
        }
    }

    override func viewDidAppear(animated: Bool) {
        let value = UIInterfaceOrientation.Portrait.rawValue
        UIDevice.currentDevice().setValue(value, forKey: "orientation")
    }
    
    override func shouldAutorotate() -> Bool {
        if UIInterfaceOrientationIsPortrait(self.interfaceOrientation) {
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
