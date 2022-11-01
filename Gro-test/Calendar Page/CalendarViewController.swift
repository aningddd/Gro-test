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
    
    var events:[Event] = [Event(eventName: "Pinic Social", orgName: "Foodie Fridge Club", time: "12:00 pm | Oct 4 2022"),Event(eventName: "General Meeting #1", orgName: "Competitive Computing Club", time: "6:00 pm | Oct 4 2022")]
    var totalSquares = [Date]()
    var selectedDate = Date()
    var currentDate = Date()
    let dateFormatter = DateFormatter()
    
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
        
//        var format = current.split(separator: " ")[0]
//
//        if(format == dateFormatter.string(from: selectedDate).split(separator: " ")[0]) {
//            cell.dayOfMonthLabel.backgroundColor = UIColor.systemRed
//            cell.dayOfMonthLabel.layer.masksToBounds = true
//            cell.dayOfMonthLabel.layer.cornerRadius = cell.dayOfMonthLabel.frame.height / 2
//        }
                
        if(date == selectedDate)
        {
            cell.dayOfMonthLabel.backgroundColor = UIColor.systemGreen
            cell.dayOfMonthLabel.layer.masksToBounds = true
            cell.dayOfMonthLabel.layer.cornerRadius = cell.dayOfMonthLabel.frame.height / 2
            cell.markingLabel.text = "*"
        }
        else
        {
            // cell.backgroundColor = UIColor.white
            cell.dayOfMonthLabel.backgroundColor = UIColor.white
            cell.markingLabel.text = ""
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedDate = totalSquares[indexPath.item]
        collectionView.reloadData()
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell") as! EventCell
        let event = events[indexPath.row]
        cell.eventNameLabel.text = event.getEventName()
        cell.orgNameLabel.text = event.getOrgName()
        cell.timeLabel.text = event.getTime()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160.0
    }
}
