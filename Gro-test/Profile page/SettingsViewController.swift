//
//  SettingsViewController.swift
//  Gro-test
//
//  Created by Luo, Shu Tong on 10/28/22.
//  Copyright © 2022 Shu Tong Luo. All rights reserved.
//

import UIKit

//protocol to update the table dynamically
protocol TableRefresher{
    func updateTable()
}

class SettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, TableRefresher {

    @IBOutlet weak var settingTable: UITableView!
    
    var userEmail = ""
    var profileImage = UIImage()
    let editNameSegueIdentifier = "editNameSegue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingTable.delegate = self
        settingTable.dataSource = self
        settingTable.backgroundColor = UIColor(named: "Grey E")
        // Do any additional setup after loading the view.
    }
    func updateTable(){
        settingTable.reloadData()
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
            DataManager.app.retrieveUserData(email: self.userEmail){
                result in
                var user = result[0] as! UserData
                cell.userName.text = user.userName
                cell.emailLabel.text = user.email
                cell.profileImage.image = user.avatar
                self.profileImage = user.avatar
                
            }
            cell.contentView.backgroundColor = UIColor(named: "Grey E")
            cell.view.layer.cornerRadius = 10
            return cell
        } else {
            let cell = settingTable.dequeueReusableCell(withIdentifier: "BottomCell", for: indexPath) as! SettingBottomTableViewCell
            cell.parentVC = self
            cell.contentView.backgroundColor = UIColor(named: "Grey E")
            cell.view.layer.cornerRadius = 10
            return cell
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == self.editNameSegueIdentifier, let editNameVC = segue.destination as? EditNameViewController{
            editNameVC.emailField = self.userEmail
            editNameVC.image = self.profileImage
            editNameVC.delegate = self
        }
    }
    

}
