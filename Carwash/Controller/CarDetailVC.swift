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
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        setupNibs()
        configureNavButtons()
        tableView.allowsMultipleSelectionDuringEditing = true
    }
    
    
    fileprivate func configureNavButtons() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCarToJournal))
        
        let deleteButton = UIBarButtonItem(title: "Delete", style: .plain, target: self, action: #selector(deleteCars))
        
        deleteButton.isEnabled = false
        deleteButton.tintColor = .clear
        
        navigationItem.rightBarButtonItems = [addButton, editButtonItem, deleteButton]
    }
    
    
    @objc func deleteCars() {
        if let selectedRows = tableView.indexPathsForSelectedRows {

            var carsToDelete = [Int]()
            for indexPath in selectedRows {
                carsToDelete.append(indexPath.row)
            }
            
            for index in carsToDelete.sorted().reversed() {
                DataService.shared.removeCarFrom(box: boxNumber!, at: index)
            }
            
            tableView.beginUpdates()
            tableView.deleteRows(at: selectedRows, with: .fade)
            tableView.endUpdates()
            isEditing = false
            makeDeleteButtonUnactive()
            makeEditButtonActive()
        }
    }
    
    
    @objc func addCarToJournal() {

        let alert = UIAlertController(title: "Add car", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField: UITextField) in
            textField.placeholder = "Enter a car"
        }
        
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { (UIAlertAction) in
            guard let brandNewCar = alert.textFields?.first?.text else { return }
        
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            let dateNewCar = formatter.string(from: Date())
            
            let newCar = Car(brand: brandNewCar, dateOfWash: dateNewCar)
            DataService.shared.addCar(car: newCar, toBox: self.boxNumber!)
            
            let indexPath = IndexPath(row: 0, section: 0)
            self.tableView.insertRows(at: [indexPath], with: .fade)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "CarCell", for: indexPath) as! CarCell
        
        let car = DataService.shared.getBoxes()[boxNumber!].cars[indexPath.row]
        cell.updateCell(car: car)
        //cell.selectedBackgroundView = UIView()
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.isEditing {
            makeDeleteButtonActive()
            makeEditButtonUnactive()
        } else {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if tableView.indexPathsForSelectedRows == nil {
            makeDeleteButtonUnactive()
            makeEditButtonActive()
        }
    }
        
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            DataService.shared.removeCarFrom(box: boxNumber!, at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
    //включаем режим редактирования по нажатию Edit
    override func setEditing(_ editing: Bool, animated: Bool) {
        if editing {
            super.setEditing(true, animated: true)
            tableView.setEditing(true, animated: true)
            makeAddButtonUnactive()
        } else {
            super.setEditing(false, animated: false)
            tableView.setEditing(false, animated: true)
            makeAddButtonActive()
        }
    }
}


extension CarDetailVC {
    func setupNibs() {
        let nib = UINib(nibName: "CarCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "CarCell")
    }
}

//MARK: tuning bar buttons
extension CarDetailVC {
    
    private func makeDeleteButtonActive() {
        navigationItem.rightBarButtonItems?[2].isEnabled = true
        navigationItem.rightBarButtonItems?[2].tintColor = .systemRed
        navigationItem.rightBarButtonItems?[2].style     = .done
    }
    
    
    private func makeDeleteButtonUnactive() {
        navigationItem.rightBarButtonItems?[2].isEnabled = false
        navigationItem.rightBarButtonItems?[2].tintColor = .clear
    }
    
    
    private func makeEditButtonActive() {
        navigationItem.rightBarButtonItems?[1].isEnabled = true
        navigationItem.rightBarButtonItems?[1].tintColor = .systemBlue
    }
    
    
    private func makeEditButtonUnactive() {
        navigationItem.rightBarButtonItems?[1].isEnabled = false
    }
    
    private func makeAddButtonActive() {
        navigationItem.rightBarButtonItems?[0].isEnabled = true
        navigationItem.rightBarButtonItems?[0].tintColor = .systemBlue
    }
    
    
    private func makeAddButtonUnactive() {
        navigationItem.rightBarButtonItems?[0].isEnabled = false
    }
}


// что еще можно допилить:
// - сделать шалочки выбранных ячеек красными
// - вместо алерт контроллера вызвать новый ВК
