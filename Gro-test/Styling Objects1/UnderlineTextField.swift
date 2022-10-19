//
//  UnderlineTextField.swift
//  Gro-test
//
//  Created by Bowen一一＂一 yang一一 on 10/18/22.
//  Copyright © 2022 Shu Tong Luo. All rights reserved.
//

import UIKit
@IBDesignable
class UnderlineTextField: UITextField {
    required init?(coder aDecorder: NSCoder) {
        super.init(coder: aDecorder)
            setUnderLine()
        }
    
    func setUnderLine(){
        var bottomLine = CALayer()
        bottomLine.frame = CGRect(x:0, y:self.frame.height - 2, width: self.frame.width, height: 2)
        bottomLine.backgroundColor = UIColor.black.cgColor
        self.borderStyle = UITextField.BorderStyle.none
        self.layer.addSublayer(bottomLine)
    }
}
