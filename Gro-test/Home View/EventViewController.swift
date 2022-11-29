//
//  EventViewController.swift
//  Gro-test
//
//  Created by aning on 17/10/22.
//  Copyright © 2022 Shu Tong Luo. All rights reserved.
//

import UIKit

public var events:[EventData] = []
public var selectedEventIndex:Int?

class EventViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var eventTableView: UITableView!
    
    var org:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventTableView.delegate = self
        eventTableView.dataSource = self
        eventTableView.rowHeight = 135
        eventTableView.backgroundColor = UIColor(named: "Grey E")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        org = selectedOrg!
        events = []
        getData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = eventTableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as! EventTableViewCell
        
        cell.contentView.backgroundColor = UIColor(named: "Grey E")
        cell.view.layer.cornerRadius = 10
        cell.eventName.text = events[indexPath.row].eventName
        cell.timeLabel.text = events[indexPath.row].time
        cell.dateLabel.text = events[indexPath.row].month + " " + events[indexPath.row].date + " " + events[indexPath.row].year
        cell.infoButton.tag = indexPath.row
        cell.infoButton.addTarget(self, action: #selector(infoButtonPressed), for: .touchUpInside)
        cell.infoArrow.tag = indexPath.row
        cell.infoArrow.addTarget(self, action: #selector(infoButtonPressed), for: .touchUpInside)
        
        return cell
    }
    
    @objc func infoButtonPressed(sender: UIButton) {
        let index = IndexPath(row: sender.tag, section: 0)
        selectedEventIndex = index.row
//        print("==========")
//        print(events[selectedEventIndex!])
//        print("==========")
    }
    
    func getData() {
        DispatchQueue.global(qos: .userInteractive).async {
            DataManager.app.retrieveEventData(OrgName: self.org!) {
                result in
                for each in result {
                    events.append(each as! EventData)
                    print(each.image)
                }
                
                DispatchQueue.main.async {
                    self.eventTableView.reloadData()
                }
            }
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToSingleEventViewControllerSegue1" || segue.identifier == "ToSingleEventViewControllerSegue2",
        let nextVC = segue.destination as? SingleEventViewController,
        let index = eventTableView.indexPathForSelectedRow?.row {
            nextVC.delegate = self
            nextVC.event = events[index]
        }
        
        if segue.identifier == "showOrgDetailToUser1" || segue.identifier == "showOrgDetailToUser2", let targetOrg = segue.destination as? OrganizationPageViewController{
            DataManager.app.retrieveUserEmail(userName: org as! String, type: "orgData"){
                result in
                targetOrg.userEmail = result.email
            }
        }

    }
}
