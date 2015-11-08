//
//  AnagramTableViewCell.swift
//  Demestify
//
//  Created by Alexander Li on 2015-11-08.
//  Copyright © 2015 Alexander Li. All rights reserved.
//

import UIKit

protocol AnagramTableViewCellDelegate {
    func anagramTableViewCellDidDeleteAnagram(item:AnagramModel)
}

class AnagramTableViewCell: UITableViewCell {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    
    var anagram:AnagramModel!
    var delegate:AnagramTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func deleteButtonTapped(sender: AnyObject) {
        if delegate != nil {
            delegate?.anagramTableViewCellDidDeleteAnagram(anagram)
        }
    }
}
