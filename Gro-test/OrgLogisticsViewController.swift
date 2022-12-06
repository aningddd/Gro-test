//
//  OrgLogisticsViewController.swift
//  Gro-test
//
//  Created by Christopher Chen on 12/5/22.
//  Copyright © 2022 Shu Tong Luo. All rights reserved.
//

import UIKit

class OrgLogisticsViewController: UIViewController {
    
    var subscriberCount: Int = 0
    var eventsCount: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func viewWillAppear(_ animated: Bool) {
        // Retrieve org data
//        DispatchQueue.global(qos: .userInteractive).async {
//            DataManager.app.retrieveUserData(email: self.userEmail){
//                result in
//                DispatchQueue.main.async {
//
//                }
//
//            }
//        }
    }
}
