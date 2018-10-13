//
//  BlueRoundButton.swift
//  Dyal
//
//  Created by Арман on 10/13/18.
//  Copyright © 2018 Арман. All rights reserved.
//

import UIKit

class BlueRoundButton: UIButton {

    
    
    override func awakeFromNib() {
        self.backgroundColor = UIColor(red:0.00, green:0.48, blue:1.00, alpha:1.0)
        self.layer.cornerRadius = 15
        self.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.layer.shadowOffset = CGSize(width: 2, height: 5)
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 4.0
        self.layer.masksToBounds = false
        self.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
