//
//  AboutViewController.swift
//  TheCoffeeShop
//
//  Created by Mitchell Phillips on 4/5/16.
//  Copyright © 2016 Wasted Potential LLC. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    
    @IBAction func goHome(sender: UIButton) {
        
        self.navigationController?.popToRootViewControllerAnimated(true)
        
    }
    @IBAction func unwindFromLocation (segue: UIStoryboardSegue) {
        
    }
    @IBAction func unwindFromHours (segue: UIStoryboardSegue) {
        
    }

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
