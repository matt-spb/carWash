//
//  CarDetailVC.swift
//  Carwash
//
//  Created by matt_spb on 24/01/2020.
//  Copyright © 2020 matt_spb_dev. All rights reserved.
//

import UIKit

// отрефакторить код, вынести в отдельную функцию настройку кнопки добавить и редактировать

class CarDetailVC: UIViewController {
        
    var boxNumber: Int?
    
    @IBOutlet weak var carDataTable: UITableView!

    // сделаьть AddButton неактивной когда нажата кнопка эдит, а делит подсветить только когда есть выделенная тачка
    
    override func viewDidLoad() {
        super.viewDidLoad()
        carDataTable.delegate = self
        carDataTable.dataSource = self
        carDataTable.tableFooterView = UIView()
        setupNibs()
                        
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCarToJournal))
        
        //let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(startEditing))
        
        let deleteButton = UIBarButtonItem(title: "Delete", style: .plain, target: self, action: #selector(deleteCars))
        
        navigationItem.rightBarButtonItems = [addButton, editButtonItem, deleteButton]

        //navigationItem.title = "Журнал"
        //navigationItem.backBarButtonItem?.title = ""
        carDataTable.allowsMultipleSelectionDuringEditing = true
    }
    
    @objc func deleteCars() {
        if let selectedRows = carDataTable.indexPathsForSelectedRows {

            var carsToDelete = [Int]()
            for indexPath in selectedRows {
                carsToDelete.append(indexPath.row)
            }

            for index in carsToDelete {
                DataService.shared.removeCarFrom(box: boxNumber!, at: index)
            }
            
            carDataTable.beginUpdates()
            carDataTable.deleteRows(at: selectedRows, with: .fade)
            carDataTable.endUpdates()
        }
    }
    
    
    @objc func addCarToJournal() {

        let alert = UIAlertController(title: "Add car", message: nil, preferredStyle: .alert)
        
        alert.addTextField { (textField: UITextField) in
            textField.placeholder = "Enter a car"
        }
        
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { (UIAlertAction) in
            guard let brandNewCar = alert.textFields?.first?.text else { return } //as UITextField
        
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            let dateNewCar = formatter.string(from: Date())
            
            let newCar = Car(brand: brandNewCar, dateOfWash: dateNewCar)
            DataService.shared.addCar(car: newCar, toBox: self.boxNumber!)
            self.carDataTable.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}

extension CarDetailVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataService.shared.getBoxes()[boxNumber!].cars.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = carDataTable.dequeueReusableCell(withIdentifier: "CarCell", for: indexPath) as! CarCell
        
        let car = DataService.shared.getBoxes()[boxNumber!].cars[indexPath.row]
        cell.updateCell(car: car)
        return cell
    }
        
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            DataService.shared.removeCarFrom(box: boxNumber!, at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // разрешает подсвечивать ряды
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // разрешает редактировать ряды
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        carDataTable.setEditing(editing, animated: true)
    }
}

extension CarDetailVC {
    func setupNibs() {
        let nib = UINib(nibName: "CarCell", bundle: nil)
        carDataTable.register(nib, forCellReuseIdentifier: "CarCell")
    }
}
