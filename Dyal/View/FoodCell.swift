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
        self.layer.borderWidth = 2
        self.layer.cornerRadius = 20
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 2, height: 15)
        self.layer.shadowOpacity = 0.1
        self.layer.shadowRadius = 4.0
        self.layer.masksToBounds = false
        self.contentView.layer.cornerRadius = 20
        self.contentView.layer.masksToBounds = true
    }
    

    
    var isEditing: Bool = false
    
    
    override var isSelected: Bool {
        didSet {
            if isEditing {
                if isSelected {
                    if oldValue == false {
                        let color = CABasicAnimation(keyPath: "borderColor")
                        color.fromValue = UIColor.clear.cgColor
                        color.toValue = UIColor.red.cgColor
                        color.duration = 0.3
                        self.layer.add(color, forKey: "color and width");
                        let animation = CABasicAnimation(keyPath: "shadowColor")
                        animation.fromValue = UIColor.black.cgColor
                        animation.toValue = UIColor.red.cgColor
                        animation.duration = 1
                        self.layer.add(animation, forKey: animation.keyPath)
                        let animationOpacity = CABasicAnimation(keyPath: "shadowOpacity")
                        animationOpacity.fromValue = 0.1
                        animationOpacity.toValue = 0.3
                        animationOpacity.duration = 1
                        self.layer.add(animationOpacity, forKey: animation.keyPath)
                        
                        //                    self.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
                        self.layer.borderColor = UIColor.red.cgColor
                        self.layer.shadowRadius = 4.0
                        self.layer.shadowColor = UIColor.red.cgColor
                        self.layer.shadowOffset = CGSize(width: 4, height: 15)
                        self.layer.shadowOpacity = 0.3
                    }
                } else {
                    if oldValue == true {
                        let color = CABasicAnimation(keyPath: "borderColor")
                        color.fromValue = UIColor.red.cgColor
                        color.toValue = UIColor.clear.cgColor
                        color.duration = 0.35
                        self.layer.add(color, forKey: "color and width");
                        let animation = CABasicAnimation(keyPath: "shadowColor")
                        animation.fromValue = UIColor.red.cgColor
                        animation.toValue = UIColor.black.cgColor
                        animation.duration = 1
                        
                        let animationOpacity = CABasicAnimation(keyPath: "shadowOpacity")
                        animationOpacity.fromValue = 0.3
                        animationOpacity.toValue = 0.1
                        animationOpacity.duration = 1
                        
                        self.layer.add(animationOpacity, forKey: animation.keyPath)
                        //                    self.transform = CGAffineTransform.identity
                        self.layer.borderColor = UIColor.clear.cgColor
                        self.layer.shadowRadius = 4.0
                        self.layer.shadowColor = UIColor.black.cgColor
                        self.layer.shadowOffset = CGSize(width: 2, height: 15)
                        self.layer.shadowOpacity = 0.1
                        self.layer.shadowRadius = 4.0
                    }
                }
                    
            }
        }
    }
    
    
}
