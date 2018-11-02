//
//  data.swift
//  Dyal
//
//  Created by Арман on 9/16/18.
//  Copyright © 2018 Арман. All rights reserved.
//

import UIKit

final class DataService {
    static let instance = DataService()
    
    private let currentDate = Date()
    
    lazy private var dateArray = Array(foodArray.keys.sorted(by: >))
    
    
    lazy private var foodArray =
        [currentDate: [FoodItem(name: "Яблоко", image: UIImage(named: "apple.jpg") ?? #imageLiteral(resourceName: "Image-placeholder"), potassium: 107, sodium: 1),
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
                        FoodItem(name: "Лимон", image: UIImage(named: "lemon.jpg") ?? #imageLiteral(resourceName: "Image-placeholder"), potassium: 138, sodium: 2)],
         Date.yesterday:[FoodItem(name: "Яблоко", image: UIImage(named: "apple.jpg") ?? #imageLiteral(resourceName: "Image-placeholder"), potassium: 107, sodium: 1),
                         FoodItem(name: "Ананас", image: UIImage(named: "pineapple.jpg") ?? #imageLiteral(resourceName: "Image-placeholder"), potassium: 109, sodium: 1),
                         FoodItem(name: "Апельсин", image: UIImage(named: "orange.jpg") ?? #imageLiteral(resourceName: "Image-placeholder"), potassium: 181, sodium: 0),
                         FoodItem(name: "Персик", image: UIImage(named: "peach.jpg") ?? #imageLiteral(resourceName: "Image-placeholder"), potassium: 190, sodium: 0)],
         Date.yesterday.dayBefore:[FoodItem(name: "Ананас", image: UIImage(named: "pineapple.jpg") ?? #imageLiteral(resourceName: "Image-placeholder"), potassium: 109, sodium: 1),
                                   FoodItem(name: "Апельсин", image: UIImage(named: "orange.jpg") ?? #imageLiteral(resourceName: "Image-placeholder"), potassium: 181, sodium: 0),
                                   FoodItem(name: "Персик", image: UIImage(named: "peach.jpg") ?? #imageLiteral(resourceName: "Image-placeholder"), potassium: 190, sodium: 0),
                                   FoodItem(name: "Банан", image: UIImage(named: "banana.jpg") ?? #imageLiteral(resourceName: "Image-placeholder"), potassium: 358, sodium: 1),
                                   FoodItem(name: "Лимон", image: UIImage(named: "lemon.jpg") ?? #imageLiteral(resourceName: "Image-placeholder"), potassium: 138, sodium: 2)]
         ]
    
   
   
    
    func addFood(at indexPath: IndexPath, _ food: FoodItem) {
        foodArray[dateArray[indexPath.section]]!.insert(food, at: indexPath.row)
    }
    
    func removeFood(at indexPath: IndexPath) {
        foodArray[dateArray[indexPath.section]]!.remove(at: indexPath.row)
    }
    
    func removeFood(_ array: [FoodItem]) -> [IndexPath] {
        var index = [IndexPath]()
        for selectedItem in array {
            for date in dateArray {
                if let selectedIndex = foodArray[date]!.firstIndex(of: selectedItem) {
                    index.append(IndexPath(row: selectedIndex, section: dateArray.firstIndex(of: date)!))
                }
            }
        }
        
        for selectedItem in array {
            for date in dateArray {
                if let selectedIndex = foodArray[date]!.firstIndex(of: selectedItem) {
                    foodArray[date]!.remove(at: selectedIndex)
                }
            }
        }
        return index
        
    }
    
    func getFood() -> [FoodItem] {
        return Array(foodArray.values).flatMap{ $0 }
    }
    
    func getDates() -> [Date] {
        return dateArray
    }
    
    func getFood(for section: Int) -> [FoodItem] {
        return foodArray[dateArray[section]] ?? [FoodItem]()
    }
    
    func getFoodNames() -> [String] {
        return Array(foodArray.values).flatMap{ $0 }.map{ $0.name }
    }
    
    func getFood(for indexPath: IndexPath) -> FoodItem {
        return foodArray[dateArray[indexPath.section]]![indexPath.row]
    }
    
    func getFoodForTableView(for indexPath: IndexPath) -> FoodItem {
        return Array(foodArray.values).flatMap{ $0 }[indexPath.row]
    }
    
    func numberOfSections() -> Int {
        return dateArray.count
    }
    
    
    func numberOfItemsInSection(_ section: Int) -> Int {
        return getFood(for: section).count
    }
    
    func numberOfItemsInSections() -> Int {
        return Array(foodArray.values).flatMap{ $0 }.count
    }
    func checkDate() {
        
    }
    
    private func dateToString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy"
        return " \(dateFormatter.string(from: date))"
    }
    
    func stringDateFor(for indexPath: IndexPath) -> String {
        return dateToString(dateArray[indexPath.section])
    }
    
}
