//
//  ViewController.swift
//  Dyal
//
//  Created by Арман on 5/1/18.
//  Copyright © 2018 Арман. All rights reserved.
//

import UIKit
import os.log

class ViewController: UIViewController {
    
  
    @IBOutlet weak var foodCollection: UICollectionView!
    
    
    private func saveFood() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(DataService.instance.getFood(), toFile: foodItem.ArchiveURL.path)
        
        if isSuccessfulSave {
            os_log("Food saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save food :(", log: OSLog.default, type: .error)
        }
    }
    
    
    func oreintationIsPortatrait() -> Bool {
        let size = UIScreen.main.bounds.size
        if size.width < size.height {
            return true
        } else {
            return false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        foodCollection.delegate = self
        foodCollection.dataSource = self
        configureCollectionView(CGSize(width: view.frame.width, height: view.frame.height))
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        configureCollectionView(size)
    }
    
    func configureCollectionView(_ size: CGSize) {
        var cellSize: CGSize
        print(oreintationIsPortatrait())
        if oreintationIsPortatrait() {
            cellSize = CGSize(width: size.width - 45, height: size.height / 3)
        } else {
            cellSize = CGSize(width: size.width / 1.5, height: size.height / 1.8)
        }

        let layout = UICollectionViewFlowLayout()
        layout.headerReferenceSize = CGSize(width: 55, height: 65)
        layout.scrollDirection = .vertical
        layout.itemSize = cellSize
        layout.sectionInset = UIEdgeInsets(top: 10, left: 1, bottom: 10, right: 1)
        layout.minimumLineSpacing = 20.0
        layout.minimumInteritemSpacing = 20.0
        layout.footerReferenceSize = CGSize(width: 59, height: 70)
        foodCollection.setCollectionViewLayout(layout, animated: true)
        foodCollection.reloadData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailsSegue"{
            if let destination = segue.destination as? DetailsViewController,
                let index = sender as? IndexPath {
                destination.name = DataService.instance.getFood()[index.row].name
                destination.imageName = DataService.instance.getFood()[index.row].imageName
            }
        }
    }


    @IBAction func tapAddButton(_ sender: Any) {
        print("tap")
    }
    

    @IBAction func unwindTo(sender: UIStoryboardSegue) {}
    
    
    private func loadFood() -> [foodItem]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: foodItem.ArchiveURL.path) as? [foodItem]
    }
    
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataService.instance.getFood().count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodItem", for: indexPath)
        performSegue(withIdentifier: "DetailsSegue", sender: indexPath)
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
        if let label = cell.viewWithTag(34) as? UILabel {
            label.text = "K: \(DataService.instance.getFood()[indexPath.row].potassium)"
        }
        if let label = cell.viewWithTag(35) as? UILabel {
            label.text = "Na: \(DataService.instance.getFood()[indexPath.row].sodium)"
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
