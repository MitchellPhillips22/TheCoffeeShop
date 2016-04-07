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


}
