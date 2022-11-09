//
//  ProfileViewController.swift
//  Gro-test
//
//  Created by aning on 18/10/22.
//  Copyright © 2022 Shu Tong Luo. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var userCardView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var switchAccountButton: UIButton!
    @IBOutlet weak var changeProfilePictureButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set layout of user information
        userCardView.layer.cornerRadius = 10
        settingsButton.layer.cornerRadius = 5
        switchAccountButton.layer.cornerRadius = 5
        profileImage.layer.cornerRadius = 85
    }
    
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
    
        let OKAction = UIAlertAction(title: "Choose from photo library",
                                     style: .default,
                                     handler: {
            (action) in
            vc.sourceType = .photoLibrary
            self.present(vc, animated: true)
        })
        controller.addAction(OKAction)
        
        let cameraAction = UIAlertAction(title: "Take photo with camera",
                                     style: .default,
                                     handler: {
            (action) in
            if(UIImagePickerController.isSourceTypeAvailable(.camera )){
                vc.sourceType = .camera
                self.present(vc, animated: true)
            }
            else{
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
    @IBAction func switchAccount(_ sender: Any) { self.navigationController?.navigationController?.popToRootViewController(animated: true)
    }
    
}

extension ProfileViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage{
            profileImage.image = image
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
