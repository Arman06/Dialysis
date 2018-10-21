//
//  Extensions.swift
//  Dyal
//
//  Created by Арман on 10/17/18.
//  Copyright © 2018 Арман. All rights reserved.
//

import UIKit

extension UIView {
    func createGradientLayer(withRoundedCorners isRounded: Bool) {
        var gradientLayer: CAGradientLayer!
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        if isRounded{
            gradientLayer.cornerRadius = self.frame.height / 2
        }
        gradientLayer.colors = [UIColor(red:0.00, green:0.48, blue:1.00, alpha:1.0).cgColor,
                                UIColor(red:0.00, green:0.54, blue:1.0, alpha: 1).cgColor,
                                UIColor(red:0.00, green:0.60, blue:1.0, alpha: 1).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0,y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1,y: 0.5)
        gradientLayer.masksToBounds = true
        self.layer.addSublayer(gradientLayer)
    }
}

extension UICollectionView {
    func deselectAllItems(animated: Bool = false) {
        for indexPath in self.indexPathsForSelectedItems ?? [] {
            self.deselectItem(at: indexPath, animated: true)
        }
    }
}


extension FileManager {
    static var documentURL: URL {
        return FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    }
}

extension UIDevice {
    static var isIPad: Bool {
        return UIDevice().userInterfaceIdiom == .pad
    }
    static var IsPortrait: Bool  {
        return UIScreen.main.bounds.size.width < UIScreen.main.bounds.size.height
    }
}


