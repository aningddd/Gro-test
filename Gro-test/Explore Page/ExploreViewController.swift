//
//  ExploreViewController.swift
//  Gro-test
//
//  Created by aning on 17/10/22.
//  Copyright © 2022 Shu Tong Luo. All rights reserved.
//

import UIKit

protocol TextChanger{
    func changeText()
}
let categories = ["Academic", "Greek Life", "Volunteering", "Sports", "Culture"]
public var selected_categories : [String] = []


class ExploreViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, TextChanger {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var categoryList: UILabel!
    var filteredData: [String]!
    let categorySegue = "categoryPopoverSegue"
    //for testing purposes
    var newAllOrgs:[String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchBar.layer.cornerRadius = 5
        categoryView.layer.cornerRadius = 5
        plusButton.setImage(UIImage(systemName:"plus")?.withRenderingMode(.alwaysTemplate), for: .normal)
        plusButton.tintColor = .black
        tableView.dataSource = self
        searchBar.delegate = self
        //for testing purposes - in the future, show all possible organizations that the user is NOT subscribed to
        newAllOrgs = allOrgs
        newAllOrgs.append("academic test org")
        newAllOrgs.append("greek life test org")
        newAllOrgs.append("volunteering test org")
        newAllOrgs.append("sports test org")
        newAllOrgs.append("culture test org")
        filteredData = newAllOrgs
        tableView.rowHeight = 135
    }
    
    //change the label of the selected categories once the popover table is dismissed
    func changeText() {
        super.viewWillAppear(true)
        if(selected_categories.count == 0){
            categoryList.text = "Categories selected: None"
        }
        else{
            var categoriesString = ""
            for category in selected_categories {
                categoriesString += "\(category), "
            }
            //for tidying up purposes (removing last comma and space)
            let mySubstring = categoriesString.prefix(categoriesString.count - 2)
            categoryList.text = "Categories selected: \(String(mySubstring))"
        }
    }
    
    //displaying each result as an org table cell to view more info about
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrgCell", for: indexPath) as! OrgTableViewCell
        
        cell.contentView.backgroundColor = UIColor(named: "Grey E")
        cell.view.layer.cornerRadius = 10
        cell.orgNameLabel.text = filteredData[indexPath.row]
        cell.toEventsButton.tag = indexPath.row
        cell.toEventsButton.addTarget(self, action: #selector(eventButtonPressed), for: .touchUpInside)
        
        return cell
    }
    
    @objc func eventButtonPressed(sender: UIButton) {
        let index = IndexPath(row: sender.tag, section: 0)
        selectedOrg = filteredData[index.row]
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // This method updates filteredData based on the text in the Search Box
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // When there is no text, filteredData is the same as the original data
        // When user has entered text into the search box
        // Use the filter method to iterate over all items in the data array
        // For each item, return true if the item should be included and false if the
        // item should NOT be included
        filteredData = searchText.isEmpty ? newAllOrgs : newAllOrgs.filter { (item: String) -> Bool in
            // If dataItem matches the searchText or the categories, return true to include it
            var containsCategory : Bool = false
            for category in selected_categories{
                if(item.range(of: category, options: .caseInsensitive, range: nil, locale: nil) != nil){
                    containsCategory = true
                }
            }
            if selected_categories.count > 0 && !containsCategory{
                return false
            }
            return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        
        tableView.reloadData()
    }
    //clear selected categories every time we trigger the popover table
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == self.categorySegue, let nextVC = segue.destination as? CategoryPopoverControllerTableViewController {
            nextVC.delegate = self
            selected_categories.removeAll()
        }
    }
}

