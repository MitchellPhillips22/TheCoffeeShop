//
//  HomeViewController.swift
//  TheCoffeeShop
//
//  Created by Mitchell Phillips on 4/5/16.
//  Copyright © 2016 Wasted Potential LLC. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {

    var codeRef = Firebase(url: "https://the-coffee-shop.firebaseio.com/code")
    override func viewDidLoad() {
        super.viewDidLoad()
//       seedAuthCode()
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

    func seedAuthCode() {
        let c = AuthCode()
        
        c.code = "12345"
        c.save()
    }
}

