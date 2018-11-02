//
//  FoodHeaderFooterReusableView.swift
//  Dyal
//
//  Created by Арман on 10/20/18.
//  Copyright © 2018 Арман. All rights reserved.
//

import UIKit

class FoodHeaderFooterReusableView: UICollectionReusableView {
    @IBOutlet weak var deleteDoneButton: UIButton!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var backgroundView: UIView!
    
    override func awakeFromNib() {
        backgroundView.layer.cornerRadius = 10
        backgroundView.layer.shadowColor = UIColor.black.cgColor
        backgroundView.layer.shadowOffset = CGSize(width: 0, height: 0)
        backgroundView.layer.shadowOpacity = 0.34
        backgroundView.layer.shadowRadius = 2.0
        backgroundView.layer.masksToBounds = false
    }
    
    @IBAction func deleteDoneButtonPressed(_ sender: UIButton) {
        if sender.currentTitle == "Удалить" {
            addButton.setTitle("Удалить", for: .normal)
            addButton.backgroundColor = #colorLiteral(red: 1, green: 0.3513356447, blue: 0.3235116899, alpha: 1)
//            deleteDoneButton.setTitle("Отмена", for: .normal)
        } else {
            addButton.setTitle("Добавить", for: .normal)
            addButton.backgroundColor = UIColor(red:0.00, green:0.55, blue:1.0, alpha: 1)
//            deleteDoneButton.setTitle("Удалить", for: .normal)
        }
    }
    
        @IBAction func addDeleteButtonPressedChange(_ sender: UIButton) {
        if !(sender.currentTitle == "Добавить") {
//            addButton.setTitle("Добавить", for: .normal)
            addButton.backgroundColor = UIColor(red:0.00, green:0.55, blue:1.0, alpha: 1)
            deleteDoneButton.setTitle("Удалить", for: .normal)
        } else {
//            addButton.setTitle("Добавить", for: .normal)
//            addButton.backgroundColor = UIColor(red:0.00, green:0.55, blue:1.0, alpha: 1)
            deleteDoneButton.setTitle("Удалить", for: .normal)
            }
    }
    
    
}
