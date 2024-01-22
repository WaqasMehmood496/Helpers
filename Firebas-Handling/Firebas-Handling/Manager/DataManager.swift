//
//  DataManager.swift
//  Firebas-Handling
//
//  Created by Mapple.pk on 01/06/2023.
//

import Foundation

class DataManager {
    
    static let shared = DataManager()
    
    
    //MARK: String
    func setStringData (value: String, key: String) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    func getStringData (key: String) -> String{
        return UserDefaults.standard.string(forKey: key) ?? ""
    }
    
    func deleteStringData (key: String) {
        UserDefaults.standard.set(nil, forKey: key)
    }
    
    
    //MARK: INTEGER
    func setIntData (value: Int, key: String) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    func getIntData (key: String) -> Int{
        return UserDefaults.standard.integer(forKey: key)
    }
    
    //MARK: INTEGER
    func setBoolStatus (value: Bool, key: String) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    func getBoolStatus (key: String) -> Bool {
        return UserDefaults.standard.bool(forKey: key)
    }
    
    
    //MARK: User Status
    func setUserStatus (value: Bool) {
        UserDefaults.standard.set(value, forKey: "is_guest")
    }
    
    func getUserStatus() -> Bool {
        return UserDefaults.standard.bool(forKey: "is_guest")
    }
    
    
    //MARK: MODEL
    func saveObject<T: Encodable> (key: String, object: T) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(object) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: key)
        }
    }
    
    func getObject<P: Decodable>(obj: P.Type, key:String) -> P? {
        if let savedPerson = UserDefaults.standard.object(forKey: key) as? Data {
            let decoder = JSONDecoder()
            if let loadedObj = try? decoder.decode(P.self, from: savedPerson) {
                return loadedObj
            }
        }
        return nil
    }
    
    func removeObject(key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
    
    
    
//    //MARK: Timer
//    func setTokenReceivedTime()
//    {
//        let dateString = DateUtil().dateToString(date: Date(), reqDF: .yyyy_MM_dd_HH_mm_ss) // date in string yyyy-mm-dd HH:mm:ss
//        UserDefaults.standard.set(dateString, forKey: "startTime")
//    }
//
//    func getTokenReceiveTime() -> Date?
//    {
//        let dateString = UserDefaults.standard.object(forKey: "startTime")
//        let date = DateUtil().stringToDate(date: dateString as! String, sourceDF: .yyyy_MM_dd_HH_mm_ss) //date in string yyyy-mm-dd HH:mm:ss
//        return date
//    }
    
    
    func setTimerCounting(_ val: Bool)
    {
        UserDefaults.standard.set(val, forKey: "counting")
    }
    
    
    
    
    func deleteUser () {
        UserDefaults.standard.set(nil, forKey: "user_data")
    }
    
    //MARK: Authentication
    func setAuthentication (auth: String) {
        UserDefaults.standard.set(auth, forKey: "ACCESS_Token")
    }
    
    func getAuthentication() -> String {
        var token: String?
        
        if UserDefaults.standard.string(forKey: "ACCESS_Token") != nil {
            token = UserDefaults.standard.string(forKey: "ACCESS_Token")!
        }
        return token!
    }
    
    func deleteAuthentication () {
        UserDefaults.standard.set(nil, forKey: "ACCESS_Token")
    }
    
    
    //FCM Token
    func setFCMToken (auth: String) {
        UserDefaults.standard.set(auth, forKey: "fcmToken")
    }
    
    func getFCMToken() -> String {
        
        if let token = UserDefaults.standard.string(forKey: "fcmToken") {
            return token
        }
        return ""
    }
    
}
