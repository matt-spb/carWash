//
//  Comments.swift
//  Carwash
//
//  Created by matt_spb on 23/01/2020.
//  Copyright © 2020 matt_spb_dev. All rights reserved.
//

import Foundation

struct Comment {
    private(set) var name: String
    public var text: String
    
    mutating func setText(_ text: String) {
        self.text = text
    }
}
