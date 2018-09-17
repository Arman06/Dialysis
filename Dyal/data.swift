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
    
    private(set) var foodArray = [
        foodItem(name: "Яблоко", imageName: "apple.jpg"),
        foodItem(name: "Ананас", imageName: "pineapple.jpg"),
        foodItem(name: "Апельсин", imageName: "orange.jpg"),
        foodItem(name: "Персик", imageName: "peach.jpg"),
        foodItem(name: "Банан", imageName: "banana.jpg"),
        foodItem(name: "Лимон", imageName: "lemon.jpg"),
    ]
    
    func addFood(_ food: foodItem) {
        foodArray.append(food)
    }
    func getFood() -> [foodItem] {
        return foodArray
    }
}
