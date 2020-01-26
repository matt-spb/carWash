//
//  CarData.swift
//  Carwash
//
//  Created by matt_spb on 24/01/2020.
//  Copyright © 2020 matt_spb_dev. All rights reserved.
//

import Foundation

struct CarData {
    var carTitle: String
    var carDate: String
    
    init(carTitle: String, carDate: String) {
        self.carTitle = carTitle
        self.carDate = carDate
    }
}
