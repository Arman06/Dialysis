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
    var addedSupplementaryView: IndexPath?
    
//    override func initialLayoutAttributesForAppearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
//        guard let attributes = super.initialLayoutAttributesForAppearingItem(at: itemIndexPath),
//            let added = addedItem, added == itemIndexPath else {
//                return nil
//        }
//        attributes.zIndex = 5
//        attributes.center = CGPoint(x: collectionView!.frame.midX, y:  -collectionView!.frame.maxY)
//        attributes.alpha = 1
//        return attributes
//    }
//    
    override func initialLayoutAttributesForAppearingSupplementaryElement(ofKind elementKind: String, at elementIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let attributes = super.initialLayoutAttributesForAppearingItem(at: elementIndexPath),
            let added = addedSupplementaryView, added == elementIndexPath else {
                return nil
        }
        attributes.zIndex = 5
        attributes.center = CGPoint(x: collectionView!.frame.midX, y:  -collectionView!.frame.maxY)
        attributes.alpha = 1
        return attributes
    }
    
    
    override func prepare(forCollectionViewUpdates updateItems: [UICollectionViewUpdateItem]) {
        super.prepare(forCollectionViewUpdates: updateItems)
        
        for update in updateItems {
            switch update.updateAction {
            case .delete:
                guard let indexPath = update.indexPathBeforeUpdate else { return }
                deletedItems?.append(indexPath)
            case .insert:
                guard let indexPath = update.indexPathAfterUpdate else { return }
                addedItem = indexPath
            default:
                break
            }
        }
    }
    
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
