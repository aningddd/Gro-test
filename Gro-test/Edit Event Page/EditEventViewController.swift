//
//  EditEventViewController.swift
//  Gro-test
//
//  Created by Long Do on 10/31/22.
//  Copyright © 2022 Shu Tong Luo. All rights reserved.
//

import UIKit

class EditEventViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var imageBlock: UIView!
    @IBOutlet weak var descrBlock: UIView!
    @IBOutlet weak var detailBlock: UIView!
    @IBOutlet weak var descrTextField: UITextView!
    
    @IBOutlet weak var topMessageTextField: UITextField!
    @IBOutlet weak var eventNameTextField: UITextField!
    @IBOutlet weak var headingTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var contactEmailTextField: UITextField!
    @IBOutlet weak var contactPhoneTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topView.layer.cornerRadius = 10
        imageBlock.layer.cornerRadius = 10
        descrBlock.layer.cornerRadius = 10
        detailBlock.layer.cornerRadius = 10
        descrTextField.layer.cornerRadius = 5

        descrTextField.delegate = self
        topMessageTextField.delegate = self
        eventNameTextField.delegate = self
        headingTextField.delegate = self
        timeTextField.delegate = self
        dateTextField.delegate = self
        addressTextField.delegate = self
        contactEmailTextField.delegate = self
        contactPhoneTextField.delegate = self
        
    }

    @IBAction func uploadButtonPressed(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
}

extension EditEventViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            imageView.image = image
        }
        picker.dismiss(animated: true)
            
    }
    
    func textFieldShouldReturn(_ textField:UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
