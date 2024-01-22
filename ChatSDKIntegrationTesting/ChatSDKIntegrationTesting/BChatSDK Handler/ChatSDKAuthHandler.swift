//
//  ChatSDKAuthHandler.swift
//  ChatSDKIntegrationTesting
//
//  Created by Mapple.pk on 07/08/2023.
//

import Foundation
import ChatSDK

class ChatSDKAuthHandler {
    
//    private var auth = BChatSDK.auth()
    
    init() {}
    
    func getCurrentUserName() -> String {
        return BChatSDK.auth().currentUser().name()
    }
    
    func getCurrentUserStatus() -> String {
        return BChatSDK.auth().currentUser().statusText() ?? ""
    }
    
    func isUserAlreadyLogin() -> Bool {
        if BChatSDK.auth().isAuthenticated() {
            return true
        } else {
            return false
        }
    }
    
    func getCurrentUser() -> PUser? {
        BChatSDK.auth().currentUser()
    }
    
    func createAccount(email:String, password:String, completion: @escaping(String?,Error?) -> Void) {
        let _ = BChatSDK.auth().authenticate(BAccountDetails.signUp(email, password: password))?.thenOnMain({ success in
            print("Account Created Successfully")
            if let success = success {
                print(success)
            }
            completion("success",nil)
            return success
        }, { error in
            print("ERROR = \(String(describing: error))")
            completion(nil,error)
            return error
        })
    }
    
    func authenticateUser(email:String, password:String, completion: @escaping(String?,Error?) -> Void) {
        BChatSDK.auth().authenticate(BAccountDetails.username(email, password: password))?.thenOnMain({ success in
            print("Success")
            if let success = success {
                print(success)
            }
            completion("success",nil)
            return success
        }, { error in
            print("Success = \(String(describing: error))")
            completion(nil,error)
            return error
        })
    }
    
    func getOtherUserData(otherUserEntityId: String) -> PUser? {
        if let otherUser = BChatSDK.core().user(forEntityID: otherUserEntityId) {
            return otherUser
        } else {
            return nil
        }
    }
    
}
