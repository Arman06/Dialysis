//
//  FoodItemData+CoreDataProperties.swift
//  
//
//  Created by Арман on 11/2/18.
//
//

import Foundation
import CoreData


extension FoodItemData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FoodItemData> {
        return NSFetchRequest<FoodItemData>(entityName: "FoodItemData")
    }

    @NSManaged public var name: String?
    @NSManaged public var image: NSData?
    @NSManaged public var sodium: Float
    @NSManaged public var potassium: Float
    @NSManaged public var date: NSDate?

}
