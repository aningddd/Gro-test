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
    
    var parentVC : UIViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func notificationSwitchPressed(_ sender: UISwitch) {
        if sender.isOn{
            //request for notification authorization
            UNUserNotificationCenter.current().requestAuthorization(
                options: [.alert, .badge, .sound],
                completionHandler: {
                    granted, error in
                    if granted{
                        print("All set!")
                    }
                    else if let error = error{
                        print(error.localizedDescription)
                    }
                }
            )
            let controller = UIAlertController(
                title: "Confirmed!",
                message: "Notifications are now turned on",
                preferredStyle: .alert)
            controller.addAction(UIAlertAction(title: "OK",
                                               style: .default))
            self.parentVC.present(controller, animated: true)
        }
        else{
            let controller = UIAlertController(
                title: "Confirmed!",
                message: "Notifications are now turned off",
                preferredStyle: .alert)
            controller.addAction(UIAlertAction(title: "OK",
                                               style: .default))
            self.parentVC.present(controller, animated: true)
        }
        
    }

}
