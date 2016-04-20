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
    //MARK: - Variables
    var ref = Firebase(url: "https://the-coffee-shop.firebaseio.com")
    var timeSlotRef = Firebase(url: "https://the-coffee-shop.firebaseio.com/timeslot")
    var codeRef = Firebase(url: "https://the-coffee-shop.firebaseio.com/code")
    var arrayOfTimeSlots = [Timeslot]()
    var arrayOfTimes = ["9:00-9:15","9:15-9:30","9:30-9:45","9:45-10:00","10:00-10:15","10:15-10:30","10:30-10:45","10:45-11:00","11:00-11:15","11:15-11:30","11:30-11:45","11:45-12:00"]
    var authCode = AuthCode()
    var timeSlot = Timeslot()
    var isAuthorized = false
    var arrayOfStrings = [String]()
    //MARK: - IBActions and Outlets
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var adminOutlet: UIButton!
    
    @IBAction func adminTapped(sender: UIButton) {
        showAlert()
    }
    
    @IBAction func goHome(sender: UIButton) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    //MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()
        
        observeTimeSlots()
        //            seedTimeSlots()
        observeAuthCode()
        
    }
    //MARK: - Force portrait orientation
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let value = UIInterfaceOrientation.Portrait.rawValue
        UIDevice.currentDevice().setValue(value, forKey: "orientation")
        print("view did appear portrait")
    }
    
    override func shouldAutorotate() -> Bool {
        print("should auto rotate")
        return false
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return .Portrait
    }
    
    override func preferredInterfaceOrientationForPresentation() -> UIInterfaceOrientation {
        return .Portrait
    }
    //MARK: - Table view set up
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
        let str = "Click here to reserve this slot"
        let t = arrayOfTimeSlots[indexPath.row]
        
        print(str)
        print(t.artist)
        
        if str == t.artist {
            self.showAlert(t)
        } else {
            print("is populated")
        }
    }
    //MARK: - delete function set up
    func showAlert() {
        
        let alertController = UIAlertController(title: "Delete All", message: "Enter code", preferredStyle: .Alert)
        
        let verifyAction = UIAlertAction(title: "Delete", style: .Default) {
            (verifyAction) -> Void in
            
            let textField = alertController.textFields?.first
            // test for verification
            if textField!.text == self.authCode.code {
                print("approved")
                for timeslot in self.arrayOfTimeSlots {
                    timeslot.ref?.updateChildValues(["artist": "Click here to reserve this slot"])
                }
                self.tableView.reloadData()
                
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
    //MARK: - Add artist Alert
    
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
    
    //MARK: - Seed function
    func seedTimeSlots() {
        for time in arrayOfTimes {
            let slot = Timeslot()
            slot.time = time
            slot.artist = "Click here to reserve this slot"
            slot.save()
        }
        self.tableView.reloadData()
    }
    //MARK: - Observers
    func observeTimeSlots() {
        
        self.timeSlotRef.observeEventType(.Value, withBlock: { snapshot in
            
            print("snap shot value \(snapshot.value)")
            
            self.arrayOfTimeSlots = []
            
            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                
                for snap in snapshots {
                    
                    if let dict = snap.value as? Dictionary<String, AnyObject> {
                        
                        let key = snap.key
                        self.timeSlot = Timeslot(key: key, dict: dict)
                        self.timeSlot.ref = Firebase(url: "\(self.timeSlotRef)/\(key)")
                        self.arrayOfTimeSlots.append(self.timeSlot)
                        
                        print("observer array count \(self.arrayOfTimeSlots.count)")
                        self.tableView.reloadData()
                    }
                }
            }
            self.tableView.reloadData()
        })
    }
    func observeAuthCode() {
        
        self.codeRef.observeEventType(.Value, withBlock: { snapshot in
            
            print(snapshot.value)
            
            self.authCode.code = ""
            
            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                
                for snap in snapshots {
                    
                    if let dict = snap.value as? Dictionary<String, AnyObject> {
                        
                        let key = snap.key
                        self.authCode = AuthCode(key: key, dict: dict)
                        self.authCode.ref = Firebase(url: "\(self.codeRef)/\(key)")
                        
                    }
                }
            }
        })
    }
}
