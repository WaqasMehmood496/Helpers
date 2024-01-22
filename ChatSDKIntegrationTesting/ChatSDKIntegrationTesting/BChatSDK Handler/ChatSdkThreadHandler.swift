//
//  ChatSdkThreadHandler.swift
//  ChatSDKIntegrationTesting
//
//  Created by Mapple.pk on 07/08/2023.
//

import Foundation
import ChatSDK

class ChatSdkThreadHandler {
    
    var thread = BChatSDK.thread()
    var core: PCoreHandler!
    
    init() {
        core = BChatSDK.core()
    }
    
    func createChatThread(otherUserEntityId: String, chatName: String, completion: @escaping(PThread?,Error?) -> Void)  {
        
//        let currentUser: PUser = BChatSDK.currentUser();
        let otherUser: PUser = core.user(forEntityID: otherUserEntityId)
        
        thread.createThread(withUsers: [otherUser], name: chatName, threadCreated: { error, thread in
            if error == nil {
                print("Thread Created Successfully")
                if let thread = thread {
                    print(thread)
                }
                completion(thread,nil)
            } else {
                print(error)
                completion(nil,error)
            }
        })
        
    }
    
    func createPublicChatThread(otherUserEntityId: String, chatName: String, completion: @escaping(PThread?,Error?) -> Void)  {
        
        let currentUser: PUser = BChatSDK.currentUser();
        let otherUser: PUser = BChatSDK.core().user(forEntityID: otherUserEntityId)
        
        BChatSDK.thread().createThread(withUsers: [currentUser, otherUser], name: chatName, imageURL: "", type: bThreadTypePrivateGroup, entityID: nil, forceCreate: true) { error, thread in
            if error == nil {
                print("Thread Created Successfully")
                if let thread = thread {
                    print(thread)
                }
                completion(thread,nil)
            } else {
                print(error)
                completion(nil,error)
            }
        }
    }
    
    func fetchSingleThread(otherUserEntityId: String, completion: @escaping(PThread?,String?) -> Void) {
        
        if ChatSDKHandler.shared.authHandler.isUserAlreadyLogin() {
            guard let currentUser = ChatSDKHandler.shared.authHandler.getCurrentUser() else {
                print("User not logged in")
                return
            }
            
            // Get the other user using the given entity ID
            let otherUser =  core.user(forEntityID: otherUserEntityId)
            
            // Make sure both users are not nil before attempting to fetch the thread
            if let otherUser = otherUser {
                // Create an array with the two users
                let users = [currentUser, otherUser]
                
                // Fetch the thread with the given users
                if let thread = self.thread.fetchThread(withUsers: users) {
                    print("Found thread: \(thread.entityID()), Name: \(thread.displayName())")
                    completion(thread, nil)
                } else {
                    print("Thread not found")
                    completion(nil, "Thread not found")
                }
            } else {
                print("Invalid user(s)")
                completion(nil, "Invalid user(s)")
            }
        } else {
            print("Please login again...")
        }
    }
    
    func fetchUserAllThreads(completion: @escaping ([PThread]?, String?) -> Void) {
        if ChatSDKHandler.shared.authHandler.isUserAlreadyLogin() {
            
            guard let currentUser = ChatSDKHandler.shared.authHandler.getCurrentUser() else {
                print("User not logged in")
                completion(nil, "User not logged In")
                return
            }
            
            // Fetch all threads created by the current user
            if let threads = BChatSDK.thread().threads(with: bThreadFilterPrivate) {
                
                if !threads.isEmpty {
                    print("Found \(threads.count) threads.")
                    completion(threads as? [PThread], nil)
                } else {
                    print("No threads found.")
                    completion(nil, "No threads found.")
                }
            } else {
                print("Please login again...")
                completion(nil, "Please login again...")
            }
        }
    }
    
    func sendTextMessage(text:String, threadEntityID:String) {
        _ = BChatSDK.thread().sendMessage(withText: text, withThreadEntityID: threadEntityID)?.thenOnMain({ success in
            print("MESSAGE SEND SUCCESSFULLY")
            return success
        }, { error in
            
            return error
        })
        
    }
}
