//
//  ViewController.swift
//  Dyal
//
//  Created by Арман on 5/1/18.
//  Copyright © 2018 Арман. All rights reserved.
//

import UIKit
import os.log

class FoodItemsViewController: UIViewController {
    
    
    var selectedItems = [FoodItem]()
    var editMode = false
    var nameRecieved: String?
    var potassiumRecieved: String?
    var sodiumRecieved: String?
    var imageNewRecieved: UIImage?
    
    
    
    
    @IBOutlet weak var foodCollection: UICollectionView!
    
    
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    
    
    lazy var newImageCount = imageDictionary.count
    
    private func saveFood() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(DataService.instance.getFood(), toFile: FoodItem.ArchiveURL.path)
        
        if isSuccessfulSave {
            os_log("Food saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save food :(", log: OSLog.default, type: .error)
        }
    }
    
    
  

    
    override func viewDidLoad() {
        super.viewDidLoad()
        foodCollection.delegate = self
        foodCollection.dataSource = self
        foodCollection.allowsSelection = true
        foodCollection.allowsMultipleSelection = false
        configureCollectionView(CGSize(width: view.frame.width, height: view.frame.height))
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: nil) { _ in
            self.configureCollectionView(size)
            self.foodCollection.collectionViewLayout.invalidateLayout()
        }
    }
    
    
    
    func configureCollectionView(_ size: CGSize) {
        var cellSize: CGSize
        let layout = UICollectionViewFlowLayout()
        print(UIDevice.IsPortrait ? "portrait oreintation":"landscape oreintation")
        print(UIDevice.isIPad ? "IPad": "IPhone")
        
        if UIDevice.IsPortrait {
            cellSize = CGSize(width: size.width - 45, height: size.height / 3)
        } else {
            cellSize = CGSize(width: size.width / 1.5, height: size.height / 1.8)
        }

        layout.headerReferenceSize = CGSize(width: 55, height: 65)
        layout.scrollDirection = .vertical
        layout.itemSize = cellSize
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        
        layout.minimumLineSpacing = 20.0
        layout.minimumInteritemSpacing = 20.0
        layout.footerReferenceSize = CGSize(width: 59, height: 70)
        foodCollection.setCollectionViewLayout(layout, animated: false)
//        foodCollection.collectionViewLayout = layout
        foodCollection.reloadData()
//        foodCollection.layoutIfNeeded()
        
        

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailsSegue"{
            if let destination = segue.destination as? DetailsViewController,
                let index = sender as? IndexPath {
                destination.name = DataService.instance.getFood()[index.row].name
                destination.image =  DataService.instance.getFood()[index.row].image
                destination.potassium = DataService.instance.getFood()[index.row].potassium
                destination.sodium = DataService.instance.getFood()[index.row].sodium
            }
        }
//        if segue.identifier == "AddSegue"{
//            if let destination = segue.destination as? AddFoodViewController {
//
//            }
//        }
    }


    @IBAction func tapAddButton(_ sender: Any) {
        if editMode {
            if let selected = foodCollection.indexPathsForSelectedItems {
                let items = selected.map {$0.item}.sorted().reversed()
                for item in items {
                    DataService.instance.removeFood(at: item)
                }
                foodCollection.deleteItems(at: selected)
            }
            turnEditMode("off")
        } else {
            performSegue(withIdentifier: "AddSegue", sender: sender)
        }
        
    }
    
    @IBAction func unwindTo(sender: UIStoryboardSegue) {}
    
    
    @IBAction func unwindwithDataTo(sender: UIStoryboardSegue) {
        print(DataService.instance.getFood().count)
        print(foodCollection.numberOfItems(inSection: 0))
        if let sourceViewController = sender.source as? AddFoodViewController {
            nameRecieved = sourceViewController.namePassed
            print(nameRecieved ?? "none")
            sodiumRecieved = sourceViewController.sodiumPassed
            potassiumRecieved = sourceViewController.potassiumPassed
            imageNewRecieved = sourceViewController.imageNewPassed
            DataService.instance.addFood(FoodItem(name: nameRecieved ?? "NoName",
                                                  image: imageNewRecieved ?? #imageLiteral(resourceName: "Image-placeholder"),
                                                  potassium: Float(potassiumRecieved ?? "0") ?? 0,
                                                  sodium: Float(sodiumRecieved  ?? "0") ?? 0))
            
            let index = IndexPath(row: DataService.instance.foodArray.count - 1, section: 0)
            foodCollection.insertItems(at: [index])
            //print(sourceViewController.imageNewPassed ?? "none")
            print(DataService.instance.getFood().count)
            print(foodCollection.numberOfItems(inSection: 0))
//            foodCollection.reloadData()
        }
    }
    
    
    func turnEditMode(_ state: String) {
        if state == "on" {
            foodCollection.allowsMultipleSelection = true
            editMode = true
        } else if state == "off" {
            editMode = false
            selectedItems.removeAll()
            foodCollection.deselectAllItems(animated: true)
            foodCollection.reloadData()
            foodCollection.allowsMultipleSelection = false
            
        }
    }
    
    
    @IBAction func editButtonTapped(_ sender: UIButton) {
        if editMode {
            turnEditMode("off")
            sender.setTitle("Удалить", for: .normal)
        } else {
            turnEditMode("on")
            sender.setTitle("Отмена", for: .normal)
        }
        print(selectedItems)
    }
    
    
    
    
    private func loadFood() -> [FoodItem]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: FoodItem.ArchiveURL.path) as? [FoodItem]
    }
    
}







extension FoodItemsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataService.instance.getFood().count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !editMode {
            foodCollection.deselectItem(at: indexPath, animated: false)
            performSegue(withIdentifier: "DetailsSegue", sender: indexPath)
        } else {
            if !selectedItems.contains(DataService.instance.getFood()[indexPath.row]){
                selectedItems.append(DataService.instance.getFood()[indexPath.row])
                print(selectedItems)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if editMode {
            selectedItems.removeAll { $0 == DataService.instance.getFood()[indexPath.row]}
            print(selectedItems)
        }


    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath) as! FoodHeaderFooterReusableView
            print("view header")
            headerView.label.text = "Еда"
            if editMode {
                headerView.addButton.setTitle("Удалить", for: .normal)
                headerView.deleteDoneButton.setTitle("Отмена", for: .normal)
            } else {
                headerView.addButton.setTitle("Добавить", for: .normal)
                headerView.deleteDoneButton.setTitle("Удалить", for: .normal)
            }
            
            return headerView
        case UICollectionView.elementKindSectionFooter:
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Footer", for: indexPath as IndexPath)
            return footerView
            
            
        default:
            assert(false, "Unexpected error with kind")
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodItem", for: indexPath) as! FoodCell
        if selectedItems.contains(DataService.instance.getFood()[indexPath.row]) {
            cell.isSelected = true
            foodCollection.selectItem(at: indexPath, animated: true, scrollPosition: [])
        }
        cell.name.text = DataService.instance.getFood()[indexPath.row].name
        cell.potassium.text = "K: \(DataService.instance.getFood()[indexPath.row].potassium)"
        cell.sodium.text = "Na: \(DataService.instance.getFood()[indexPath.row].sodium)"
        cell.image.image = DataService.instance.getFood()[indexPath.row].image
        return cell
    }
}
