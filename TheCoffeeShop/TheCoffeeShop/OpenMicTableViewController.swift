//
//  OpenMicTableViewController.swift
//  TheCoffeeShop
//
//  Created by Mitchell Phillips on 4/5/16.
//  Copyright © 2016 Wasted Potential LLC. All rights reserved.
//

import UIKit
import Firebase

class OpenMicTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var ref = Firebase(url: "https://the-coffee-shop.firebaseio.com")
    var timeSlotRef = Firebase(url: "https://the-coffee-shop.firebaseio.com/timeslot")
    
    var arrayOfTimeSlots = [TimeSlot]()
    
    var dateFormatter: NSDateFormatter = {
        var formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        return formatter
    }()


    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK: - Force portrait orientation
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
    
    //MARK: - Firebase set up
    func seedTimeSlot() {
        
        let t = TimeSlot()
        
        t.name = ""
        t.startTime = NSDate()
        t.endTime = NSDate()
        
        t.save()
        
    }

    func addObserver() {
        
        self.timeSlotRef.observeEventType(.Value, withBlock: { snapshot in
            
            print(snapshot.value)
            
            self.arrayOfTimeSlots = []
            
            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                
                for snap in snapshots {
                    
                    if let dict = snap.value as? Dictionary<String, AnyObject> {
                        
                        let key = snap.key
                        let timeSlot = TimeSlot(key: key, dict: dict)
                        self.arrayOfTimeSlots.insert(timeSlot, atIndex: 0)
                    }

                }
            }
        })
    }
    func createTimeSlot(startDateString: String, endDateString: String, name: String) -> TimeSlot {
        
        let slot = TimeSlot()
        
        if let theDate = dateFormatter.dateFromString(startDateString) {
            slot.startTime = theDate
            print(theDate)
        } else {
            print("Couldnt parse the date")
        }
        
        if let theDate = dateFormatter.dateFromString(endDateString) {
            slot.endTime = theDate
            print(theDate)
        } else {
            print("Couldnt parse the date")
        }
        
        slot.name = name
        
        return slot
    }

    //MARK: Set up table view 
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfTimeSlots.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("timeSlotCell", forIndexPath: indexPath) as! OpenMicTableViewCell
        return cell 
    }
    
}
