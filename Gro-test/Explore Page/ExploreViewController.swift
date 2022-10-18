//
//  ExploreViewController.swift
//  Gro-test
//
//  Created by aning on 17/10/22.
//  Copyright © 2022 Shu Tong Luo. All rights reserved.
//

import UIKit

let categories = ["Academic", "Greek Life", "Volunteering", "Sports", "Culture"]

class ExploreViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.layer.cornerRadius = 5
        
        
        // Do any additional setup after loading the view.
    }
    

}
