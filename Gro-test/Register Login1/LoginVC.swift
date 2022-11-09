//
//  LoginVC.swift
//  Gro-test
//
//  Created by Bowen一一＂一 yang一一 on 10/18/22.
//  Copyright © 2022 Shu Tong Luo. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var LoginTitleLabel: UILabel!
    @IBOutlet weak var emailField: UnderlineTextField!
    @IBOutlet weak var passwordField: UnderlineTextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorMessage: UILabel!
    let loginSegue = "loginSegueIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorMessage.isHidden = true
        passwordField.isSecureTextEntry = true
        navigationController?.setNavigationBarHidden(false, animated: false)
        LoginTitleLabel.font = UIFont(name:"ArialRoundedMTBold",size:30.0)
        emailField.delegate = self
        passwordField.delegate = self
    }
    @IBAction func loginButtonPressed(_ sender: Any) {
        //handling the case to login the user to the app
        print("Got here")
        Auth.auth().signIn(withEmail: emailField.text!, password: passwordField.text!){
            authResult, error in
            self.errorMessage.isHidden = false
            if let error = error as NSError?{
                self.errorMessage.text = "\(error.localizedDescription)"
            }
            else{
                self.errorMessage.text = "Success"
                Auth.auth().addStateDidChangeListener(){
                    auth, user in
                    print(user!)
                    if user != nil{
                        self.performSegue(withIdentifier: self.loginSegue, sender: nil)
                        self.emailField.text = nil
                        self.passwordField.text = nil
                    }
                }
            }
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
    
}
