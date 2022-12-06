//
//  LoginVC.swift
//  Gro-test
//
//  Created by Bowen一一＂一 yang一一 on 10/18/22.
//  Copyright © 2022 Shu Tong Luo. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginVC: UIViewController, UITextFieldDelegate, UITabBarControllerDelegate {

    @IBOutlet weak var LoginTitleLabel: UILabel!
    @IBOutlet weak var emailField: UnderlineTextField!
    @IBOutlet weak var passwordField: UnderlineTextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorMessage: UILabel!
    let loginSegue = "loginSegueIdentifier"
    let adminSegue = "adminLoginSegue"
    
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
                    if user != nil{
                        //determine if this is a basic user or an organziation admin
                        DataManager.app.retrieveUserData(email: self.emailField.text!){
                            result in
                            var user = result[0] as! UserData
                            if(user.type == "userData"){
                                self.performSegue(withIdentifier: self.loginSegue, sender: nil)
                            }
                            else{
                                self.performSegue(withIdentifier: self.adminSegue, sender: nil)
                            }
                            self.emailField.text = nil
                            self.passwordField.text = nil
                            
                        }
                        
                    }
                }
            }
        }
        
    }
    
    // Called when the user clicks on the view outside of the UITextField
    func textFieldShouldReturn(_ textField:UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == self.loginSegue, let tabBarNavigation = segue.destination as? TabBarController{
            let profileVCNavigation = tabBarNavigation.viewControllers![3] as! UINavigationController
            let profileVC = profileVCNavigation.topViewController as! ProfileViewController
            profileVC.userEmail = self.emailField.text!
            key = self.emailField.text!
        }
        else if segue.identifier == self.adminSegue, let tabBarNavigation = segue.destination as? TabBarController{
            let profileVCNavigation = tabBarNavigation.viewControllers![2] as! UINavigationController
            let orgDesNavigation = tabBarNavigation.viewControllers![0] as! UINavigationController
            let profileVC = profileVCNavigation.topViewController as! ProfileViewController
            let orgDesVC = orgDesNavigation.topViewController as! OrganizationPageViewController
            profileVC.userEmail = self.emailField.text!
            orgDesVC.userEmail = self.emailField.text!
        }
    }
    
}
