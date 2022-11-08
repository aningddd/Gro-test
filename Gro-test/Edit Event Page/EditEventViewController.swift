//
//  EditEventViewController.swift
//  Gro-test
//
//  Created by Long Do on 10/31/22.
//  Copyright © 2022 Shu Tong Luo. All rights reserved.
//

import UIKit

class EditEventViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var imageBlock: UIView!
    @IBOutlet weak var descrBlock: UIView!
    @IBOutlet weak var detailBlock: UIView!
    @IBOutlet weak var descrTextField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topView.layer.cornerRadius = 10
        imageBlock.layer.cornerRadius = 10
        descrBlock.layer.cornerRadius = 10
        detailBlock.layer.cornerRadius = 10
        descrTextField.layer.cornerRadius = 5
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
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
