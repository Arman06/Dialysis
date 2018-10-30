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
    
    @IBOutlet weak var headerDateLabel: UILabel!
    @IBOutlet weak var headerCustomView: UIView!
    @IBOutlet weak var headerDeleteButton: UIButton!
    @IBOutlet weak var headerAddButton: UIButton!
    
    @IBOutlet weak var foodCollection: UICollectionView!
    
    
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    
    
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
        configureCustomHeader()
        configureCollectionView(CGSize(width: view.frame.width, height: view.frame.height))
        
    }
    
    func configureCustomHeader() {
        headerAddButton.setTitle("Добавить", for: .normal)
//        headerAddButton.addTarget(self, action: #selector(tapAddCustomButton(_:)), for: .touchUpInside)
        headerDeleteButton.setTitle("Удалить", for: .normal)
        headerDeleteButton.addTarget(self, action: #selector(editCustomButtonTapped(_:)), for: .touchUpInside)
        headerCustomView.layer.cornerRadius = 10
        headerCustomView.layer.shadowColor = UIColor.black.cgColor
        headerCustomView.layer.shadowOffset = CGSize(width: 0, height: 0)
        headerCustomView.layer.shadowOpacity = 0.3
        headerCustomView.layer.shadowRadius = 2.0
        headerCustomView.layer.masksToBounds = false
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
        let layout = CustomFlowLayout()
        print(UIDevice.IsPortrait ? "portrait oreintation":"landscape oreintation")
        print(UIDevice.isIPad ? "IPad": "IPhone")
        
        if UIDevice.IsPortrait {
            cellSize = CGSize(width: size.width - 45, height: size.height / 3)
            layout.minimumLineSpacing = 25.0
            layout.minimumInteritemSpacing = 20.0
            layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        } else {
            cellSize = CGSize(width: size.width / 2.5, height: size.width / 3.5)
            layout.minimumLineSpacing = 25.0
            layout.minimumInteritemSpacing = 0
            layout.sectionInset = UIEdgeInsets(top: 10, left: 60, bottom: 10, right: 60)
        }
        
        print(size.height)
        layout.headerReferenceSize = CGSize(width: size.width, height: 110)
        layout.sectionHeadersPinToVisibleBounds = true
        layout.scrollDirection = .vertical
        layout.itemSize = cellSize
        layout.footerReferenceSize = CGSize(width: 59, height: 70)
        foodCollection.setCollectionViewLayout(layout, animated: false)
        foodCollection.reloadData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailsSegue" {
            if let destination = segue.destination as? DetailsViewController,
                let indexPath = sender as? IndexPath {
                destination.name = DataService.instance.getFood(for: indexPath).name
                destination.image =  DataService.instance.getFood(for: indexPath).image
                destination.potassium = DataService.instance.getFood(for: indexPath).potassium
                destination.sodium = DataService.instance.getFood(for: indexPath).sodium
            }
        }
        
        if segue.identifier == "AddSegue" {
            if let destination = segue.destination as? AddFoodViewController {
                if let button = sender as? BlueRoundButton {
                    destination.section = button.section
                }
            }
        }
        
    }


    @IBAction func tapAddButton(_ sender: UIButton) {
        if editMode {
            let index = DataService.instance.removeFood(selectedItems)
            let layout = foodCollection?.collectionViewLayout as! CustomFlowLayout
            layout.deletedItems = index
                UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
                    self.foodCollection.deleteItems(at: index)
                    sender.setTitle("Добавить", for: .normal)
                    sender.backgroundColor = UIColor(red:0.00, green:0.55, blue:1.0, alpha: 1)
                }, completion: nil)
            let headers = foodCollection.visibleSupplementaryViews(ofKind:  UICollectionView.elementKindSectionHeader)
            for header in headers {
                if let headerView = header as? FoodHeaderFooterReusableView {
                    headerView.addButton.setTitle("Добавить", for: .normal)
                    headerView.deleteDoneButton.setTitle("Удалить", for: .normal)
                    headerView.addButton.backgroundColor = UIColor(red:0.00, green:0.55, blue:1.0, alpha: 1)
                }
                }
                
            turnEditMode("off")
        } else {
            performSegue(withIdentifier: "AddSegue", sender: sender)
        }
    }
    
//    @objc func tapAddCustomButton(_ sender: Any) {
//        if editMode {
//            headerButtonsTitleSwapColorChange("off")
//            var index = [IndexPath]()
//            for selectedItem in selectedItems {
//                if let selectedIndex = DataService.instance.getFood().firstIndex(of: selectedItem){
//                    index.append(IndexPath(row: selectedIndex, section: 0))
//                }
//            }
//            for selectedItem in selectedItems {
//                if let selectedIndex = DataService.instance.getFood().firstIndex(of: selectedItem){
//                    DataService.instance.removeFood(at: selectedIndex)
//                }
//            }
//            let layout = foodCollection?.collectionViewLayout as! CustomFlowLayout
//            layout.deletedItems = index
//            UIView.animate(withDuration: 0.7, delay: 0, options: .curveEaseInOut, animations: {
//                self.foodCollection.deleteItems(at: index)
//            }, completion: nil)
//
//
//            turnEditMode("off")
//        } else {
////            performSegue(withIdentifier: "AddSegue", sender: sender)
//        }
//    }
    
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
            let sectionRecieved = sourceViewController.section
            let index = IndexPath(row: 0, section: sectionRecieved!)
            DataService.instance.addFood(at: index, FoodItem(name: nameRecieved ?? "NoName",
                                                                 image: imageNewRecieved ?? #imageLiteral(resourceName: "Image-placeholder"),
                                                                 potassium: Float(potassiumRecieved ?? "0") ?? 0,
                                                                 sodium: Float(sodiumRecieved  ?? "0") ?? 0))
            self.foodCollection.insertItems(at: [index])
            
            
        }
    }
    
    func headerButtonsTitleSwapColorChange(_ state: String) {
        if state == "off" {
            headerAddButton.setTitle("Добавить", for: .normal)
            headerAddButton.backgroundColor = UIColor(red:0.00, green:0.55, blue:1.0, alpha: 1)
            headerDeleteButton.setTitle("Удалить", for: .normal)
        } else if state == "on" {
            headerDeleteButton.setTitle("Отмена", for: .normal)
            headerAddButton.setTitle("Удалить", for: .normal)
            headerAddButton.backgroundColor = #colorLiteral(red: 1, green: 0.3513356447, blue: 0.3235116899, alpha: 1)
        }
    }
    
    func turnEditMode(_ state: String) {
        if state == "on" {
            editMode = true
            foodCollection.allowsMultipleSelection = true
            foodCollection.deselectAllItems(animated: false)
            foodCollection.turnEditModeOnForAllItems()
//            foodCollection.reloadItems(at: foodCollection.indexPathsForVisibleItems)
            foodCollection.reloadData()
        } else if state == "off" {
            editMode = false
            selectedItems.removeAll()
            foodCollection.deselectAllItems(animated: false)
            foodCollection.turnEditModeOffForAllItems()
            foodCollection.allowsMultipleSelection = false
//            foodCollection.reloadItems(at: foodCollection.indexPathsForVisibleItems)
            foodCollection.reloadData()
        }
    }
    
    
    @IBAction func editButtonTapped(_ sender: UIButton) {
        if editMode {
            
            sender.setTitle("Удалить", for: .normal)
            turnEditMode("off")
        } else {
            
            sender.setTitle("Отмена", for: .normal)
            turnEditMode("on")
        }
    }
    
    @objc func editCustomButtonTapped(_ sender: UIButton) {
        if editMode {
            headerButtonsTitleSwapColorChange("off")
            turnEditMode("off")
        } else {
            headerButtonsTitleSwapColorChange("on")
            turnEditMode("on")
        }
    }
    
    
    
    
    private func loadFood() -> [FoodItem]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: FoodItem.ArchiveURL.path) as? [FoodItem]
    }
    
}





extension FoodItemsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    @IBAction func scrollToBegin(_ sender: UIButton) {
        foodCollection.scrollToItem(at: IndexPath(row: 0, section: 0), at: UICollectionView.ScrollPosition.top, animated: true)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return DataService.instance.numberOfSections()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataService.instance.numberOfItemsInSection(section)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !editMode {
            let cell = foodCollection.cellForItem(at: indexPath) as? FoodCell
            foodCollection.turnEditModeOff(at: indexPath)
            cell?.isEditing = false
            print(cell!.isEditing)
            foodCollection.deselectAllVisibleItems(animated: false)
            performSegue(withIdentifier: "DetailsSegue", sender: indexPath)
        } else {
            let cell = foodCollection.cellForItem(at: indexPath) as? FoodCell
            foodCollection.turnEditModeOn(at: indexPath)
            print(cell!.isEditing)
                if !self.selectedItems.contains(DataService.instance.getFood(for: indexPath)){
                    self.selectedItems.append(DataService.instance.getFood(for: indexPath))
                    print(self.selectedItems)
            }
        }
    }

    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if editMode {
            selectedItems.removeAll { $0 == DataService.instance.getFood(for: indexPath)}
            print(selectedItems)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath) as! FoodHeaderFooterReusableView
            print("render header " + String(indexPath.section))
            headerView.label.text = String(DataService.instance.stringDateFor(for: indexPath))

            if let addbutton = headerView.addButton as? BlueRoundButton {
                addbutton.section = indexPath.section
            }
            if let editbutton = headerView.deleteDoneButton as? BlueRoundButton {
                editbutton.section = indexPath.section
            }
            if editMode {
                headerView.addButton.setTitle("Удалить", for: .normal)
                headerView.deleteDoneButton.setTitle("Отмена", for: .normal)
                headerView.addButton.backgroundColor = #colorLiteral(red: 1, green: 0.3513356447, blue: 0.3235116899, alpha: 1)
            } else {
                print("delete 5")
                headerView.addButton.setTitle("Добавить", for: .normal)
                headerView.deleteDoneButton.setTitle("Удалить", for: .normal)
                headerView.addButton.backgroundColor = UIColor(red:0.00, green:0.55, blue:1.0, alpha: 1)
                
            }
            return headerView
        case UICollectionView.elementKindSectionFooter:
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Footer", for: indexPath as IndexPath)
//            headerDateLabel.text = String(indexPath.section + 1)

//            headerDateLabel.text = String(indexPath.section)
            return footerView
        default:
            assert(false, "Unexpected error with kind")
        }
        
    }
 

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodItem", for: indexPath) as! FoodCell
        if editMode {
            cell.isEditing = true
            foodCollection.turnEditModeOn(at: indexPath)
            if selectedItems.contains(DataService.instance.getFood(for: indexPath)) {
                cell.isSelected = true
                foodCollection.selectItem(at: indexPath, animated: false, scrollPosition: [])
            }
        } else {
            cell.isEditing = false
            foodCollection.turnEditModeOff(at: indexPath)
        }
        cell.name.text = DataService.instance.getFood(for: indexPath).name
        cell.potassium.text = "K: \(DataService.instance.getFood(for: indexPath).potassium)"
        cell.sodium.text = "Na: \(DataService.instance.getFood(for: indexPath).sodium)"
        cell.image.image = DataService.instance.getFood(for: indexPath).image
        return cell
    }
}
