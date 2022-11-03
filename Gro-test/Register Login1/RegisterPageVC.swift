//
//  RegisterPageVC.swift
//  Gro-test
//
//  Created by Bowen一一＂一 yang一一 on 10/18/22.
//  Copyright © 2022 Shu Tong Luo. All rights reserved.
//

import UIKit
import FirebaseAuth


class RegisterPageVC: UIViewController {
    
    @IBOutlet weak var registerPageTitleLabel: UILabel!
    
    @IBOutlet weak var emailAddressLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var confirmPasswordLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordField.isSecureTextEntry = true
        confirmPasswordField.isSecureTextEntry = true
        errorMessage.isHidden = true
        registerPageTitleLabel.font = UIFont(name:"ArialRoundedMTBold",size:30.0)
    }
    //create the new account with the user login credentials
    @IBAction func createAccountButtonPressed(_ sender: Any) {
        if(passwordField.text == confirmPasswordField.text){
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordField.text!){
                authResult, error in
                self.errorMessage.isHidden = false
                if let error = error as NSError?{
                    self.errorMessage.text = "\(error.localizedDescription)"
                }
                else{
                    self.errorMessage.text = "Success"
                }
            }
        }
        else{
            self.errorMessage.isHidden = false
            self.errorMessage.text = "Error: passwords do not match"
        }
    }
    
}
