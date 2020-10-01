//
//  DataService.swift
//  Carwash
//
//  Created by matt_spb on 22/01/2020.
//  Copyright © 2020 matt_spb_dev. All rights reserved.
//

import Foundation

class DataService {
    static let shared = DataService()
    lazy private var boxes = generateBoxes()
    lazy private var comments = generateComments()
    
    private init() {}

    //MARK: Generating Cars
    // база брендов
    private let carBrands = ["BMW 525", "LEXUS IS250", "MERCEDES G500", "МОСКВИЧ 412", "ЛАДА Седан", "MAZDA CX7", "HONDA CRV", "AUDI A6", "TOYOTA RAV4", "DODGE", "SKODA SUPERB", "BMV X6", "LAND CRUISER", "JAGUAR", "BENTLY", "MAZERATI", "FERRARI F50", "PORSCHE 911", "LADA 2113", "HODA CIVIC", "MERCEDES E200", "UAZ PATRIOT", "RENO LAGUNA", "HYUNDAI SANTAFE"]
    
    private func generateCars() -> [Car] {
        var cars = [Car]()
        let randomNumberOfCars = Int.random(in: 1...15)
        for _ in 0...randomNumberOfCars {
            let brand = carBrands[Int.random(in: 0..<carBrands.count)]
            let date = generateDate()
            let car = Car(brand: brand, dateOfWash: date)
            cars.append(car)
        }
        return cars.sorted { (carA, carB) in
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            
            return formatter.date(from: carA.dateOfWash)! > formatter.date(from: carB.dateOfWash)!
        }
    }
    
    //MARK: Generating dates for car
    private func generateDate() -> String {
        
        let now = Date() // дата сейчас
        let randomDayInterval = Int.random(in: 1...365) * 86400
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        
        // вычитаем рандомное количество дней
        let randomDate = now.addingTimeInterval(TimeInterval(-randomDayInterval))
        
        // переводим дату в строку
        let stringRandomDate = formatter.string(from: randomDate)
        
        return stringRandomDate
    }
    
   
    //MARK: Generating Boxes
    private func generateBoxes() -> [Box] {
        var boxes = [Box]()
        let number = Int.random(in: 1...10)
        for num in 0...number {
            let cars = generateCars()
            let box = Box(title: "Бокс \(num + 1)", cars: cars)
            boxes.append(box)
        }
        return boxes
    }

   // MARK: - Generating Comments
    private let names = [
        "Василиса Сергеевна",
        "Марк Безруков",
        "Ваня Дампоголове",
        "Катя",
        "No name",
        "Гена Циганов",
        "Адам Владимирович Смит",
        "Братишка из Югославии",
        "Марат Сафинович"
    ]
    
    private let texts = [
        "Помыли все по красоте",
        "Моя малышка блестит как новая!",
        "Ребята знают свое дело. Рекомендую",
        "Меня бы так кто помыл...",
        "Поцарапали мою ласточку!!",
        "Люди, давайте быть добрее, а то че вы все охуели вконец? Ну ёбанарот, а. И машину мою помойте, ну.",
        "Короче. Я в ахуе. Эти педики перед тем, как помыть мою тачку, объехали полгорода! Мне подруга рассказала, у нее ворона есть грамотная, она на дереве у рынка сидит и все палит!"
    ]
    
    private func generateComments() -> [Comment] {
        var comments = [Comment]()
        let number = Int.random(in: 1...10)
        for _ in 0...number {
            let name = names[Int.random(in: 0..<names.count)]
            let text = texts[Int.random(in: 0..<texts.count)]
            let comment = Comment(name: name, text: text)
            comments.append(comment)
        }
        return comments
    }
    
    //MARK: Get functions
    
    func getBoxes() -> [Box] {
        return boxes
    }
    
    func getComments() -> [Comment] {
        return comments
    }
    
    //MARK: Removing car from box
    
    func removeCarFrom(box: Int, at index: Int) {
        boxes[box].removeCar(atIndex: index)
    }
    
    //MARK: Adding car to box
    
    func addCar(car: Car, toBox box: Int) {
        boxes[box].addCar(car: car)
    }
    
    //MARK: Editing text of comment
    func editComment(at index: Int, withText text: String) {
        comments[index].setText(text)
    }
}
