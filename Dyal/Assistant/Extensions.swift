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
        for section in 0...(self.numberOfSections - 1){
            for indexPath in 0...self.numberOfItems(inSection: section) {
                if let cell = self.cellForItem(at: IndexPath(row: indexPath, section: section)) as? FoodCell {
                    cell.isSelected = false
                }
                deselectItem(at: IndexPath(row: indexPath, section: section), animated: false)
            }
        }
    }
    func turnEditModeOnForAllItems() {
        for section in 0...(self.numberOfSections - 1) {
            for indexPath in 0...self.numberOfItems(inSection: section) {
                if let cell = self.cellForItem(at: IndexPath(row: indexPath, section: section)) as? FoodCell {
                    cell.isEditing = true
                }
            }
        }
    }
    
    func turnEditModeOffForAllItems() {
        for section in 0...(self.numberOfSections - 1) {
            for indexPath in 0...self.numberOfItems(inSection: section) {
                if let cell = self.cellForItem(at: IndexPath(row: indexPath, section: section)) as? FoodCell {
                    cell.isEditing = false
                }
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

extension Date {
    static var yesterday: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: Date().noon)!
    }
    static var tomorrow: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: Date().noon)!
    }
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    var month: Int {
        return Calendar.current.component(.month,  from: self)
    }
    var isLastDayOfMonth: Bool {
        return dayAfter.month != month
    }
}

