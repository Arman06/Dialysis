//
//  data.swift
//  Dyal
//
//  Created by Арман on 9/16/18.
//  Copyright © 2018 Арман. All rights reserved.
//

import Foundation

class DataService {
    static let instance = DataService()
    
    private let food = [
        foodItem(name: "Apple", imageName: "apple.jpg"),
        foodItem(name: "Pineapple", imageName: "pineapple.jpg"),
        foodItem(name: "Orange", imageName: "orange.jpg"),
        foodItem(name: "Peach", imageName: "peach.jpg"),
        foodItem(name: "Orange", imageName: "orange.jpg"),
        foodItem(name: "Lemon", imageName: "lemon.jpg"),
        
    ]
    
    
    func getFood() -> [foodItem] {
        return food
    }
}
