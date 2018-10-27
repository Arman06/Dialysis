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
        gradientLayer.colors = [UIColor(red:0.00, green:0.40, blue:1.00, alpha:1.0).cgColor,
                                UIColor(red:0.00, green:0.54, blue:1.0, alpha: 1).cgColor,
                                UIColor(red:0.00, green:0.70, blue:1.0, alpha: 1).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0,y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1,y: 0.5)
        gradientLayer.masksToBounds = true
        self.layer.addSublayer(gradientLayer)
    }
}

extension UICollectionView {
    func deselectAllSelectedItems(animated: Bool) {
        for indexPath in self.indexPathsForSelectedItems ?? [] {
            self.deselectItem(at: indexPath, animated: animated)
            if let cell = self.cellForItem(at: indexPath) as? FoodCell {
                cell.isSelected = false
            }
        }
    }
    
    func deselectAllVisibleItems(animated: Bool) {
        for indexPath in self.indexPathsForVisibleItems {
            self.deselectItem(at: indexPath, animated: animated)
            if let cell = self.cellForItem(at: indexPath) as? FoodCell {
                cell.isSelected = false
            }
        }
    }
    
    func deselectAllItems(animated: Bool) {
        for indexPath in 0...self.numberOfItems(inSection: 0) {
            self.deselectItem(at: IndexPath(row: indexPath, section: 0), animated: animated)
            if let cell = self.cellForItem(at: IndexPath(row: indexPath, section: 0)) as? FoodCell {
               cell.isSelected = false
            }
        }
    }
    func turnEditModeOnForAllItems() {
        for indexPath in 0...self.numberOfItems(inSection: 0) {
            if let cell = self.cellForItem(at: IndexPath(row: indexPath, section: 0)) as? FoodCell {
                cell.isEditing = true
            }
        }
    }
    
    func turnEditModeOffForAllItems() {
        for indexPath in 0...self.numberOfItems(inSection: 0) {
            if let cell = self.cellForItem(at: IndexPath(row: indexPath, section: 0)) as? FoodCell {
                cell.isEditing = false
            }
        }
    }
    
    func turnEditModeOffForAllVisibleItems() {
        for indexPath in self.indexPathsForVisibleItems {
            if let cell = self.cellForItem(at: IndexPath(row: indexPath.row, section: indexPath.section)) as? FoodCell {
                cell.isEditing = false
            }
        }
    }
    
    func turnEditModeOnForAllVisibleItems() {
        for indexPath in self.indexPathsForVisibleItems {
            if let cell = self.cellForItem(at: IndexPath(row: indexPath.row, section: indexPath.section)) as? FoodCell {
                cell.isEditing = true
            }
        }
    }
    
    func turnEditModeOff(at indexPath: IndexPath) {
        if let cell = self.cellForItem(at: IndexPath(row: indexPath.row, section: indexPath.section)) as? FoodCell {
            cell.isEditing = false
        }
    }
    
    func turnEditModeOn(at indexPath: IndexPath) {
        if let cell = self.cellForItem(at: IndexPath(row: indexPath.row, section: indexPath.section)) as? FoodCell {
            cell.isEditing = true
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


