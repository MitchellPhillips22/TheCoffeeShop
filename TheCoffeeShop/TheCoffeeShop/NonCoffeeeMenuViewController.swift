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

        seedArray()
        // Do any additional setup after loading the view.
    }


    //MARK: - Set up drinks array
    
    func seedArray() {
        self.drinksArray = [
            NonCoffeeDrink(name: "HOT CHOCOLATE", description: "TRY OUR FAMOUS ORIGINAL or CREATE YOUR OWN STEAMER"),
            NonCoffeeDrink(name: "APPLE CIDER", description: "APPLE JUICE, CINNAMON, CHAI, CARAMEL"),
            NonCoffeeDrink(name: "CHAI", description: "HOT, ON THE ROCKS, or BLENDED"),
            NonCoffeeDrink(name: "THE BOB", description: "CHAI, WHITE CHOCOLATE, BANANA"),
            NonCoffeeDrink(name: "TEA", description: "VARIOUS LOOSE LEAF TEAS, HOT or ON THE ROCKS"),
            NonCoffeeDrink(name: "ITALIAN SODA", description: "CHOICE OF FLAVORS, SODA WATER; CREAM AND WHIPPED CREAM OPTIONAL"),
            NonCoffeeDrink(name: "LEMONADE", description: "FRESH SQUEEZED LEMONS, CHERRY, LIME, STRAWBERRY, or RASPBERRY"),
            NonCoffeeDrink(name: "SMOOTHIES", description: "STRAWBERRY, STRAWBERRY BANANA, RASPBERRY, WILD BERRY, PEACH, MANGO, PIÑA COLADA"),
            NonCoffeeDrink(name: "GREEN TEA LATTE", description: "MATCHA POWDER, WHITE CHOCOLATE, VANILLA"),
            NonCoffeeDrink(name: "KIDS CHOCOLATE OR MONKEY MILK", description: "CHOCOLATE MILK, BANANA OPTIONAL, WHIPPED CREAM")
            
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
