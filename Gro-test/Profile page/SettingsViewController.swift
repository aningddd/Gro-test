//
//  SettingsViewController.swift
//  Gro-test
//
//  Created by Luo, Shu Tong on 10/28/22.
//  Copyright © 2022 Shu Tong Luo. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var settingTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingTable.delegate = self
        settingTable.dataSource = self
        settingTable.backgroundColor = UIColor(named: "Grey E")
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        var height:CGFloat = CGFloat()
        if indexPath.row == 0 {
            height = 180
        }
        else {
            height = 130
        }
        return height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row == 0) {
            let cell = settingTable.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! SettingTopTableViewCell
            return cell
        } else {
            let cell = settingTable.dequeueReusableCell(withIdentifier: "BottomCell", for: indexPath)
            return cell
        }
    }
    

}
