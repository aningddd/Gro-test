//
//  CategoryPopoverControllerTableViewController.swift
//  Gro-test
//
//  Created by aning on 18/10/22.
//  Copyright © 2022 Shu Tong Luo. All rights reserved.
//

import UIKit

class CategoryPopoverControllerTableViewController: UITableViewController {

    var delegate: UIViewController!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        self.tableView.allowsMultipleSelection = true
        self.tableView.allowsMultipleSelectionDuringEditing = true
    }
    //make sure to update the label from the previous view controller with the selected categories
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isBeingDismissed{
            let otherVC = delegate as! TextChanger
            otherVC.changeText()
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell",
            for: indexPath) as? CheckableTableViewCell
        cell!.textLabel?.text = categories[indexPath.row]

        return cell!
    }
    //appending to selected categories if not already added
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(!selected_categories.contains(categories[indexPath.row])){
            selected_categories.append(categories[indexPath.row])
        }
    }
    //removing from selected categories in case we deselect a row
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let indexToRemove = selected_categories.firstIndex(of: categories[indexPath.row])
        selected_categories.remove(at: indexToRemove!)
    }
}
//checkable class to enable multiple selection of categories
class CheckableTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.accessoryType = selected ? .checkmark : .none
    }
}
