//
//  MenuHomeViewController.swift
//  TheCoffeeShop
//
//  Created by Mitchell Phillips on 4/5/16.
//  Copyright © 2016 Wasted Potential LLC. All rights reserved.
//

import UIKit

class MenuHomeViewController: UIViewController {

    @IBAction func unwindFromNonCoffee (segue: UIStoryboardSegue) {
        print("unwind here")
    }
    @IBAction func unwindFromStandards (segue: UIStoryboardSegue) {
        
    }
    @IBAction func unwindFromSignatures (segue: UIStoryboardSegue) {
        
    }
    @IBAction func unwindFromJuice (segue: UIStoryboardSegue) {
        
    }
    
    @IBAction func goHome(sender: UIButton) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
