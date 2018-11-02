//
//  SearchViewController.swift
//  Dyal
//
//  Created by Арман on 11/1/18.
//  Copyright © 2018 Арман. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    var searchFood = [FoodItem]()
    var searching = false
    
    @IBOutlet weak var foodSearchBar: UISearchBar!
    @IBOutlet weak var foodTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        foodTableView.delegate = self
        foodTableView.dataSource = self
        foodSearchBar.delegate = self
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return searchFood.count
        } else {
            return DataService.instance.numberOfItemsInSections()
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "DetailsSegue", sender: indexPath)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = foodTableView.dequeueReusableCell(withIdentifier: "foodSearchCell", for: indexPath) as! FoodTableViewCell
        if searching {
            cell.nameLabel.text = searchFood[indexPath.row].name
            cell.potassiumLabel.text = "K: \(searchFood[indexPath.row].potassium)"
            cell.sodiumLabel.text = "Na: \(searchFood[indexPath.row].sodium)"
        } else {
            cell.nameLabel.text = DataService.instance.getFoodForTableView(for: indexPath).name
            cell.potassiumLabel.text = "K: \(DataService.instance.getFoodForTableView(for: indexPath).potassium)"
            cell.sodiumLabel.text = "Na: \(DataService.instance.getFoodForTableView(for: indexPath).sodium)"
        }
        return cell
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
        
    }
    
    
    
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchFood = DataService.instance.getFood().filter({
            String($0.sodium).prefix(searchText.count) == searchText ||
            $0.name.prefix(searchText.count) == searchText ||
                String($0.potassium).prefix(searchText.count) == searchText})
        searching = true
        foodTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
//        searchBar.text = ""
        foodSearchBar.endEditing(true)
        foodTableView.reloadData()
    }
}
