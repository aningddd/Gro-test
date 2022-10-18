//
//  EventTableViewCell.swift
//  Gro-test
//
//  Created by aning on 17/10/22.
//  Copyright © 2022 Shu Tong Luo. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var RSVPLabel: UILabel!
    @IBOutlet weak var RSVPNumberLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var infoArrow: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
