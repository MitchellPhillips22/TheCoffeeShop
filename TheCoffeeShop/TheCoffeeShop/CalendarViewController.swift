//
//  CalendarViewController.swift
//  TheCoffeeShop
//
//  Created by Mitchell Phillips on 4/5/16.
//  Copyright © 2016 Wasted Potential LLC. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController {

    @IBOutlet weak var calendarWebView: UIWebView!
    
    @IBAction func goBack(sender: UIButton) {
        self.navigationController?.popToRootViewControllerAnimated(true)    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = NSURL(string: "https://calendar.google.com/calendar/render#main_7")
        let request = NSURLRequest(URL: url!)
        calendarWebView.loadRequest(request)
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

}
