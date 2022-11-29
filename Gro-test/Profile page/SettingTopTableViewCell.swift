//
//  SettingTopTableViewCell.swift
//  Gro-test
//
//  Created by Luo, Shu Tong on 10/28/22.
//  Copyright © 2022 Shu Tong Luo. All rights reserved.
//

import UIKit

class SettingTopTableViewCell: UITableViewCell {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var pencilBtn: UIButton!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var view: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        pencilBtn.setImage(UIImage(systemName: "pencil"), for: .normal)
        pencilBtn.setTitle("", for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    
    

}
