//
//  foodItems.swift
//  Dyal
//
//  Created by Арман on 5/2/18.
//  Copyright © 2018 Арман. All rights reserved.
//

import Foundation

struct foodItem {
    private(set) var name: String
    //private(set) var fluorine: Float
    private(set) var potassium: Float
    private(set) var sodium: Float
    private(set) var imageName: String
    init(name: String, imageName: String,/* fluorine: Float,*/ potassium: Float, sodium: Float) {
        self.name = name
        self.imageName = imageName
        //self.fluorine = fluorine
        self.potassium = potassium
        self.sodium = sodium
    }
}
