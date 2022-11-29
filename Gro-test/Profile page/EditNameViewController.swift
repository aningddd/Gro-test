//
//  EditNameViewController.swift
//  Gro-test
//
//  Created by Chris Chen on 11/29/22.
//  Copyright © 2022 Shu Tong Luo. All rights reserved.
//

import UIKit

class EditNameViewController: UIViewController {
    @IBOutlet weak var newUserNameField: UITextField!
    @IBOutlet weak var statusLabel: UILabel!
    //grab these from the previous view controller
    var emailField = ""
    var image = UIImage()
    var delegate : UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statusLabel.isHidden = true
        // Do any additional setup after loading the view.
    }
    @IBAction func nameDoneButtonPressed(_ sender: Any) {
        //push to database with the new username
        DataManager.app.UploadUserData(email: "\(self.emailField)", orgAvatar: self.image, orgDescription: "Basic User", type: "userData", userName: newUserNameField.text!)
        statusLabel.isHidden = false
        //refresh the table and inform the username has changed
        let otherVC = delegate as! TableRefresher
        otherVC.updateTable()
    }

}
