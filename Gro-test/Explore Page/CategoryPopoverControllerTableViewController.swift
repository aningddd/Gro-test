//
//  CategoryPopoverControllerTableViewController.swift
//  Gro-test
//
//  Created by aning on 18/10/22.
//  Copyright © 2022 Shu Tong Luo. All rights reserved.
//

import UIKit

class CategoryPopoverControllerTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categories[indexPath.row]

        return cell
    }


}
