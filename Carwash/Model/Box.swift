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
    private(set) var cars: [Car]
    
    mutating func removeCar(atIndex index: Int) {
        cars.remove(at: index)
    }
    
    mutating func addCar(car: Car) {
        cars.insert(car, at: 0)
    }
}
