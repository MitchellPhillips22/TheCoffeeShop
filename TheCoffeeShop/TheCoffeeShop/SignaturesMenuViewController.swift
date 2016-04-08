//
//  SignaturesMenuViewController.swift
//  TheCoffeeShop
//
//  Created by Mitchell Phillips on 4/5/16.
//  Copyright © 2016 Wasted Potential LLC. All rights reserved.
//

import UIKit

class SignaturesMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var drinksArray = [SignatureLatte]()
    
    // MARK: - Set up view
    override func viewDidLoad() {
        super.viewDidLoad()
        
        seedArray()
    }
    
    func seedArray() {
        
        self.drinksArray = [
            //the spaces at the end of each line are to prevent the font from cutting off
            SignatureLatte(name: "VAN HALEN  ", description: "VANILLA, HAZELNUT "),
            SignatureLatte(name: "CARAMEL BLONDIE  ", description: "CARAMEL, PRALINE, WHITE CHOCOLATE "),
            SignatureLatte(name: "TASTE OF ITALY  ", description: "TIRAMISU, WHITE CHOCOLATE "),
            SignatureLatte(name: "HOLY IRISHMAN  ", description: "IRISH CREAM, WHITE CHOCOLATE "),
            SignatureLatte(name: "MOCHA NUT  ", description: "COCONUT, CHOCOLATE "),
            SignatureLatte(name: "WHITE DELIGHT ", description: "VANILLA, CHOCOLATE, WHITE CHOCOLATE "),
            SignatureLatte(name: "THE DELICIOUS  ", description: "VANILLA BEAN, CARAMEL, WHITE CHOCOLATE "),
            SignatureLatte(name: "MILKY WAY  ", description: "VANILLA, CARAMEL, CHOCOLATE "),
            SignatureLatte(name: "SMILIN' HAWAIIAN  ", description: "MACADAMIA NUT, COCONUT, WHITE CHOCOLATE "),
            SignatureLatte(name: "CARAMEL MACCHIATO  ", description: "VANILLA, CARAMEL "),
            SignatureLatte(name: "GIRL SCOUT  ", description: "COCONUT, CARAMEL, CHOCOLATE "),
            SignatureLatte(name: "AL CAPONE  ", description: "TIRAMISU, HAZELNUT "),
            SignatureLatte(name: "SNICKERS  ", description: "ENGLISH TOFFEE, PEANUT BUTTER, CARAMEL, CHOCOLATE "),
            SignatureLatte(name: "THE ASTRONAUT  ", description: "DARK ROAST, ESPRESSO, HAZELNUT, CREAM ")
        ]
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
    // MARK: - Table View set up

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drinksArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SignatureCell") as! SignatureTableViewCell
        let drink = drinksArray[indexPath.row]
        cell.drinkNameLabel.text = drink.name
        cell.drinkDescriptionLabel.text = drink.description
        return cell
    }
}
