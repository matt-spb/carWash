//
//  ViewController.swift
//  Carwash
//
//  Created by matt_spb on 22/01/2020.
//  Copyright © 2020 matt_spb_dev. All rights reserved.
//

import UIKit

class CarwashVC: UIViewController {
    
    @IBOutlet weak var carwashTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNibs()
        carwashTable.delegate = self
        carwashTable.dataSource = self
        
        let rect = CGRect(x: 0, y: 0, width: view.frame.width, height: 350)
        let headerView = HeaderView(frame: rect)
        carwashTable.tableHeaderView = headerView
        
        //navigationItem.backBarButtonItem?.title = "Back"
        navigationItem.hidesBackButton = true

    }
    
    override func viewWillAppear(_ animated: Bool) {
        carwashTable.reloadData()
    }
}

extension CarwashVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return DataService.shared.getBoxes().count
        case 1:
            return DataService.shared.getComments().count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "BoxCell", for: indexPath) as! BoxCell
            let box = DataService.shared.getBoxes()[indexPath.row]
            cell.updateCell(box: box)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentCell
            let comment = DataService.shared.getComments()[indexPath.row]
            cell.updateCell(comment: comment)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Все боксы"
        case 1:
            return "Отзывы"
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 80
        case 1:
            return UITableView.automaticDimension
        default:
            return UITableView.automaticDimension
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            guard let carDetailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CarDetailVC") as? CarDetailVC else { return }
            carDetailVC.boxNumber = indexPath.row
            
            navigationController?.pushViewController(carDetailVC, animated: true)
            
        default: break
        }
        carwashTable.deselectRow(at: indexPath, animated: true)
    }
}

extension CarwashVC {
    func setupNibs() {
        let nib1 = UINib(nibName: "BoxCell", bundle: nil)
        carwashTable.register(nib1, forCellReuseIdentifier: "BoxCell")
        
        let nib2 = UINib(nibName: "CommentCell", bundle: nil)
        carwashTable.register(nib2, forCellReuseIdentifier: "CommentCell")
    }
}
