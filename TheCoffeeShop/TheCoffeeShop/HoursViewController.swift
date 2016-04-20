//
//  HoursViewController.swift
//  TheCoffeeShop
//
//  Created by Mitchell Phillips on 4/18/16.
//  Copyright © 2016 Wasted Potential LLC. All rights reserved.
//

import UIKit

class HoursViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

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
    

}
