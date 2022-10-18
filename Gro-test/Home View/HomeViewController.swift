//
//  HomeViewController.swift
//  Gro-test
//
//  Created by aning on 15/10/22.
//  Copyright © 2022 Shu Tong Luo. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 135
        tableView.backgroundColor = UIColor(named: "Grey E")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrgCell", for: indexPath) as! OrgTableViewCell
        
        cell.contentView.backgroundColor = UIColor(named: "Grey E")
        cell.view.layer.cornerRadius = 10
        
        return cell
    }

}
