//
//  CollectionViewCell.swift
//  ImageLinkTest
//
//  Created by Nikita Nesporov on 17.04.2022.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var forImage: UIImageView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layoutIfNeeded()
        forImage.layer.cornerRadius = forImage.frame.height / 4
        forImage.layer.borderWidth = 5
        forImage.layer.borderColor = UIColor.gray.cgColor
    }
}
