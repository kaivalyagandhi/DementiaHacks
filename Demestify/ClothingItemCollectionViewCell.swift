//
//  ClothingItemCollectionViewCell.swift
//  Demestify
//
//  Created by Alexander Li on 2015-11-07.
//  Copyright © 2015 Alexander Li. All rights reserved.
//

import UIKit

class ClothingItemCollectionViewCell: UICollectionViewCell {

    var clothingItem:Clothing!
    
    @IBOutlet weak var clothingImageView: UIImageView!
    @IBOutlet weak var costLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureViews() {
        costLabel.text = clothingItem.cost.description
        clothingImageView.image = UIImage(named: clothingItem.name + "image")
    }

}
