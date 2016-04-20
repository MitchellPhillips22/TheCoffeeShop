//
//  StandardsMenuViewController.swift
//  TheCoffeeShop
//
//  Created by Mitchell Phillips on 4/5/16.
//  Copyright © 2016 Wasted Potential LLC. All rights reserved.
//

import UIKit

class StandardsMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var drinksArray = [StandardDrink]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        seedArray()
    }
    //MARK: - Seed Array
    func seedArray() {
        
        self.drinksArray = [
            StandardDrink(name: "HOUSE COFFEE", description: "ROASTS CHANGE DAILY"),
            StandardDrink(name: "ICED COFFEE", description: "COLD BREWED"),
            StandardDrink(name: "AMERICANO", description: "ESPRESSO SHOTS, WATER, HOT OR ON THE ROCKS"),
            StandardDrink(name: "LATTE", description: "STEAMED MILK, ESPRESSO SHOTS"),
            StandardDrink(name: "CAPPUCINO", description: "WET OR DRY MILK FOAM, ESPRESSO SHOTS"),
            StandardDrink(name: "MOCHA", description: "DARK, TAN, WHITE"),
            StandardDrink(name: "ONE UP", description: "ONE ESPRESSO SHOT, ONE MARKED ESPRESSO SHOT"),
            StandardDrink(name: "BREVE", description: "STEAMED HALF AND HALF, ESPRESSO SHOTS"),
            StandardDrink(name: "CAFE AU LAIT", description: "STEAMED MILK, DRIP COFFEE"),
            StandardDrink(name: "DOUBLE SHOT", description: "TWO SHOTS OF ESPRESSO"),
            StandardDrink(name: "BABY-CANO", description: "NAKED TRIPLE SHOT, STEAMED HALF AND HALF"),
            StandardDrink(name: "ESPRESSO MACCHIATO", description: "ESPRESSO SHOTS, A DOLLOP OF MILK FOAM"),
            StandardDrink(name: "ESPRESSO CON PANNA", description: "ESPRESSO SHOTS, A DOLLOP OF WHIPPED CREAM")
        ]
    }
    
    //MARK: - Table View set up
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drinksArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("standardCell") as! StandardsTableViewCell
        let drink = drinksArray[indexPath.row]
        cell.drinkNameLabel.text = drink.name
        cell.drinkDescriptionLabel.text = drink.description
        return cell
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
