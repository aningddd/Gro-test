//
//  SingleEventViewController.swift
//  Gro-test
//
//  Created by aning on 17/10/22.
//  Copyright © 2022 Shu Tong Luo. All rights reserved.
//

import UIKit
import MapKit

class SingleEventViewController: UIViewController {
    
    var event:EventData?
    var delegate: UIViewController!

    // Event information
    @IBOutlet weak var topSloganLabel: UILabel!
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var eventTextView: UITextView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var RSVPButton: UIButton!
    @IBOutlet weak var contactButton: UIButton!
    @IBOutlet weak var eventMap: MKMapView!
    
    // View set up
    @IBOutlet weak var sloganView: UIView!
    @IBOutlet weak var imageView: UIView!
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var infoView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayMap()
        // Make all blocks rounded
        RSVPButton.layer.cornerRadius = 5
        contactButton.layer.cornerRadius = 5
        sloganView.layer.cornerRadius = 10
        imageView.layer.cornerRadius = 10
        descriptionView.layer.cornerRadius = 10
        infoView.layer.cornerRadius = 10
        eventMap.layer.cornerRadius = 10
        self.title = events[selectedEventIndex!].orgName
        topSloganLabel.text = events[selectedEventIndex!].eventName
        //headingLabel.text = events[selectedEventIndex!].eventName
        print(events[selectedEventIndex!].image)
        eventImage.image = events[selectedEventIndex!].image
        eventTextView.text = events[selectedEventIndex!].description
        timeLabel.text = "Time: \(events[selectedEventIndex!].time)"
        dateLabel.text = "Date: \(events[selectedEventIndex!].month) \(events[selectedEventIndex!].date), \(events[selectedEventIndex!].year)"
        locationLabel.text = "Location: \(events[selectedEventIndex!].eventLocation)"
        locationLabel.sizeToFit()
        RSVPButton.layer.borderWidth = 1
        RSVPButton.layer.borderColor = UIColor.black.cgColor
        contactButton.layer.borderWidth = 1
        contactButton.layer.borderColor = UIColor.black.cgColor
        
    }
    
    func displayMap(){
        //GDC location - be sure to change this later to the actual location string
        getCoordinate(addressString: events[selectedEventIndex!].eventLocation, completionHandler: { location, error in
                    if error == nil{
                        let span = MKCoordinateSpan(latitudeDelta: Double(events[selectedEventIndex!].position_x), longitudeDelta: Double(events[selectedEventIndex!].position_y))
                        let coordinates = MKCoordinateRegion(center: location, span: span)
                        self.eventMap.setRegion(coordinates, animated: true)
                        let pin = MKPointAnnotation()
                        pin.coordinate = location
                        self.eventMap.addAnnotation(pin)
                    }
                    else{
                        print(error!.localizedDescription)
                    }
        
                })
        
//        let testAddress: String = "2317 Speedway, Austin, TX 78712"
//        getCoordinate(addressString: testAddress, completionHandler: { location, error in
//            if error == nil{
//                let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
//                let coordinates = MKCoordinateRegion(center: location, span: span)
//                self.eventMap.setRegion(coordinates, animated: true)
//                let pin = MKPointAnnotation()
//                pin.coordinate = location
//                self.eventMap.addAnnotation(pin)
//            }
//            else{
//                print(error!.localizedDescription)
//            }
//
//        })
    }
    
    func getCoordinate( addressString : String,
            completionHandler: @escaping(CLLocationCoordinate2D, NSError?) -> Void ) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(addressString) { (placemarks, error) in
            if error == nil {
                if let placemark = placemarks?[0] {
                    let location = placemark.location!
                        
                    completionHandler(location.coordinate, nil)
                    return
                }
            }
                
            completionHandler(kCLLocationCoordinate2DInvalid, error as NSError?)
        }
    }

}
