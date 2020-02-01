//
//  CarCell.swift
//  Carwash
//
//  Created by matt_spb on 24/01/2020.
//  Copyright © 2020 matt_spb_dev. All rights reserved.
//

import UIKit

class CarCell: UITableViewCell {

    @IBOutlet weak var carTitle: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func updateCell(car: Car) {
        self.carTitle.text = car.brand
        self.dataLabel.text = car.dateOfWash
    }
}
