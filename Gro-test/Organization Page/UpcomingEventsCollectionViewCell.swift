//
//  UpcomingEventsCollectionViewCell.swift
//  Gro-test
//
//  Created by Long Do on 10/18/22.
//  Copyright © 2022 Shu Tong Luo. All rights reserved.
//

import UIKit

class UpcomingEventsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func configure(with image: UIImage) {
        imageView.image = image
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "UpcomingEventsCollectionViewCell", bundle: nil)
    }
}
