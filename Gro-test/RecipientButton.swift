//
//  RecipientButton.swift
//  Gro-test
//
//  Created by Christopher Chen on 12/5/22.
//  Copyright © 2022 Shu Tong Luo. All rights reserved.
//

import Foundation
import UIKit

class RecipientButton: UIButton {
    
    var recipientEmail: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
}
