//
//  CarDetailVC.swift
//  Carwash
//
//  Created by matt_spb on 24/01/2020.
//  Copyright © 2020 matt_spb_dev. All rights reserved.
//

import UIKit

class CarDetailVC: UIViewController {
        
    var boxNumber: Int?  // будем передавать сюда номер бокса, чтобы получать для него даты из журнала
    
    @IBOutlet weak var carDataTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        carDataTable.delegate = self
        carDataTable.dataSource = self
        carDataTable.tableFooterView = UIView()
        setupNibs()
        
    }
}

extension CarDetailVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DateStorage.shared.getWashDatesForBox(box: boxNumber!).count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = carDataTable.dequeueReusableCell(withIdentifier: "CarCell", for: indexPath) as! CarCell
        
        // получаем с сервера словарь [машина: дата] для данного бокса
        let washDatesJournal = DateStorage.shared.getWashDatesForBox(box: boxNumber!)

        // создаем объект [CarData], чтобы отправить ячейке для обновления
        let carTitle = "Тачка \(indexPath.row + 1)"
        if let carDate = washDatesJournal[carTitle] {
            let carData = CarData(carTitle: carTitle, carDate: carDate)
            cell.updateCell(carData: carData)
        }

        return cell
    }
    
    
    // чтобы сделать нормальное удаление, нужно кол-во машин хранить в Инте отдельным лейблом. А не в строке как сейчас
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//
//            //DataService.shared.removeCarAt(index: indexPath.row)
//            let carToDalete = "Тачка \(indexPath.row + 1)"
//            DateStorage.shared.deleteDateAt(box: boxNumber!, forCar: carToDalete)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        }
//    }
}

extension CarDetailVC {
    func setupNibs() {
        let nib = UINib(nibName: "CarCell", bundle: nil)
        carDataTable.register(nib, forCellReuseIdentifier: "CarCell")
    }
}
