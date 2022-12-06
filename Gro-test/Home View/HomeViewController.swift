//
//  HomeViewController.swift
//  Gro-test
//
//  Created by aning on 15/10/22.
//  Copyright © 2022 Shu Tong Luo. All rights reserved.
//

import UIKit

public var key:String?
public var allOrgs:[String] = []
public var myOrgs:[String] = []
public var selectedOrg:String?

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 135
        tableView.backgroundColor = UIColor(named: "Grey E")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.global(qos: .userInteractive).async {
            DataManager.app.retrieveAllUser(type: "orgData") {
                result in
                
                DispatchQueue.main.async {
                    for org in result {
                        if (!allOrgs.contains(org.userName)) {
                            allOrgs.append(org.userName)
                        }
                    }
                    self.tableView.reloadData()
                }
            }
        }
        
        DispatchQueue.global(qos: .userInteractive).async {
            DataManager.app.retrieveSubScribed(userEmail: myEmail) {
                result in
                
                DispatchQueue.main.async {
                    for org in result {
                        if (!myOrgs.contains(org.userName)) {
                            myOrgs.append(org.userName)
                        }
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func generateFakeData() {
        DataManager.app.UploadUserData(email: "texashacs.corporate@gmail.com", orgAvatar: UIImage(named: "Image")!, orgDescription: "We're the Hispanic Association of Computer Scientists.", type: "orgData", userName: "HACS")
         DataManager.app.UploadUserData(email: "pres@texasacm.org", orgAvatar: UIImage(named: "Image")!, orgDescription: "Our vision is to become the premier UTCS org by offering a welcoming community for success by offering transformative social, academic, and professional experiences.", type: "orgData", userName: "ACM")
        DataManager.app.UploadEvent(orgName: "ACM", eventDescription: "Join ACM for an Arts and Crafts Night on the fifth floor atrium bridge!", eventPicture: UIImage(named: "Image")!, position_x: 0.01, position_y: 0.01, eventName: "Arts and Craft Night", eventYear: "2022", eventMonth: "Nov", eventDate: "30", eventTime: "6:00 pm", eventLocationName: "2317 Speedway, Austin, TX 78712")
        DataManager.app.UploadEvent(orgName: "HACS", eventDescription: "General Meeting", eventPicture: UIImage(named: "Image")!, position_x: 0.01, position_y: 0.01, eventName: "General Meeting", eventYear: "2022", eventMonth: "Nov", eventDate: "29", eventTime: "6:00 pm", eventLocationName: "2317 Speedway, Austin, TX 78712")
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myOrgs.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrgCell", for: indexPath) as! OrgTableViewCell
        
        cell.contentView.backgroundColor = UIColor(named: "Grey E")
        cell.view.layer.cornerRadius = 10
        cell.orgNameLabel.text = myOrgs[indexPath.row]
        cell.toEventsButton.tag = indexPath.row
        cell.toEventsButton.addTarget(self, action: #selector(eventButtonPressed), for: .touchUpInside)
        cell.orgInfoButton.tag = indexPath.row
        cell.orgInfoButton.addTarget(self, action: #selector(eventButtonPressed), for: .touchUpInside)
        cell.orgInfoTextButton.tag = indexPath.row
        cell.orgInfoTextButton.addTarget(self, action: #selector(eventButtonPressed), for: .touchUpInside)
        
        return cell
    }
    
    @objc func eventButtonPressed(sender: UIButton) {
        let index = IndexPath(row: sender.tag, section: 0)
        selectedOrg = myOrgs[index.row]
    }

}
