//
//  OpenMicViewController.swift
//  TheCoffeeShop
//
//  Created by Mitchell Phillips on 4/5/16.
//  Copyright © 2016 Wasted Potential LLC. All rights reserved.
//

import UIKit
import Firebase

class OpenMicViewController: UIViewController {
    
    var ref = Firebase(url: "https://the-coffee-shop.firebaseio.com")
    var timeSlotRef = Firebase(url: "https://the-coffee-shop.firebaseio.com/timeslot")
    
    var arrayOfTimeSlots = [Timeslot]()
    
    var dateFormatter: NSDateFormatter = {
        var formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        return formatter
    }()
    var arrayOfStrings = [String]()
    
    @IBAction func goHome(sender: UIButton) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    @IBOutlet var timeslotButtonCollection: Array<UIButton>?
    
    @IBAction func timeslotTapped(sender: UIButton) {
        showAlert(sender)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addObserver()
         loadArtistNames()
//        let button = UIButton()
//        let timeslot = Timeslot()
//        let b = timeslotButtonCollection![button.tag]
//        b.setTitle(timeslot.artist, forState: .Normal)
//        timeslot.ref?.updateChildValues(["artist": timeslot.artist])
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
    func loadArtistNames() {
        
        for timeslot in arrayOfTimeSlots {
            print("loadArtistNames() called")
            self.arrayOfStrings.append(timeslot.artist)
            print("artist from arrayOfTimeslots \(timeslot.artist)")
        }
        for (index, artist) in arrayOfStrings.enumerate() {
            let button = self.timeslotButtonCollection![index]
            button.setTitle(artist, forState: .Normal)
            print("artist from arrayOfStrings \(artist)")
        }
        
    }
    func showAlert(button: UIButton) {
        let alertController = UIAlertController(title: "Add artist", message: "Type artist name", preferredStyle: .Alert)
        let addAction = UIAlertAction(title: "Add", style: .Default) {
            (addAction) -> Void in
            if let textField = alertController.textFields?.first {
                let timeslot = self.arrayOfTimeSlots[Int(button.tag)]
                print(self.arrayOfTimeSlots[3])
                button.setTitle(textField.text, forState: .Normal)
                timeslot.ref?.updateChildValues(["artist": textField.text!])
                
                
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
    func seedTimeSlot() {
        
        if self.arrayOfTimeSlots.count < 12 {
            
            for button in timeslotButtonCollection! {
                let t = Timeslot()
                let artist = button.titleLabel?.text
                t.artist = artist!
                t.save()
            }
        }
        
    }
    
    func addObserver() {
        
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
                        print(timeSlot.ref)
                        if self.arrayOfTimeSlots.count > 11 {
                            self.loadArtistNames()
                        }
                    }
                    
                }
            }
        })
        
       
    }
    
    
}
