//
//  BlueRoundButton.swift
//  Dyal
//
//  Created by Арман on 10/13/18.
//  Copyright © 2018 Арман. All rights reserved.
//

import UIKit

class BlueRoundButton: UIButton {

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        if self.isSelected == true {
            self.isSelected = false
            
        }
        else{
            self.isSelected = false
            
        }
        UIView.animate(withDuration: 0.02) {
            self.isHighlighted = false
            self.transform = CGAffineTransform.identity
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if self.isSelected == true {
            self.isSelected = false
            
        }
        else{
            self.isSelected = false

        }
        UIView.animate(withDuration: 0.02) {
            self.isHighlighted = false
            self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }
        
    }
    
    
    
    override func awakeFromNib() {
        self.showsTouchWhenHighlighted = false
        self.createGradientLayer(withRoundedCorners: true)
        self.reversesTitleShadowWhenHighlighted = false
        self.setTitle(currentTitle, for: .normal)
        self.setTitle(currentTitle, for: .highlighted)
        self.titleLabel?.font = .systemFont(ofSize: 15)
        
        self.adjustsImageWhenHighlighted = true
        self.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.layer.shadowOffset = CGSize(width: 2, height: 5)
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 8.0
        self.layer.masksToBounds = false
        self.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        self.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .highlighted)
        self.setTitleColor(.white, for: .selected)
    }

}
