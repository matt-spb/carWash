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

    
    // Генератор боксов
    private func generateBoxes() -> [Box] {
        var boxes = [Box]()
        let number = Int.random(in: 1...10)
        for num in 0...number {
            let cars = Int.random(in: 1...15)
            let box = Box(title: "Бокс \(num + 1)", carAmount: "\(cars) машин")
            boxes.append(box)
        }
        return boxes
    }

    
    // генератор коментов
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
    
    // генерим нужное количество дат по количеству тачек в боксе
    func generateDates(forCars cars: Int) -> [String] {
        var randomDates = [String]()
        for _ in 1...cars {
            let now = Date() // дата сейчас
            let randomDayInterval = Int.random(in: 1...365) * 86400
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            
            // вычитаем рандомное количество дней
            let randomDate = now.addingTimeInterval(TimeInterval(-randomDayInterval))
            
            // переводим дату в строку
            let stringRandomDate = formatter.string(from: randomDate)
            
            randomDates.append(stringRandomDate)
        }
        return randomDates
    }
    
    
    func getBoxes() -> [Box] {
        return boxes
    }
    
    func getComments() -> [Comment] {
        return comments
    }
}
