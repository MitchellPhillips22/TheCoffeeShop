//
//  LocationViewController.swift
//  TheCoffeeShop
//
//  Created by Mitchell Phillips on 4/18/16.
//  Copyright © 2016 Wasted Potential LLC. All rights reserved.
//

import UIKit

class LocationViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = NSURL(string: "https://www.google.com/maps/place/The+Coffee+Shop/@40.5230046,-111.9875759,16z/data=!4m6!1m3!3m2!1s0x0:0x20e30c794ea5fd2d!2sThe+Coffee+Shop!3m1!1s0x0:0x20e30c794ea5fd2d") {
            let request = NSURLRequest(URL: url)
            webView.loadRequest(request)
        }
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
