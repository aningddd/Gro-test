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
    var emailField = ""
    var image = UIImage()
    var delegate : UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statusLabel.isHidden = true
        // Do any additional setup after loading the view.
    }
    @IBAction func nameDoneButtonPressed(_ sender: Any) {
        DataManager.app.UploadUserData(email: "\(self.emailField)", orgAvatar: self.image, orgDescription: "Basic User", type: "userData", userName: newUserNameField.text!)
        statusLabel.isHidden = false
        let otherVC = delegate as! TableRefresher
        otherVC.updateTable()
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
