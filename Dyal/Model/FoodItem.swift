//
//  foodItems.swift
//  Dyal
//
//  Created by Арман on 5/2/18.
//  Copyright © 2018 Арман. All rights reserved.
//

import UIKit


class FoodItem {
  
    
    
    
    private(set) var name: String
    //private(set) var fluorine: Float
    private(set) var potassium: Float
    private(set) var sodium: Float
    private(set) var image: UIImage
    private(set) var date: Date
    
    
    init(name: String, image: UIImage,/* fluorine: Float,*/ potassium: Float, sodium: Float, date: Date) {
        self.name = name
        self.image = image
        self.date = date
        //self.fluorine = fluorine
        self.potassium = potassium
        self.sodium = sodium
    }
}
