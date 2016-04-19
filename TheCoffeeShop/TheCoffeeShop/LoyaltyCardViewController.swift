//
//  LoyaltyCardViewController.swift
//  TheCoffeeShop
//
//  Created by Mitchell Phillips on 4/5/16.
//  Copyright © 2016 Wasted Potential LLC. All rights reserved.
//
import UIKit
import Firebase

class LoyaltyCardViewController: UIViewController {
    
    //MARK: - Actions
    @IBAction func addStampTapped(sender: UIButton) {
        showAlert()
        checkForRedeemable()
    }
    
    @IBAction func latteTapped(sender: UIButton) {
        latteButtonTapped(sender)
    }
    
    @IBAction func coffeeTapped(sender: UIButton) {
        coffeeButtonTapped(sender)
    }
    
    @IBAction func doneTapped(sender: UIButton) {
        saveDefaults()
        doneOutlet.hidden = true
        addStampsOutlet.hidden = false
        isAuthorized = false
        updateUI()
    }
    
    @IBAction func redeemLatteTapped(sender: UIButton) {
        if isAuthorized == true {
        latteStamps = 0
        redeemLatteOutlet.hidden = true
        updateUI()
        }
    }
    @IBAction func redeemCoffeeTapped(sender: UIButton) {
        if isAuthorized == true {
        coffeeStamps = 0
        redeemCoffeeOutlet.hidden = true
        updateUI()
        }
    }
    
    @IBAction func goHome(sender: UIButton) {
       self.dismissViewControllerAnimated(false, completion: nil)
    }
    //MARK: - Outlets
    @IBOutlet weak var doneOutlet: UIButton!
    @IBOutlet weak var addStampsOutlet: UIButton!
    @IBOutlet weak var redeemLatteOutlet: UIButton!
    @IBOutlet weak var redeemCoffeeOutlet: UIButton!
    @IBOutlet var latteButtonCollection: Array<UIButton>?
    
    @IBOutlet var coffeeButtonCollection: Array<UIButton>?
    
    var authCode = AuthCode()
    
    var latteStamps = 0
    
    var coffeeStamps = 0
    
    var isAuthorized: Bool = false
    
    var codeRef = Firebase(url: "https://the-coffee-shop.firebaseio.com/code")

    
    //MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()
        
        observeAuthCode()
        loadDefaults()
        checkForRedeemable()
        updateUI()
        
    }
    // forces view to present in landscape only
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let value = UIInterfaceOrientation.LandscapeLeft.rawValue
        UIDevice.currentDevice().setValue(value, forKey: "orientation")
        print("view did appear landscape")
    }

    override func shouldAutorotate() -> Bool {
        print("auto rotate to landscape")

        return false
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        print("supported landscape")
        return .Landscape
  
    }
    
    override func preferredInterfaceOrientationForPresentation() -> UIInterfaceOrientation {
         print("prefer landscape")
        return .LandscapeLeft
    }
    //MARK: - Button functions
    
    func latteButtonTapped(sender:UIButton) {
        if isAuthorized == true {
            if sender.selected == true {
                latteStamps = latteStamps - 1
                sender.selected = false
            } else {
                latteStamps = latteStamps + 1
                sender.selected = true
            }
        }
        
        checkForRedeemable()
        
        print("stamps equals \(latteStamps)")
        
    }
    
    func coffeeButtonTapped(sender:UIButton) {
        if isAuthorized == true {
            if sender.selected == true {
                coffeeStamps = coffeeStamps - 1
                sender.selected = false
            } else {
                coffeeStamps = coffeeStamps + 1
                sender.selected = true
            }
        }
        checkForRedeemableCoffee()
    }
    // MARK: - Check for redeem
    func checkForRedeemable() {
        
        if self.latteStamps == 15 {
            self.redeemLatteOutlet.hidden = false
        } else {
            self.redeemLatteOutlet.hidden = true
        }
    }
    func checkForRedeemableCoffee() {
        
        if self.coffeeStamps == 15 {
            self.redeemCoffeeOutlet.hidden = false
        } else {
            self.redeemCoffeeOutlet.hidden = true
        }
    }
    //MARK: - Alert set up
    
    func showAlert() {
        
        let alertController = UIAlertController(title: "Edit", message: "Enter code", preferredStyle: .Alert)
        
        let verifyAction = UIAlertAction(title: "OK", style: .Default) {
            (verifyAction) -> Void in
            
            let textField = alertController.textFields?.first
            // test for verification
            if textField!.text == self.authCode.code {
                print(self.authCode.code)
                print("approved")
                self.observeAuthCode()
                self.latteStamps = 0
                self.coffeeStamps = 0
                self.loadDefaults()
                self.updateUI()
                self.doneOutlet.hidden = false
                self.addStampsOutlet.hidden = true
                self.isAuthorized = true
                
            } else {
                // fails authorization
                print(self.authCode.code)
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
   
 
     //MARK: - UI interaction functions
    func updateUI() {
        
        for button in latteButtonCollection! {
            button.selected = false
            
            if button.tag <= latteStamps {
                button.selected = true
            }
            
        }
        for button in coffeeButtonCollection! {
            button.selected = false
            
            if button.tag <= coffeeStamps {
                button.selected = true
            }
            
        }
        
    }
    
    //MARK: - NSUserDefaults functions
    func saveDefaults() {
        print("saved")
        let defaults = NSUserDefaults.standardUserDefaults()
        let numberOfLattes = NSNumber(integer: self.latteStamps)
        let numberOfCoffees = NSNumber(integer: self.coffeeStamps)
        defaults.setValue(numberOfLattes, forKey: "stampsNumber")
        defaults.setValue(numberOfCoffees, forKey: "coffeeStamps")
        defaults.synchronize()
        
    }
    
    func loadDefaults() {
        let defaults = NSUserDefaults.standardUserDefaults()
        if let value = defaults.valueForKey("stampsNumber") as? NSNumber {
            self.latteStamps = value.integerValue
        }
        if let coffeeValue = defaults.valueForKey("coffeeStamps") as? NSNumber {
            self.coffeeStamps = coffeeValue.integerValue
        }
        print("loaded stamps \(latteStamps)")
        
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
                            
    
                            print(self.authCode.code)
    
    
                        }
    
                    }
                }
                
            })
        }

}