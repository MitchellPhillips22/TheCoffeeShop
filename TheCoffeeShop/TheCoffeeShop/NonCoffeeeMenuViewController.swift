//
//  NonCoffeeeMenuViewController.swift
//  TheCoffeeShop
//
//  Created by Mitchell Phillips on 4/5/16.
//  Copyright © 2016 Wasted Potential LLC. All rights reserved.
//

import UIKit

class NonCoffeeeMenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var drinksArray = [NonCoffeeDrink]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    //MARK: - Set up drinks array
    
    func seedArray() {
        self.drinksArray = [
            NonCoffeeDrink(name: "HOT CHOCOLATE", description: "TRY OUR FAMOUS ORIGINAL or CREATE YOUR OWN STEAMER")
        ]
    }
    
    //MARK: - Table view set up
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drinksArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("nonCoffeeCell") as! NonCoffeeTableViewCell
        let drink = drinksArray[indexPath.row]
        cell.drinkNameLabel.text = drink.name
        cell.drinkDescriptionLabel.text = drink.description
        return cell 
    }
    
    
    //MARK: - Force Portrait orientation

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
