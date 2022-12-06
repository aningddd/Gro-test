//
//  forgetPasswordVC.swift
//  Gro-test
//
//  Created by Bowen一一＂一 yang一一 on 10/18/22.
//  Copyright © 2022 Shu Tong Luo. All rights reserved.
//

import UIKit

class forgetPasswordVC: UIViewController, UITextFieldDelegate {
 
    @IBOutlet weak var emailTextField: UnderlineTextField!
    @IBOutlet weak var ForgetPasswordTitleLable: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        ForgetPasswordTitleLable.font = UIFont(name:"ArialRoundedMTBold",size:30.0)
        emailTextField.delegate = self
    }
    
    // Called when the user clicks on the view outside of the UITextField
    func textFieldShouldReturn(_ textField:UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
