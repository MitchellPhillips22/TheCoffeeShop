//
//  StandardsMenuViewController.swift
//  TheCoffeeShop
//
//  Created by Mitchell Phillips on 4/5/16.
//  Copyright © 2016 Wasted Potential LLC. All rights reserved.
//

import UIKit

class StandardsMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var drinksArray = [standardDrink]()

    override func viewDidLoad() {
        super.viewDidLoad()

        seedArray()
    }
    func seedArray() {
        
        self.drinksArray = [
            standardDrink(name: "HOUSE COFFEE", description: "ROASTS CHANGE DAILY"),
            standardDrink(name: "ICED COFFEE", description: "COLD BREWED"),
            standardDrink(name: "AMERICANO", description: "ESPRESSO SHOTS, WATER, HOT OR ON THE ROCKS"),
            standardDrink(name: "LATTE", description: "STEAMED MILK, ESPRESSO SHOTS"),
            standardDrink(name: "CAPPUCINO", description: "WET OR DRY MILK FOAM, ESPRESSO SHOTS"),
            standardDrink(name: "MOCHA", description: "DARK, TAN, WHITE"),
            standardDrink(name: "ONE UP", description: "ONE ESPRESSO SHOT, ONE MARKED ESPRESSO SHOT"),
            standardDrink(name: "BREVE", description: "STEAMED HALF AND HALF, ESPRESSO SHOTS"),
            standardDrink(name: "CAFE AU LAIT", description: "STEAMED MILK, DRIP COFFEE"),
            standardDrink(name: "DOUBLE SHOT", description: "TWO SHOTS OF ESPRESSO"),
            standardDrink(name: "BABY-CANO", description: "NAKED TRIPLE SHOT, STEAMED HALF AND HALF"),
            standardDrink(name: "ESPRESSO MACCHIATO", description: "ESPRESSO SHOTS, A DOLLOP OF MILK FOAM"),
            standardDrink(name: "ESPRESSO CON PANNA", description: "ESPRESSO SHOTS, A DOLLOP OF WHIPPED CREAM")
        ]
    }
    
    @IBAction func goHome(sender: UIButton) {
        self.navigationController?.popToRootViewControllerAnimated(true)

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
