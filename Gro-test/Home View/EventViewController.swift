//
//  EventViewController.swift
//  Gro-test
//
//  Created by aning on 17/10/22.
//  Copyright © 2022 Shu Tong Luo. All rights reserved.
//

import UIKit

class EventViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var eventTableView: UITableView!
    var events:[EventData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventTableView.delegate = self
        eventTableView.dataSource = self
        eventTableView.rowHeight = 135
        eventTableView.backgroundColor = UIColor(named: "Grey E")
        getData()
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return 10
        return self.events.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = eventTableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as! EventTableViewCell
        
        cell.contentView.backgroundColor = UIColor(named: "Grey E")
        cell.view.layer.cornerRadius = 10
        cell.eventName.text = self.events[indexPath.row].eventName
        
        return cell
    }
    
    func getData() {
        DispatchQueue.global(qos: .userInteractive).async {
            DataManager.app.retrieveEventData(OrgName: "Gro") {
                result in
                for each in result {
                    self.events.append(each as! EventData)
                    print(each.image)
                }
                
                DispatchQueue.main.async {
                    print(self.events.count)
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
            nextVC.event = self.events[index]
        }

    }
}
