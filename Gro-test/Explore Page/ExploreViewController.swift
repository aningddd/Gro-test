//
//  ExploreViewController.swift
//  Gro-test
//
//  Created by aning on 17/10/22.
//  Copyright © 2022 Shu Tong Luo. All rights reserved.
//

import UIKit

let categories = ["Academic", "Greek Life", "Volunteering", "Sports", "Culture"]

class ResultsVC : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
    }
}

class ExploreViewController: UIViewController, UISearchResultsUpdating {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var plusButton: UIButton!
    
    let searchController = UISearchController(searchResultsController: ResultsVC())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.layer.cornerRadius = 5
        categoryView.layer.cornerRadius = 5
        plusButton.setImage(UIImage(systemName:"plus")?.withRenderingMode(.alwaysTemplate), for: .normal)
        plusButton.tintColor = .black
        searchController.searchResultsUpdater = self
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else{
            return
        }
        let vc = searchController.searchResultsController as? ResultsVC
        vc?.view.backgroundColor = .yellow
        print(text)
    }
    
}
