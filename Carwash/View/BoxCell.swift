//
//  BoxCell.swift
//  Carwash
//
//  Created by matt_spb on 22/01/2020.
//  Copyright © 2020 matt_spb_dev. All rights reserved.
//

import UIKit

class BoxCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var carAmount: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateCell(box: Box) {
        title.text = box.title
        carAmount.text = "\(box.cars.count) машин"
    }
}
