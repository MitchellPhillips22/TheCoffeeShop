//
//  LocationViewController.swift
//  TheCoffeeShop
//
//  Created by Mitchell Phillips on 4/18/16.
//  Copyright © 2016 Wasted Potential LLC. All rights reserved.
//

import UIKit

class LocationViewController: UIViewController {
    
//MARK: - Web View Outlet
    @IBOutlet weak var webView: UIWebView!
    
    //MARK: - View 
    override func viewDidLoad() {
        super.viewDidLoad()

        let webViewURL = NSURL(string: "https://www.google.com/maps/place/The+Coffee+Shop/@40.5230046,-111.9875759,16z/data=!4m6!1m3!3m2!1s0x0:0x20e30c794ea5fd2d!2sThe+Coffee+Shop!3m1!1s0x0:0x20e30c794ea5fd2d")
        let request = NSURLRequest(URL: webViewURL!)
        webView.loadRequest(request)
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
