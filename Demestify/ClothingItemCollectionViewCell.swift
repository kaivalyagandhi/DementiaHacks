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
    var own:Bool = false
    
    @IBOutlet weak var clothingImageView: UIImageView!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var checkmarkImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell() {
        costLabel.text = clothingItem.cost.description
        clothingImageView.image = UIImage(named: clothingItem.name.lowercaseString + "_image")
        checkmarkImageView.hidden = !own
    }
}
