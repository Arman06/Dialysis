//
//  foodItems.swift
//  Dyal
//
//  Created by Арман on 5/2/18.
//  Copyright © 2018 Арман. All rights reserved.
//

import Foundation
import os.log

class foodItem : NSObject, NSCoding {
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(potassium, forKey: PropertyKey.potassium)
        aCoder.encode(sodium, forKey: PropertyKey.sodium)
        aCoder.encode(imageName, forKey: PropertyKey.imageName)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode name.", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let imageName = aDecoder.decodeObject(forKey: PropertyKey.imageName) as? String else {
            os_log("Unable to decode imageName", log: OSLog.default, type: .debug)
            return nil
        }
        
        let potassium = aDecoder.decodeFloat(forKey: PropertyKey.potassium)
        
        let sodium = aDecoder.decodeFloat(forKey: PropertyKey.sodium)
        
        self.init(name: name, imageName: imageName, potassium: potassium, sodium: sodium)
    }
    
    private(set) var name: String
    //private(set) var fluorine: Float
    private(set) var potassium: Float
    private(set) var sodium: Float
    private(set) var imageName: String
    
    static let DocumentsDirectory = FileManager.documentURL
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("foodItems")
    
    
    init(name: String, imageName: String,/* fluorine: Float,*/ potassium: Float, sodium: Float) {
        self.name = name
        self.imageName = imageName
        //self.fluorine = fluorine
        self.potassium = potassium
        self.sodium = sodium
    }
}



struct PropertyKey {
    static let name = "name"
    static let potassium = "potassium"
    static let sodium = "sodium"
    static let imageName = "imageName"
}


extension FileManager {
    static var documentURL: URL {
        return FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    }
}
