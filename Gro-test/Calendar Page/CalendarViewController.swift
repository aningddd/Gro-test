//
//  CalendarViewController.swift
//  Gro-test
//
//  Created by Long Do on 10/30/22.
//  Copyright © 2022 Shu Tong Luo. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var monthLabel: UILabel!

    @IBOutlet weak var tableView: UITableView!
    var allEvents:[EventData] = []
    
    var events:[Event] = [Event(eventName: "Pinic Social", orgName: "Foodie Fridge Club", time: "12:00 pm | Nov 9 2022"),Event(eventName: "General Meeting #1", orgName: "Competitive Computing Club", time: "6:00 pm | Nov 8 2022"), Event(eventName: "General Meeting #2", orgName: "Competitive Computing Club", time: "6:00 pm | Nov 9 2022")]
    var totalSquares = [Date]()
    var selectedDate = Date()
    var currentDate = Date()
    let dateFormatter = DateFormatter()
    var selectedDateEvents:[EventData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
        tableView.dataSource = self
        tableView.delegate = self
        setCellsView()
        setWeekView()
    }
    
    func setCellsView() {
        let width = (collectionView.frame.size.width - 2) / 8
        let height = width
        
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.itemSize = CGSize(width: width, height: height)
    }
    
    func setWeekView() {
        totalSquares.removeAll()
                
        var current = CalendarHelper().sundayForDate(date: selectedDate)
        let nextSunday = CalendarHelper().addDays(date: current, days: 7)
        
        while (current < nextSunday)
        {
            totalSquares.append(current)
            current = CalendarHelper().addDays(date: current, days: 1)
        }
        
        monthLabel.text = CalendarHelper().monthString(date: selectedDate)
            + " " + CalendarHelper().yearString(date: selectedDate)
        collectionView.reloadData()
        tableView.reloadData()
    }
    
    @IBAction func previousButtonPressed(_ sender: Any) {
        selectedDate = CalendarHelper().addDays(date: selectedDate, days: -7)
        setWeekView()
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        selectedDate = CalendarHelper().addDays(date: selectedDate, days: 7)
        setWeekView()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        totalSquares.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calCell", for: indexPath) as! CalendarCollectionViewCell
                
        let date = totalSquares[indexPath.item]
        cell.dayOfMonthLabel.text = String(CalendarHelper().dayOfMonth(date: date))
        
        if(currentDate == date) {
            cell.dayOfMonthLabel.backgroundColor = UIColor.red
            cell.dayOfMonthLabel.layer.masksToBounds = true
            cell.dayOfMonthLabel.layer.cornerRadius = cell.dayOfMonthLabel.frame.height / 2
            cell.dayOfMonthLabel.layer.borderWidth = 1
            cell.dayOfMonthLabel.layer.borderColor = UIColor.red.cgColor
            cell.markingLabel.text = ""
        }
        else {
            if(date == selectedDate)
            {
                // cell.dayOfMonthLabel.backgroundColor = UIColor.systemGreen
                cell.dayOfMonthLabel.backgroundColor = UIColor.white
                cell.dayOfMonthLabel.layer.masksToBounds = true
                cell.dayOfMonthLabel.layer.cornerRadius = cell.dayOfMonthLabel.frame.height / 2
                cell.dayOfMonthLabel.layer.borderWidth = 1
                cell.dayOfMonthLabel.layer.borderColor = UIColor.red.cgColor
                cell.markingLabel.text = ""
            }
            else
            {
                // cell.backgroundColor = UIColor.white
                cell.dayOfMonthLabel.backgroundColor = UIColor.white
                cell.dayOfMonthLabel.layer.borderWidth = 1
                cell.dayOfMonthLabel.layer.borderColor = UIColor.white.cgColor
                cell.markingLabel.text = ""
            }
        }
        
        selectedDateEvents = []
        
        dateFormatter.dateFormat = "MMM d YYYY"
        var temp1:String = dateFormatter.string(from: selectedDate)
        var temp2:String = dateFormatter.string(from: date)
        
        for event in allEvents {
            if #available(iOS 16.0, *) {
                var date = event.month + " " + event.date + " " + event.year

                if(date == temp1) {
                    selectedDateEvents.append(event)
                }

                if(date == temp2) {
                    cell.markingLabel.text = "*"
                }
            }
        }
        
//        for event in events {
//            if #available(iOS 16.0, *) {
//                var arr = event.getTime().split(separator: " | ")
//
//                if(arr[1] == temp1) {
//                    selectedDateEvents.append(event)
//                }
//
//                if(arr[1] == temp2) {
//                    cell.markingLabel.text = "*"
//                }
//            }
//        }
        
        tableView.reloadData()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedDate = totalSquares[indexPath.item]
        collectionView.reloadData()
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedDateEvents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell") as! EventCell
        let event = selectedDateEvents[indexPath.row]
        cell.eventNameLabel.text = event.eventName
        cell.orgNameLabel.text = event.orgName
        cell.timeLabel.text = event.time + " | " + event.month + " " + event.date + " " + event.year
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.allEvents = []
        DispatchQueue.global(qos: .userInteractive).async {
            for org in allOrgs {
                DataManager.app.retrieveEventData(OrgName: org) {
                    result in
                    
                    for each in result {
                        self.allEvents.append(each as! EventData)
                    }
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.collectionView.reloadData()
                    }
                }
            }
        }
//        allOrgs = []
//        DispatchQueue.global(qos: .userInteractive).async {
//            DataManager.app.retrieveAllUser(type: "orgData") {
//                result in
//
//                DispatchQueue.main.async {
//                    for org in result {
//                        allOrgs.append(org.userName)
//                    }
//                    self.tableView.reloadData()
//                }
//            }
//        }
    }
}
