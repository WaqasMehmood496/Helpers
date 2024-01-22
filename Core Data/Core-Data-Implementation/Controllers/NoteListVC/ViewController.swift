//
//  ViewController.swift
//  Core-Data-Implementation
//
//  Created by Mapple.pk on 22/05/2023.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var notesList: UITableView!
    
    var presenter = NotePresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllData()
    }
    
    @IBAction func addNewBtnAction(_ sender: UIButton) {
        
    }
    
    @IBAction func deleteAllBtnAction(_ sender: UIButton) {
        deleteAllRecord()
    }
    
    
}

// HELPING METHOD'S
extension ViewController {
    
    func getAllData() {
        presenter.getAllRecord { [weak self] in
            self?.notesList.reloadData()
        } failure: { error in
            print(error)
        }
    }
    
    func deleteAllRecord() {
        presenter.deleteAllRecord { [weak self] in
            self?.getAllData()
        } failure: { error in
            print(error)
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.allList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.register(NoteCell.self, indexPath: indexPath)
        cell.config(data: presenter.allList[indexPath.row])
        return cell
    }
    
}
