//
//  data.swift
//  Dyal
//
//  Created by Арман on 9/16/18.
//  Copyright © 2018 Арман. All rights reserved.
//

import UIKit
import CoreData

final class DataService {
    static let instance = DataService()
    var dates = [Date]()
    
    init() {
        var allFoodArray = [FoodItemData]()
        do {
            allFoodArray = try context.fetch(FoodItemData.fetchRequest())
        } catch let error as NSError {
            print("Fetching Problem: \(error)")
        }

        for food in allFoodArray {
            dates.append((food.date! as Date).stripTime())
            foodArray[food.date! as Date]?.append(food)
        }
        for date in dates {
            var array = [FoodItemData]()
            for food in allFoodArray {
                if (food.date! as Date).stripTime() == date {
                    array.append(food)
                }
            }
            foodArray[date] = array.reversed()
        }
    }
    
    private var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    let currentDate = Date()
    
    lazy private var dateArray = Array(foodArray.keys.sorted(by: >))
    
    
    lazy private var foodArray = [currentDate.stripTime():[FoodItemData]()]
   
   
    
    func addFood(at indexPath: IndexPath, _ food: FoodItem) {
        let foodDataItem = FoodItemData(entity: FoodItemData.entity(), insertInto: context)
        foodDataItem.name = food.name
        foodDataItem.potassium = food.potassium
        foodDataItem.sodium = food.sodium
        foodDataItem.image = food.image.pngData() as NSData?
        foodDataItem.date = food.date as NSDate
        foodArray[dateArray[indexPath.section]]!.insert(foodDataItem, at: indexPath.row)
        appDelegate.saveContext()
        
    }
    
    func removeFood(at indexPath: IndexPath) {
        foodArray[dateArray[indexPath.section]]!.remove(at: indexPath.row)
    }
    
    func removeFood(_ array: [FoodItemData]) -> [IndexPath] {
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
                    context.delete(foodArray[date]![selectedIndex])
                    foodArray[date]!.remove(at: selectedIndex)
                }
            }
        }
        appDelegate.saveContext()
        return index
        
    }
    
    func getFood() -> [FoodItemData] {
        return Array(foodArray.values).flatMap{ $0 }
    }
    
    func getDates() -> [Date] {
        return dateArray
    }
    
    func getFood(for section: Int) -> [FoodItemData] {
        return foodArray[dateArray[section]] ?? [FoodItemData]()
    }
    
    func getFoodNames() -> [String] {
        return Array(foodArray.values).flatMap{ $0 }.map{ $0.name ?? "Без имени" }
    }
    
    func getFood(for indexPath: IndexPath) -> FoodItemData {
        return foodArray[dateArray[indexPath.section]]![indexPath.row]
    }
    
    func getFoodForTableView(for indexPath: IndexPath) -> FoodItemData {
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
    func allSodium() -> Double {
        var sodium = 0.0
        for food in foodArray[currentDate.stripTime()]! {
            sodium += Double(food.sodium)
        }
        return sodium
    }
    
    func allPotassium() -> Double {
        var potassium = 0.0
        for food in foodArray[currentDate.stripTime()]! {
            potassium += Double(food.potassium)
        }
        return potassium
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
