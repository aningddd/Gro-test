//
//  TmpAdmimRegisterVC.swift
//  Gro-test
//
//  Created by Bowen一一＂一 yang一一 on 10/18/22.
//  Copyright © 2022 Shu Tong Luo. All rights reserved.
//

import UIKit
let registerContent1 = ["Email", "Password","Re-enter Password", "Orgname"]
class TmpAdmimRegisterVC: UIViewController,UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tmpAdminRegisterMainTable: UITableView!
    @IBOutlet weak var TmpAdminRegisterTitleLabel: UILabel!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return registerContent1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "registerTC", for: indexPath) as! LabelTextFieldCell
        cell.titleLabelForCell.text = registerContent1[indexPath.row]
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tmpAdminRegisterMainTable.delegate = self
        tmpAdminRegisterMainTable.dataSource = self

        TmpAdminRegisterTitleLabel.font = UIFont(name:"ArialRoundedMTBold",size:30.0)
        TmpAdminRegisterTitleLabel.text = "Admin Register"
        
    }


}
