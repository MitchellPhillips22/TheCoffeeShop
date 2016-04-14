//
//  OpenMicTableViewCell.swift
//  TheCoffeeShop
//
//  Created by Mitchell Phillips on 4/14/16.
//  Copyright © 2016 Wasted Potential LLC. All rights reserved.
//

import UIKit


class OpenMicTableViewCell: UITableViewCell {
    @IBOutlet weak var timeLabel: UILabel!

    @IBOutlet weak var artistLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
