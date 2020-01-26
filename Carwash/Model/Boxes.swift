//
//  Boxes.swift
//  Carwash
//
//  Created by matt_spb on 22/01/2020.
//  Copyright © 2020 matt_spb_dev. All rights reserved.
//

import Foundation

struct Box {
    private(set) var title: String
    private(set) var carAmount: String
    
    init(title: String, carAmount: String) {
        self.title = title
        self.carAmount = carAmount
    }    
}
