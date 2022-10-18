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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userCardView.layer.cornerRadius = 10
        settingsButton.layer.cornerRadius = 5
        switchAccountButton.layer.cornerRadius = 5
        profileImage.layer.cornerRadius = 85
    }
    
}
