//
//  OrgLogisticsViewController.swift
//  Gro-test
//
//  Created by Christopher Chen on 12/5/22.
//  Copyright © 2022 Shu Tong Luo. All rights reserved.
//

import UIKit

class OrgLogisticsViewController: UIViewController {
    
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var subscribersLabel: UILabel!
    @IBOutlet weak var eventsLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        topView.layer.cornerRadius = 15
        bottomView.layer.cornerRadius = 15
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Retrieve org data
        DispatchQueue.global(qos: .userInteractive).async {
            DataManager.app.retrieveSubScriptionAmount(orgEmail: myEmail) {
                result in
                DispatchQueue.main.async {
                    self.subscribersLabel.text = String(result)
                }
            }
            DataManager.app.retrieveEventData(OrgName: myUserName) {
                result in
                DispatchQueue.main.async {
                    self.eventsLabel.text = String(result.count)
                }
            }
        }
    }
}
