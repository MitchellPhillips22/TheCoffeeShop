//
//  NonCoffeeTableViewCell.swift
//  TheCoffeeShop
//
//  Created by Mitchell Phillips on 4/11/16.
//  Copyright © 2016 Wasted Potential LLC. All rights reserved.
//

import UIKit

class NonCoffeeTableViewCell: UITableViewCell {

    @IBOutlet weak var drinkNameLabel: UILabel!
    
    @IBOutlet weak var drinkDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
