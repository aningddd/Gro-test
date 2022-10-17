//
//  OrgTableViewCell.swift
//  Gro-test
//
//  Created by aning on 17/10/22.
//  Copyright © 2022 Shu Tong Luo. All rights reserved.
//

import UIKit

class OrgTableViewCell: UITableViewCell {

    @IBOutlet weak var orgNameLabel: UILabel!
    @IBOutlet weak var orgInfoButton: UIButton!
    @IBOutlet weak var orgLogo: UIImageView!
    @IBOutlet weak var recentEventLabel: UILabel!
    @IBOutlet weak var toEventsButton: UIButton!
    @IBOutlet weak var view: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
