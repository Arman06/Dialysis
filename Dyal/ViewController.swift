//
//  ViewController.swift
//  Dyal
//
//  Created by Арман on 5/1/18.
//  Copyright © 2018 Арман. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
  
    @IBOutlet weak var foodCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let cellSize = CGSize(width: view.frame.width - 40, height: view.frame.height / 3.5)
        let layout = UICollectionViewFlowLayout()
        layout.headerReferenceSize = CGSize(width: 55, height: 59)
        layout.scrollDirection = .vertical
        layout.itemSize = cellSize
        //layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumLineSpacing = 20.0
        layout.minimumInteritemSpacing = 20.0
        layout.footerReferenceSize = CGSize(width: 59, height: 70)
        foodCollection.setCollectionViewLayout(layout, animated: true)
        foodCollection.reloadData()
        
    }


    @IBAction func tapAddButton(_ sender: Any) {
        print("tap")
    }
    

}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataService.instance.getFood().count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath)
            if let label = headerView.viewWithTag(25) as? UILabel {
                label.text = "Еда"
            }
            return headerView
        case UICollectionView.elementKindSectionFooter:
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Footer", for: indexPath as IndexPath)
            return footerView
            
            
        default:
            print("loled")
            assert(false, "Unexpected error with kind")
        }
        
    }
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodItem", for: indexPath)
        if let label = cell.viewWithTag(2) as? UILabel {
            label.text = DataService.instance.getFood()[indexPath.row].name
        }
        if let image = cell.viewWithTag(15) as? UIImageView {
            image.image = UIImage(named: DataService.instance.getFood()[indexPath.row].imageName)
        }
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 2, height: 15)
        cell.layer.shadowOpacity = 0.1
        cell.layer.shadowRadius = 4.0
        cell.layer.masksToBounds = false
        cell.contentView.layer.cornerRadius = 13
        cell.contentView.layer.masksToBounds = true
        return cell
    }
    
    
    
    
    
    
    
}
