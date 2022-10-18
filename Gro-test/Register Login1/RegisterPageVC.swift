//
//  RegisterPageVC.swift
//  Gro-test
//
//  Created by Bowen一一＂一 yang一一 on 10/18/22.
//  Copyright © 2022 Shu Tong Luo. All rights reserved.
//

import UIKit
let registerContent = ["Email", "Password","Re-enter Password", "Username"]
class RegisterPageVC: UIViewController,UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var registerPageTitleLabel: UILabel!
    

    @IBOutlet weak var mainTable: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return registerContent.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "registerTC", for: indexPath) as! LabelTextFieldCell
        cell.titleLabelForCell.text = registerContent[indexPath.row]
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTable.delegate = self
        mainTable.dataSource = self
        registerPageTitleLabel.font = UIFont(name:"ArialRoundedMTBold",size:30.0)
        // Do any additional setup after loading the view.
    }


}
