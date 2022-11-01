//
//  EventCell.swift
//  Gro-test
//
//  Created by Long Do on 10/30/22.
//  Copyright © 2022 Shu Tong Luo. All rights reserved.
//

import UIKit

class EventCell: UITableViewCell {

    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var orgNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func infoButtonPressed(_ sender: Any) {
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
    }
}
