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
    @IBOutlet weak var orgInfoTextButton: RecipientButton!
    @IBOutlet weak var orgInfoButton: RecipientButton!
    @IBOutlet weak var orgLogo: UIImageView!
    @IBOutlet weak var recentEventLabel: UILabel!
    @IBOutlet weak var toEventsButton: RecipientButton!
    @IBOutlet weak var view: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.view.layer.cornerRadius = 10
        self.contentView.backgroundColor = UIColor(named: "Grey E")
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
