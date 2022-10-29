//
//  SettingBottomTableViewCell.swift
//  Gro-test
//
//  Created by Luo, Shu Tong on 10/28/22.
//  Copyright © 2022 Shu Tong Luo. All rights reserved.
//

import UIKit

class SettingBottomTableViewCell: UITableViewCell {

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var logOutBtn: UIButton!
    @IBOutlet weak var notifSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
