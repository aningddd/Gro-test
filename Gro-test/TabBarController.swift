//
//  TabBarController.swift
//  Gro-test
//
//  Created by aning on 15/10/22.
//  Copyright © 2022 Shu Tong Luo. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set bar colour
        tabBar.barTintColor = UIColor(named: "Burnt Orange")
        // Set item colour
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = UIColor(named: "Grey 1")
        // Remove registration navigation bar
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // Readd registration navigation bar
        navigationController?.setNavigationBarHidden(false, animated: false)

    }
    
}
