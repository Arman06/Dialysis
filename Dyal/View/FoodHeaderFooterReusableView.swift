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
    
    
    @IBAction func deleteDoneButtonPressed(_ sender: UIButton) {
        if sender.currentTitle == "Удалить" {
            addButton.setTitle("Удалить", for: .normal)
            deleteDoneButton.setTitle("Отмена", for: .normal)
        } else {
            addButton.setTitle("Добавить", for: .normal)
            deleteDoneButton.setTitle("Удалить", for: .normal)
        }
    }
    
        @IBAction func addDeleteButtonPressedChange(_ sender: UIButton) {
        print(sender.currentTitle == "Удалить")
        if sender.currentTitle == "Удалить" {
            addButton.setTitle("Добавить", for: .normal)
            deleteDoneButton.setTitle("Удалить", for: .normal)
        }
    }
    
    
}
