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
    var openMicRef = Firebase(url: "https://the-coffee-shop.firebaseio.com/openmic")
    var codeRef = Firebase(url: "https://the-coffee-shop.firebaseio.com/code")
    var observerHasRun = false
    var arrayOfTimeSlots = [Timeslot]()
    var arrayOfTimes = ["9:00-9:15","9:15-9:30","9:30-9:45","9:45-10:00","10:00-10:15","10:15-10:30","10:30-10:45","10:45-11:00","11:00-11:15","11:15-11:30","11:30-11:45","11:45-12:00"]
    var openMic = OpenMic()
    var code = AuthCode()
    var isAuthorized = false
    @IBOutlet weak var tableView: UITableView!
    
    var dateFormatter: NSDateFormatter = {
        var formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        return formatter
    }()
    var arrayOfStrings = [String]()
    
    @IBOutlet weak var adminOutlet: UIButton!
    
    @IBAction func adminTapped(sender: UIButton) {
        showAlert()
    }
    
    @IBAction func goHome(sender: UIButton) {
        self.navigationController?.popToRootViewControllerAnimated(true)
//        openMic.ref?.updateChildValues(["hasPopulated": true])
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        loadDefaults()  
//        adminOutlet.hidden = true 
        print(arrayOfTimeSlots.count)
        observeTimeSlots()
        
        print(arrayOfTimeSlots.count)
        if openMic.hasPopulated == false {
            seedTimeSlots()
        }
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
//    func authorization() {
//        if isAuthorized == true {
//            func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//       
//                if editingStyle == .Delete {
//            
//                    let event = arrayOfTimeSlots[indexPath.row]
//                    event.ref?.removeValue()
//            
//                }
//            }
//        }
//    }
    //MARK: - Set up admin function
    func showAlert() {
        
        let alertController = UIAlertController(title: "Delete All", message: "Enter code", preferredStyle: .Alert)
        
        let verifyAction = UIAlertAction(title: "Delete", style: .Default) {
            (verifyAction) -> Void in
            
            let textField = alertController.textFields?.first
            let c = self.code
            // test for verification
            if textField!.text == c.code {
                self.openMicRef.removeValue()
                print("approved")
                self.timeSlotRef.removeValue()
                self.seedTimeSlots()
                self.isAuthorized = true
                         
            } else {
                // fails authorization
                print("wrong code")
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) {
            (alertAction) -> Void in
            
        }
        alertController.addTextFieldWithConfigurationHandler { (textField) -> Void in
            
        }
        alertController.addAction(verifyAction)
        alertController.addAction(cancelAction)
        
        presentViewController(alertController, animated: true, completion: nil)
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
        if openMic.hasPopulated == false {
        //If the start date of event is before the end date
            let o = openMic
            o.hasPopulated = true
            o.save()
            for time in arrayOfTimes {
                
                let slot = Timeslot()
                slot.time = time
                slot.artist = "Click here to reserve this slot"
                slot.save()

                
            }
            o.ref?.updateChildValues(["hasPopulated": true])
            self.tableView.reloadData()
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
//                        self.openMic.hasPopulated = true
//                        self.openMic.ref?.updateChildValues(["hasPopulated": true])
//                        self.saveDefaults()
                        self.tableView.reloadData()
                    }
                    
                }
            }
            
        })
        
        
    }
//    func saveDefaults() {
//        print("saved")
//        let defaults = NSUserDefaults.standardUserDefaults()
//        defaults.setBool(observerHasRun, forKey: "observerHasRun")
//        defaults.synchronize()
//        
//    }
//    
//    func loadDefaults() {
//        let defaults = NSUserDefaults.standardUserDefaults()
//        let value = defaults.boolForKey("observerHasRun")
//        self.observerHasRun = value
//        print(self.observerHasRun)
//  
//    }

    
    
}
