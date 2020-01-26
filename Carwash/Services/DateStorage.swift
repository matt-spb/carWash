//
//  DateStorage.swift
//  Carwash
//
//  Created by matt_spb on 25/01/2020.
//  Copyright © 2020 matt_spb_dev. All rights reserved.
//

import Foundation

class DateStorage {
    static let shared = DateStorage()
    
    private var dateStorage = [Int: [String: String]]()
        
    func fillDatesForBox(box: Int, andCars cars: Int) {
        if dateStorage[box] == nil {
            
            // получаем из генератора массив рандомных дат и записываем их в словарь по ключу box
            let dates = DataService.shared.generateDates(forCars: cars)
            var washDates = [String: String]()
            // заполняем словарь тачек и дат
            for index in dates.indices {
                let str = "Тачка \(index + 1)"
                washDates[str] = dates[index]
            }
            dateStorage[box] = washDates
        }
    }
    
    func getWashDatesForBox(box: Int) -> [String: String] {
        return dateStorage[box] ?? [:]
    }
    
    func journalForBox(box: Int) -> [String: String]? {
        return dateStorage[box] ?? [:]
    }
}


// в свойтсвах бокса объекты машин
// все делаем через объекты
