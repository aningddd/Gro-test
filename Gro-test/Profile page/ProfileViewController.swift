//
//  ProfileViewController.swift
//  Gro-test
//
//  Created by aning on 18/10/22.
//  Copyright © 2022 Shu Tong Luo. All rights reserved.
//

import UIKit

public var myUserName: String = ""
public var myEmail: String = ""

class ProfileViewController: UIViewController {

    @IBOutlet weak var userCardView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var switchAccountButton: UIButton!
    @IBOutlet weak var changeProfilePictureButton: UIButton!
    
    var userEmail = ""
    let profileToSettingsSegue = "profileToSettingsSegue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set layout of user information
        userCardView.layer.cornerRadius = 10
        settingsButton.layer.cornerRadius = 5
        switchAccountButton.layer.cornerRadius = 5
        profileImage.layer.cornerRadius = 85
    }
    //display the user info 
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.global(qos: .userInteractive).async {
            DataManager.app.retrieveUserData(email: self.userEmail){
                result in
                DispatchQueue.main.async {
                    var user = result[0] as! UserData
                    self.profileImage.image = user.avatar
                    self.userNameLabel.text = user.userName
                    self.userEmailLabel.text = user.email
                    myUserName = user.userName
                    myEmail = user.email
                }
                
            }
        }
    }

    //create the alert controller to allow for editing the profile picture
    @IBAction func pressedProfilePictureButton(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        
        let controller = UIAlertController(
            title: "Photo Source",
            message: "Choose a source",
            preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel,
                                         handler: {
            (action) in print("Cancel action")
        })
        controller.addAction(cancelAction)
        //photo library option
        let photoLibraryOption = UIAlertAction(title: "Choose from photo library",
                                     style: .default,
                                     handler: {
            (action) in
            vc.sourceType = .photoLibrary
            self.present(vc, animated: true)
        })
        controller.addAction(photoLibraryOption)
        //camera option
        let cameraAction = UIAlertAction(title: "Take photo with camera",
                                     style: .default,
                                     handler: {
            (action) in
            if(UIImagePickerController.isSourceTypeAvailable(.camera )){
                vc.sourceType = .camera
                self.present(vc, animated: true)
            }
            else{
                //in case the camera is not available (on simulators!)
                let cameraAlertController = UIAlertController(
                    title: "Camera not available",
                    message: "Unable to locate camera for this device",
                    preferredStyle: .alert)
                cameraAlertController.addAction(UIAlertAction(title: "OK",
                                                   style: .default))
                self.present(cameraAlertController, animated: true)
            }
            
        })
        controller.addAction(cameraAction)
        
        present(controller,animated:true)
    }
    //send back to the login screen
    @IBAction func switchAccount(_ sender: Any) { self.navigationController?.navigationController?.popToRootViewController(animated: true)
    }
    //sending the user email to the settings page to allow retrieving the user info
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == self.profileToSettingsSegue, let settingsVC = segue.destination as? SettingsViewController{
            settingsVC.userEmail = self.userEmail
        }
    }
    
}
//class to allow for uploading profile picture via camera or photo library
extension ProfileViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //get the image and set it as the profile pic
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage{
            profileImage.image = image
            //make sure to update the profile photo in the backend as well
            DataManager.app.UploadUserData(email: "\(self.userEmailLabel.text!)", orgAvatar: image, orgDescription: "Basic User", type: "userData", userName: "\(self.userNameLabel.text!)")
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
