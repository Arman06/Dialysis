//
//  FoodCell.swift
//  Dyal
//
//  Created by Арман on 10/19/18.
//  Copyright © 2018 Арман. All rights reserved.
//

import UIKit

class FoodCell: UICollectionViewCell {
    
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var sodium: UILabel!
    @IBOutlet weak var potassium: UILabel!
    @IBOutlet weak var name: UILabel!
    
    
    override func awakeFromNib() {
        self.layer.borderWidth = 1.5
        if isSelected {
            self.layer.borderColor = UIColor.blue.cgColor
        } else {
            self.layer.borderColor = UIColor.clear.cgColor
        }
        self.layer.cornerRadius = 13
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 2, height: 15)
        self.layer.shadowOpacity = 0.1
        self.layer.shadowRadius = 4.0
        self.layer.masksToBounds = false
        self.contentView.layer.cornerRadius = 13
        self.contentView.layer.masksToBounds = true
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                UIView.animate(withDuration: 0.1) {
                    self.layer.borderColor = UIColor.blue.cgColor
                    self.layer.shadowRadius = 8.0
                }
                
            } else {
                UIView.animate(withDuration: 0.1) {
                    self.layer.borderColor = UIColor.clear.cgColor
                    self.layer.shadowRadius = 4.0
                }
            }
        }
    }
}
