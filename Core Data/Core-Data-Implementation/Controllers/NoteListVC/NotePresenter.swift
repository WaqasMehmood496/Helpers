//
//  NotePresenter.swift
//  Core-Data-Implementation
//
//  Created by Mapple.pk on 23/05/2023.
//

import Foundation

class NotePresenter: NSObject {
    
    var allList: [NoteTableModel] = []
    
    override init() {}
    
    func addNewRecord() {
        
    }
    
    func getAllRecord(completion: @escaping() -> Void, failure: @escaping(String) -> Void) {
        CoreDataManager.shared.getRequest(table: .NoteDB) { [weak self] (data: [NoteTableModel]) in
            self?.allList = data
            completion()
        } failure: { error in
            print(error)
            failure(error)
        }
    }
    
    func deleteAllRecord(completion: @escaping() -> Void, failure: @escaping(String) -> Void) {
        CoreDataManager.shared.deleteAllData(table: .NoteDB) { [weak self] (isDeleted, message) in
            if isDeleted {
                completion()
            } else {
                failure(message)
            }
        }
    }
    
}
