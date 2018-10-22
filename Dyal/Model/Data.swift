//
//  data.swift
//  Dyal
//
//  Created by Арман on 9/16/18.
//  Copyright © 2018 Арман. All rights reserved.
//

import UIKit

var imageDictionary = ["apple.jpg": UIImage(named: "apple.jpg"), "pineapple.jpg": UIImage(named: "pineapple.jpg"), "orange.jpg": UIImage(named: "orange.jpg"), "peach.jpg": UIImage(named: "peach.jpg"), "banana.jpg": UIImage(named: "banana.jpg"), "lemon.jpg": UIImage(named: "lemon.jpg")]

final class DataService {
    static let instance = DataService()
    
    
    
    private var foodArray = [
        FoodItem(name: "Яблоко", image: UIImage(named: "apple.jpg") ?? #imageLiteral(resourceName: "Image-placeholder"), potassium: 107, sodium: 1),
        FoodItem(name: "Ананас", image: UIImage(named: "pineapple.jpg") ?? #imageLiteral(resourceName: "Image-placeholder"), potassium: 109, sodium: 1),
        FoodItem(name: "Апельсин", image: UIImage(named: "orange.jpg") ?? #imageLiteral(resourceName: "Image-placeholder"), potassium: 181, sodium: 0),
        FoodItem(name: "Персик", image: UIImage(named: "peach.jpg") ?? #imageLiteral(resourceName: "Image-placeholder"), potassium: 190, sodium: 0),
        FoodItem(name: "Банан", image: UIImage(named: "banana.jpg") ?? #imageLiteral(resourceName: "Image-placeholder"), potassium: 358, sodium: 1),
        FoodItem(name: "Лимон", image: UIImage(named: "lemon.jpg") ?? #imageLiteral(resourceName: "Image-placeholder"), potassium: 138, sodium: 2),
        FoodItem(name: "Яблоко", image: UIImage(named: "apple.jpg") ?? #imageLiteral(resourceName: "Image-placeholder"), potassium: 107, sodium: 1),
        FoodItem(name: "Ананас", image: UIImage(named: "pineapple.jpg") ?? #imageLiteral(resourceName: "Image-placeholder"), potassium: 109, sodium: 1),
        FoodItem(name: "Апельсин", image: UIImage(named: "orange.jpg") ?? #imageLiteral(resourceName: "Image-placeholder"), potassium: 181, sodium: 0),
        FoodItem(name: "Персик", image: UIImage(named: "peach.jpg") ?? #imageLiteral(resourceName: "Image-placeholder"), potassium: 190, sodium: 0),
        FoodItem(name: "Банан", image: UIImage(named: "banana.jpg") ?? #imageLiteral(resourceName: "Image-placeholder"), potassium: 358, sodium: 1),
        FoodItem(name: "Лимон", image: UIImage(named: "lemon.jpg") ?? #imageLiteral(resourceName: "Image-placeholder"), potassium: 138, sodium: 2),
        FoodItem(name: "Яблоко", image: UIImage(named: "apple.jpg") ?? #imageLiteral(resourceName: "Image-placeholder"), potassium: 107, sodium: 1),
        FoodItem(name: "Ананас", image: UIImage(named: "pineapple.jpg") ?? #imageLiteral(resourceName: "Image-placeholder"), potassium: 109, sodium: 1),
        FoodItem(name: "Апельсин", image: UIImage(named: "orange.jpg") ?? #imageLiteral(resourceName: "Image-placeholder"), potassium: 181, sodium: 0),
        FoodItem(name: "Персик", image: UIImage(named: "peach.jpg") ?? #imageLiteral(resourceName: "Image-placeholder"), potassium: 190, sodium: 0),
        FoodItem(name: "Банан", image: UIImage(named: "banana.jpg") ?? #imageLiteral(resourceName: "Image-placeholder"), potassium: 358, sodium: 1),
        FoodItem(name: "Лимон", image: UIImage(named: "lemon.jpg") ?? #imageLiteral(resourceName: "Image-placeholder"), potassium: 138, sodium: 2),
        FoodItem(name: "Яблоко", image: UIImage(named: "apple.jpg") ?? #imageLiteral(resourceName: "Image-placeholder"), potassium: 107, sodium: 1),
        FoodItem(name: "Ананас", image: UIImage(named: "pineapple.jpg") ?? #imageLiteral(resourceName: "Image-placeholder"), potassium: 109, sodium: 1),
        FoodItem(name: "Апельсин", image: UIImage(named: "orange.jpg") ?? #imageLiteral(resourceName: "Image-placeholder"), potassium: 181, sodium: 0),
        FoodItem(name: "Персик", image: UIImage(named: "peach.jpg") ?? #imageLiteral(resourceName: "Image-placeholder"), potassium: 190, sodium: 0),
        FoodItem(name: "Банан", image: UIImage(named: "banana.jpg") ?? #imageLiteral(resourceName: "Image-placeholder"), potassium: 358, sodium: 1),
        FoodItem(name: "Лимон", image: UIImage(named: "lemon.jpg") ?? #imageLiteral(resourceName: "Image-placeholder"), potassium: 138, sodium: 2)
    ]
    
    func addFood(_ food: FoodItem) {
        foodArray.append(food)
    }
    
    func addFood(at index: Int, _ food: FoodItem) {
        foodArray.insert(food, at: index)
    }
    
    func removeFood(at index: Int) {
        foodArray.remove(at: index)
    }
    func getFood() -> [FoodItem] {
        return foodArray
    }
    
    
}
