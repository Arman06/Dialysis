//
//  CustomFlowLayout.swift
//  Dyal
//
//  Created by Арман on 10/25/18.
//  Copyright © 2018 Арман. All rights reserved.
//

import UIKit

class CustomFlowLayout: UICollectionViewFlowLayout {
    var addedItem: IndexPath?
    var deletedItems: [IndexPath]? = nil
    
//    override func initialLayoutAttributesForAppearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
//        guard let attributes = super.initialLayoutAttributesForAppearingItem(at: itemIndexPath),
//            let added = addedItem, added == itemIndexPath else {
//                return nil
//        }
//        attributes.zIndex = 5
////        attributes.center = CGPoint(x: collectionView!.frame.width, y: collectionView!.frame.height)
////        attributes.alpha = 1
//        return attributes
//    }
    
    
    
    override func finalLayoutAttributesForDisappearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let attributes = super.finalLayoutAttributesForDisappearingItem(at: itemIndexPath),
        let deleted = deletedItems,
            deleted.contains(itemIndexPath) else {
                return nil
        }
        attributes.center = CGPoint(x: collectionView!.frame.midX, y:  -collectionView!.frame.maxY)
        attributes.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        attributes.alpha = 0
        attributes.zIndex = 5
        
        return attributes
    }
}
