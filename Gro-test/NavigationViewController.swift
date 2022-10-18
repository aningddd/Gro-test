//
//  NavigationViewController.swift
//  Gro-test
//
//  Created by aning on 15/10/22.
//  Copyright © 2022 Shu Tong Luo. All rights reserved.
//

import UIKit

class NavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.barTintColor = UIColor(named: "Burnt Orange")
        navigationBar.isTranslucent = false
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }

}
