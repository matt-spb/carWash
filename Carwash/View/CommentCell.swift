//
//  CommentCell.swift
//  Carwash
//
//  Created by matt_spb on 23/01/2020.
//  Copyright © 2020 matt_spb_dev. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func updateCell(comment: Comment) {
        nameLabel.text = comment.name
        commentLabel.text = comment.text
    }
    
}
