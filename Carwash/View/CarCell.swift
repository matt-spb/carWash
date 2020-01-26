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

    func updateCell(carData: CarData) {
        self.carTitle.text = carData.carTitle
        self.dataLabel.text = carData.carDate
    }
}
