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
        
        // Make all blocks rounded
        RSVPButton.layer.cornerRadius = 5
        contactButton.layer.cornerRadius = 5
        sloganView.layer.cornerRadius = 10
        imageView.layer.cornerRadius = 10
        descriptionView.layer.cornerRadius = 10
        infoView.layer.cornerRadius = 10
        eventMap.layer.cornerRadius = 10
    }

}
