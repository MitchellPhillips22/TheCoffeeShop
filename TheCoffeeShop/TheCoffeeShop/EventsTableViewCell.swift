//
//  EventsTableViewCell.swift
//  TheCoffeeShop
//
//  Created by Mitchell Phillips on 4/14/16.
//  Copyright © 2016 Wasted Potential LLC. All rights reserved.
//

import UIKit

class EventsTableViewCell: UITableViewCell {

    @IBOutlet weak var eventNameLabel: UILabel!
    
    @IBOutlet weak var eventDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
