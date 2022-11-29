//
//  TmpAdmimRegisterVC.swift
//  Gro-test
//
//  Created by Bowen一一＂一 yang一一 on 10/18/22.
//  Copyright © 2022 Shu Tong Luo. All rights reserved.
//

import UIKit
import FirebaseAuth
class TmpAdmimRegisterVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    @IBOutlet weak var organizationName: UITextField!
    @IBOutlet weak var TmpAdminRegisterTitleLabel: UILabel!
    @IBOutlet weak var errorMessage: UILabel!
    
    
    let orgRegisterSegueIdentifier = "orgRegisterSegue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordField.isSecureTextEntry = true
        confirmPasswordField.isSecureTextEntry = true
        errorMessage.isHidden = true
        TmpAdminRegisterTitleLabel.font = UIFont(name:"ArialRoundedMTBold",size:30.0)
        TmpAdminRegisterTitleLabel.text = "Admin Register"
        emailField.delegate = self
        passwordField.delegate = self
        confirmPasswordField.delegate = self
        organizationName.delegate = self
        
    }
    @IBAction func registerButtonPressed(_ sender: Any) {
        if(passwordField.text == confirmPasswordField.text){
            Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!){
                authResult, error in
                self.errorMessage.isHidden = false
                if let error = error as NSError?{
                    self.errorMessage.text = "\(error.localizedDescription)"
                    print("There was an error creating the account \(error.localizedDescription)")
                }
                else{
                    self.errorMessage.text = "Success"
                    print("success creating the organization via authentication")
                    //creating user info in the firebase database NOT for authentication
                    let defaultImage = UIImage(named: "Image")
                    DataManager.app.UploadUserData(email: "\(self.emailField.text!)", orgAvatar: defaultImage!, orgDescription: "A simple organization", type: "orgData", userName: "\(self.organizationName.text!)")
                    print("organizaation successfully created in firestore")
                    
                    //segue into regular org page immediately after registering
                    self.performSegue(withIdentifier: self.orgRegisterSegueIdentifier, sender: nil)
                    self.emailField.text = nil
                    self.passwordField.text = nil
                    self.confirmPasswordField.text = nil
                    self.organizationName.text = nil
                    
//                    Auth.auth().addStateDidChangeListener(){
//                        auth, user in
//                        if user != nil{
//
//                        }
//                    }
                }
            }
        }
        else{
            self.errorMessage.isHidden = false
            self.errorMessage.text = "Error: passwords do not match"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //update the profile view for the new organization
        if segue.identifier == self.orgRegisterSegueIdentifier, let tabBarNavigation = segue.destination as? TabBarController{
            let profileVCNavigation = tabBarNavigation.viewControllers![2] as! UINavigationController
            let orgDesNavigation = tabBarNavigation.viewControllers![0] as! UINavigationController
            let profileVC = profileVCNavigation.topViewController as! ProfileViewController
            let orgDesVC = orgDesNavigation.topViewController as! OrganizationPageViewController
            
            profileVC.userEmail = self.emailField.text!
            orgDesVC.userEmail = self.emailField.text!
        }
    }
    

}
