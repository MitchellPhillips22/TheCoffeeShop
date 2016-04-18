//
//  CalendarViewController.swift
//  TheCoffeeShop
//
//  Created by Mitchell Phillips on 4/5/16.
//  Copyright © 2016 Wasted Potential LLC. All rights reserved.
//

import UIKit
import Firebase

class UpcomingEventsTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var ref = Firebase(url: "https://the-coffee-shop.firebaseio.com")
    var eventRef = Firebase(url: "https://the-coffee-shop.firebaseio.com/event")
    var codeRef = Firebase(url: "https://the-coffee-shop.firebaseio.com/code")

    var code = AuthCode() 
    var arrayOfEvents = [Event]()
    
    var isAdmin: Bool = false
    var isAuthorized = false
    
    var totalTouches = 0
    
    var dateFormatter: NSDateFormatter = {
        var formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        return formatter
    }()
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func goHome(sender: UIButton) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    @IBOutlet weak var addEventOutlet: UIButton!
    
    @IBAction func addEvent(sender: UIButton) {
        let newEvent = Event()
        showAlert(newEvent)
    }
    
    @IBAction func adminTapped(sender: UIButton) {
        showAlert()
    }
    @IBOutlet weak var adminOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addEventOutlet.hidden = true
//        adminOutlet.hidden = true 
        observeEvents()
        tapGestureRecognized()
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
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touchCount = touches.count
        totalTouches = totalTouches + touchCount
        print(totalTouches)
    }
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        totalTouches = 0
    }
    func tapGestureRecognized() {
        let tapRecognizer = UITapGestureRecognizer()
        let requiredTaps = tapRecognizer.numberOfTouches()
        if requiredTaps == 5 {
            adminOutlet.hidden = false
        }
    }
    //MARK: - Set up table view
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("EventCell", forIndexPath: indexPath) as! EventsTableViewCell
        let event = arrayOfEvents[indexPath.row]
        cell.eventNameLabel.text = event.name
        cell.eventDateLabel.text = event.eventDescription
        print(event.name)
        
//        cell.eventDateLabel.text = dateFormatter.stringFromDate(event.eventDate)
        return cell
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfEvents.count
    }
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        
        if editingStyle == .Delete {
            
            let event = self.arrayOfEvents[indexPath.row]
            event.ref?.removeValue()
        }
    }
    //MARK: - Set up admin functions
    func showAlert() {
        
        let alertController = UIAlertController(title: "Edit Events", message: "Enter code", preferredStyle: .Alert)
        
        let verifyAction = UIAlertAction(title: "Okay", style: .Default) {
            (verifyAction) -> Void in
            
            let textField = alertController.textFields?.first
            let c = self.code
            // test for verification
            if textField!.text == c.code {
                print("approved")
                self.addEventOutlet.hidden = false
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


    //    MARK: - Set up alert
    func showAlert(event: Event) {
        let alertController = UIAlertController(title: "Add event", message: "Type event name then date", preferredStyle: .Alert)
        let addAction = UIAlertAction(title: "Add", style: .Default) {
            (addAction) -> Void in
            if let textField = alertController.textFields?.first,
                descriptionTextField = alertController.textFields?.last {
                if let eventName = textField.text,
                    let eventDescription = descriptionTextField.text {
                    let e = Event()
                    e.name = eventName
                    e.eventDescription = eventDescription
                    e.save()
//                    e.ref?.updateChildValues(["name": eventName, "eventDate": eventDate])
                    print(e.name)
                    
                }
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .Default) {
            (cancelAction) -> Void in
        }
        alertController.addTextFieldWithConfigurationHandler { (textField) -> Void in
        }
        alertController.addTextFieldWithConfigurationHandler { (dateTextField) -> Void in
        }
        alertController.addAction(cancelAction)
        alertController.addAction(addAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }

    
    func observeEvents() {
        
        self.eventRef.observeEventType(.Value, withBlock: { snapshot in
            
            print(snapshot.value)
            
            self.arrayOfEvents = []
            
            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                
                for snap in snapshots {
                    
                    if let dict = snap.value as? Dictionary<String, AnyObject> {
                        
                        
                        let key = snap.key
                        let event = Event(key: key, dict: dict)
                        event.ref = Firebase(url: "\(self.eventRef)/\(key)")
                        self.arrayOfEvents.append(event)
                        
                        print(self.arrayOfEvents.count)
                        
                        self.tableView.reloadData()
                    }
                    
                }
            }
            
        })
    }
}
