//
//  FoodTableViewCell.swift
//  Dyal
//
//  Created by Арман on 11/1/18.
//  Copyright © 2018 Арман. All rights reserved.
//

import UIKit

class FoodTableViewCell: UITableViewCell {

    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var sodiumLabel: UILabel!
    @IBOutlet weak var potassiumLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
