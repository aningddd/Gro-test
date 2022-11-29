//
//  RegisterPageVC.swift
//  Gro-test
//
//  Created by Bowen一一＂一 yang一一 on 10/18/22.
//  Copyright © 2022 Shu Tong Luo. All rights reserved.
//

import UIKit
import FirebaseAuth


class RegisterPageVC: UIViewController, UITextFieldDelegate {
    
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
    let loginSegueIdentifier = "registerToMainSegue"
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        passwordField.isSecureTextEntry = true
        confirmPasswordField.isSecureTextEntry = true
        errorMessage.isHidden = true
        registerPageTitleLabel.font = UIFont(name:"ArialRoundedMTBold",size:30.0)
        emailTextField.delegate = self
        passwordField.delegate = self
        confirmPasswordField.delegate = self
        firstNameField.delegate = self
        lastNameField.delegate = self
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
                    //creating user info in the firebase database NOT for authentication
                    let defaultImage = UIImage(named: "Image")
                    DataManager.app.UploadUserData(email: "\(self.emailTextField.text!)", orgAvatar: defaultImage!, orgDescription: "Basic User", type: "userData", userName: "\(self.firstNameField.text!)  \(self.lastNameField.text!)")
                    //segue into regular org page immediately after registering
                    Auth.auth().addStateDidChangeListener(){
                        auth, user in
                        print(user!)
                        if user != nil{
                            self.performSegue(withIdentifier: self.loginSegueIdentifier, sender: nil)
                            self.emailTextField.text = nil
                            self.passwordField.text = nil
                            self.confirmPasswordField.text = nil
                            self.firstNameField.text = nil
                            self.lastNameField.text = nil
                        }
                    }
                }
            }
        }
        else{
            self.errorMessage.isHidden = false
            self.errorMessage.text = "Error: passwords do not match"
        }
    }
    
    func textFieldShouldReturn(_ textField:UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Called when the user clicks on the view outside of the UITextField

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == self.loginSegueIdentifier, let tabBarNavigation = segue.destination as? TabBarController{
            let profileVCNavigation = tabBarNavigation.viewControllers![3] as! UINavigationController
            let profileVC = profileVCNavigation.topViewController as! ProfileViewController
            profileVC.userEmail = self.emailTextField.text!
        }
    }
}
