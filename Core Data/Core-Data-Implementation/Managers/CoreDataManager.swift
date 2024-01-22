//
//  CoreDataManager.swift
//  Core-Data-Implementation
//
//  Created by Mapple.pk on 22/05/2023.
//

import Foundation
import CoreData
import SwiftyJSON

enum CoreDataTables: String {
    case NoteDB = "NoteDB"
}

class CoreDataManager: NSObject {
    
    static let shared = CoreDataManager()
    private let dbName = "Core_Data_Implementation"
    //    private let tableName = "NoteDB"
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: dbName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var manageContextObject: NSManagedObjectContext {
        get {
            return self.persistentContainer.viewContext
        }
    }
    
    // INITIALIZAER'S
    override init() {}
    
    func saveContext () {
        if manageContextObject.hasChanges {
            do {
                try manageContextObject.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // GET RECORDS METHOD'S
    func getRequest<T: Decodable>(table:CoreDataTables,completion: @escaping (T) -> Void, failure: @escaping (String) -> Void) {
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: table.rawValue)
        do {
            let result = try manageContextObject.fetch(fetchRequest)
            var convertIntoDictionary : [[String:Any]] = []
            for data in result {
                convertIntoDictionary.append(data.toDict())
            }
            ParserManager.parseResponse(response: JSON(convertIntoDictionary), completion: completion, failure: failure)
        } catch {
            failure("Fail to fetch data from core data")
        }
        
    }
    
    //Save data
    func insert(dataToBeInsert: [String:Any], table:CoreDataTables, completion: @escaping (Bool,String) -> Void) {
        
        let entity = NSEntityDescription.entity(forEntityName: table.rawValue, in: manageContextObject)!
        let genericItem = NSManagedObject(entity: entity, insertInto: manageContextObject)
        for data in dataToBeInsert {
            genericItem.setValue(data.value, forKey: data.key)
        }
        do { //Save context and add to array
            try self.manageContextObject.save()
            print("RECORD INSERT SUCESSFULLY")
            completion(true,"RECORD INSERT SUCESSFULLY")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            completion(false,"Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func deleteAllData(table:CoreDataTables, completion: @escaping (Bool,String) -> Void) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: table.rawValue)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try manageContextObject.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
                manageContextObject.delete(objectData)
            }
            completion(true,"ALL RECORD DELETED SUCESSFULLY")
        } catch let error {
            print("Detele all data in error :", error)
            completion(false,"FAIL TO DELETE ALL RECORD")
        }
    }
    
    
    
    //MARK: RESPONSE PARSER
    
    
    
}



extension NSManagedObject {
    func toDict() -> [String:Any] {
        let keys = Array(entity.attributesByName.keys)
        return dictionaryWithValues(forKeys:keys)
    }
}
