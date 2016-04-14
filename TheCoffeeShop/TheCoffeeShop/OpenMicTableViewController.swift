//
//  OpenMicViewController.swift
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
    
    var arrayOfTimeSlots = [Timeslot]()
    var arrayOfTimes = ["9:00-9:15","9:15-9:30","9:30-9:45","9:45-10:00","10:00-10:15","10:15-10:30","10:30-10:45","10:45-11:00","11:00-11:15","11:15-11:30","11:30-11:45","11:45-12:00"]

    @IBOutlet weak var tableView: UITableView!
    
    var dateFormatter: NSDateFormatter = {
        var formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        return formatter
    }()
    var arrayOfStrings = [String]()
    
    @IBAction func goHome(sender: UIButton) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(arrayOfTimeSlots.count)
        observeTimeSlots()
        
        print(arrayOfTimeSlots.count)
 //       seedTimeSlots()
        print(arrayOfTimeSlots.count)

    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfTimeSlots.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let t = arrayOfTimeSlots[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("TimeCell", forIndexPath: indexPath) as! OpenMicTableViewCell
        cell.timeLabel.text = t.time
        cell.artistLabel.text = t.artist
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let t = arrayOfTimeSlots[indexPath.row]
        self.showAlert(t)
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
    //MARK: - Alert set up

    func showAlert(timeslot: Timeslot) {
        let alertController = UIAlertController(title: "Add artist", message: "Type artist name", preferredStyle: .Alert)
        let addAction = UIAlertAction(title: "Add", style: .Default) {
            (addAction) -> Void in
            if let textField = alertController.textFields?.first {
                if let artistName = textField.text {
                    timeslot.ref?.updateChildValues(["artist": artistName])
                }
                
                
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .Default) {
            (cancelAction) -> Void in
        }
        alertController.addTextFieldWithConfigurationHandler { (textField) -> Void in
        }
        alertController.addAction(cancelAction)
        alertController.addAction(addAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    //MARK: - Firebase set up
    func seedTimeSlots() {
        
        
        //Check if the current event has seeded time slots
    
            
            //If the start date of event is before the end date
            for time in arrayOfTimes {
                
                let slot = Timeslot()
                slot.time = time
                slot.artist = "Click here to reserve this slot"
                slot.save()
                
                
            }
        
        
        //Creates and saves new time slots for every 15 minutes of event duration
    }
    func observeTimeSlots() {
        
        self.timeSlotRef.observeEventType(.Value, withBlock: { snapshot in
            
            print(snapshot.value)
            
            self.arrayOfTimeSlots = []
            
            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                
                for snap in snapshots {
                    
                    if let dict = snap.value as? Dictionary<String, AnyObject> {
                        
                        
                        let key = snap.key
                        let timeSlot = Timeslot(key: key, dict: dict)
                        timeSlot.ref = Firebase(url: "\(self.timeSlotRef)/\(key)")
                        self.arrayOfTimeSlots.append(timeSlot)
                        
                        print(self.arrayOfTimeSlots.count)

                        self.tableView.reloadData()
                    }
                    
                }
            }
            
        })
        
        
    }
    
    
}
