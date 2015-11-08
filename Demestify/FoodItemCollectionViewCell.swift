//
//  FoodItemCollectionViewCell.swift
//  Demestify
//
//  Created by Alexander Li on 2015-11-07.
//  Copyright © 2015 Alexander Li. All rights reserved.
//

import UIKit

protocol FoodItemCollectionViewCellDelegate {
    func foodItemCollectionViewCellDidSelect(foodItem:Food)
}

class FoodItemCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var healthLabel: UILabel!
    
    var foodItem:Food!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell() {
        costLabel.text = foodItem.cost.description
        healthLabel.text = foodItem.health.description
        foodImageView.image = UIImage(named: foodItem.name.lowercaseString + "_image")
    }
}
