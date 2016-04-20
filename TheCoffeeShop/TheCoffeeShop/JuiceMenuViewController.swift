//
//  JuiceMenuViewController.swift
//  TheCoffeeShop
//
//  Created by Mitchell Phillips on 4/5/16.
//  Copyright © 2016 Wasted Potential LLC. All rights reserved.
//

import UIKit

class JuiceMenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var drinksArray = [JuiceDrink]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        seedArray()
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
    
    //MARK: - Seed Array
    func seedArray() {
        self.drinksArray = [
            JuiceDrink(name: "THE ORIGINAL  ", description: "APPLE, ORANGE, CARROT"),
            JuiceDrink(name: "SOLAR FLARE  ", description: "PINEAPPLE, CUCUMBER, SPINACH, ORANGE, APPLE"),
            JuiceDrink(name: "BEET DOWN  ", description: "BEET, APPLE, CARROT, LEMON, SPINACH"),
            JuiceDrink(name: "TRAIN WRECK  ", description: "CARROT, GRAPEFRUIT, BEET, SPINACH, KALE, PINEAPPLE, ORANGE, LEMON"),
            JuiceDrink(name: "EARTH BENDER  ", description: "SPINACH, CELERY, CUCUMBER, APPLE, BEET, CILANTRO"),
            JuiceDrink(name: "ROOTS N' FRUITS  ", description: "LEMON, APPLE, ORANGE, GINGER, BEET, CARROT"),
            JuiceDrink(name: "SUNDAY MORNING  ", description: "ORANGE, APPLE, PINEAPPLE, CARROT, CUCUMBER, GINGER, LEMON"),
            JuiceDrink(name: "MERRIL'S MAGIC  ", description: "GINGER, CARROT, SPINACH, CUCUMBER, ORANGE, APPLE, PINEAPPLE")
        ]
    }
    
    //MARK: - Set up table view
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drinksArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("juiceCell", forIndexPath: indexPath) as! JuiceTableViewCell
        let drink = drinksArray[indexPath.row]
        cell.drinkNameLabel.text = drink.name
        cell.drinkDescriptionLabel.text = drink.description
        return cell
    }
    
}
