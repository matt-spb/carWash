//
//  HeaderView.swift
//  Carwash
//
//  Created by matt_spb on 25/01/2020.
//  Copyright © 2020 matt_spb_dev. All rights reserved.
//

import UIKit

class HeaderView: UIView {

    var imageView: UIImageView!
    var rateLabel = UILabel()
    var rate = UILabel()
    var vacantLabel = UILabel()
    var washTitle = UILabel()
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupImage() {
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 225))
        imageView.image = UIImage(named: "Header")
        imageView.contentMode = .scaleAspectFit
        
        rateLabel.font = UIFont.systemFont(ofSize: 30)
        rateLabel.frame = CGRect(x: 10, y: 210, width: UIScreen.main.bounds.width - 120, height: 80)
        rateLabel.text = "Общий рейтинг:"
        
        rate.font = UIFont.systemFont(ofSize: 30)
        rate.frame = CGRect(x: UIScreen.main.bounds.width - 60, y: 210, width: 100, height: 80)
        rate.text = String(format: "%.1f", Double.random(in: 2...5.0))
        
        washTitle.font = UIFont.boldSystemFont(ofSize: 50)
        washTitle.textColor = #colorLiteral(red: 0.08845170587, green: 0.6073538661, blue: 0.6675571799, alpha: 1)
        washTitle.textAlignment = .center
        washTitle.frame.size = CGSize(width: 300, height: 100)
        washTitle.frame.origin.y = 140
        washTitle.center.x = self.center.x
        washTitle.text = "Мормойка"
        
        let isVacant = Int.random(in: 0...Int.max) % 2 == 0 ? true : false
        vacantLabel.font = UIFont.boldSystemFont(ofSize: 30)
        vacantLabel.textColor = isVacant ? #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1) : #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        vacantLabel.text = isVacant ? "СВОБОДНО" : "НЕТ МЕСТ"
        vacantLabel.textAlignment = .center
        vacantLabel.frame.size = CGSize(width: 300, height: 80)
        vacantLabel.center.x = self.center.x
        vacantLabel.frame.origin.y = 280
        
        
        self.addSubview(imageView)
        self.addSubview(rateLabel)
        self.addSubview(rate)
        self.addSubview(washTitle)
        self.addSubview(vacantLabel)
        
    }
}
