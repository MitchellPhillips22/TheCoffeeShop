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
    
    @IBAction func goBack(sender: UIButton) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    @IBAction func unwindFromOpenMic (segue: UIStoryboardSegue) {
        
    }
    @IBAction func unwindFromEvents (segue: UIStoryboardSegue) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: - Force portrait orientation
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let value = UIInterfaceOrientation.Portrait.rawValue
        UIDevice.currentDevice().setValue(value, forKey: "orientation")
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return .Portrait
    }
    
    override func preferredInterfaceOrientationForPresentation() -> UIInterfaceOrientation {
        return .Portrait
    }
}
