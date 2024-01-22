//
//  ChatSDKHandler.swift
//  ChatSDKIntegrationTesting
//
//  Created by Mapple.pk on 25/07/2023.
//

import Foundation
import ChatSDK
import ChatSDKFirebase

class ChatSDKHandler {
    
    static let shared = ChatSDKHandler()
    
    private var db_Handler = ChatSdkDBHandler()
    private var auth_Handler = ChatSDKAuthHandler()
    private var thread_Handler = ChatSdkThreadHandler()
    
    var dbHandler: ChatSdkDBHandler {
        get {
            self.db_Handler
        }
    }
    
    var authHandler: ChatSDKAuthHandler {
        get {
            self.auth_Handler
        }
    }
    
    var threadHandler: ChatSdkThreadHandler {
        get {
            self.thread_Handler
        }
    }
    
    private init() {}
    
    func addHockForMessages(completion: @escaping () -> Void) {
        BChatSDK.hook().add(BHook.init(onMain: { dict in
            if let message = dict?[bHook_PMessage] as? PMessage {
                completion()
            }
        }, weight: 10), withNames: [bHookMessageRecieved, bHookMessageWillSend])
    }
    
    func addHockForThreads(completion: @escaping () -> Void) {
        BChatSDK.hook().add(BHook.init(onMain: { dict in
            if let thread = dict?[bHook_PThread] as? PThread {
                print(thread)
                completion()
            }
        }, weight: 10), withNames: [bHookThreadUpdated, bHookThreadAdded, bHookThreadRemoved])
    }
    
    func chatSDKConfiguration() -> BConfiguration {
        let config = BConfiguration.init()
        config.shouldAskForNotificationsPermission = true
        config.showLocalNotifications = true
        
        config.rootPath = "test"
        // Configure other options here...
        config.allowUsersToCreatePublicChats = true
        config.googleMapsApiKey = "AIzaSyDJEJokyGTmrtYB5BODVNHTZlDoshr1OzQ"
        config.nameLabelPosition = bNameLabelPositionTop
        config.showMessageAvatarAtPosition = bMessagePosFirst
        config.combineTimeWithNameLabel = true
        return config
    }
    
    func chatSDKModules() -> [NSObject] {
        return [
            FirebaseNetworkAdapterModule.shared(),
            FirebasePushModule.shared(),
            FirebaseUploadModule.shared()
        ]
    }
    
    func fetchAllUsersList() -> [PUser] {
        if let allUsers = BChatSDK.users().allUsers?() {
            return (allUsers as? [PUser])!
        } else {
            return []
        }
    }
    
    
//    func sendTextMessage(text:String, threadEntityID:String) {
//        _ = BChatSDK.thread().sendMessage(withText: text, withThreadEntityID: threadEntityID)?.thenOnMain({ success in
//            print("MESSAGE SEND SUCCESSFULLY")
//            return success
//        }, { error in
//            
//            return error
//        })
//    }
    
    func sendAudio(audioName:String, audioType:String, threadEntityID: String) {
        
        if let path = Bundle.main.path(forResource: audioName, ofType: audioType) {
            let fileManager = FileManager.default
            
            // Check if the file exists at the specified path
            if fileManager.fileExists(atPath: path) {
                if let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
                    BChatSDK.audioMessage()?.sendMessage(withAudio: data, duration: 28.0, withThreadEntityID: threadEntityID)
                        .thenOnMain({ success in
                            print("AUDIO SEND SUCCESSFULLY")
                            return success
                        }, { error in
                            print(error?.localizedDescription)
                            return error
                        })
                } else {
                    print("Failed to convert audio file into data")
                }
            } else {
                print("Audio file does not exist at the specified path")
            }
        } else {
            print("Audio file path not found in the Bundle")
        }
    }
    
    func sendImage(image:UIImage, threadEntityID: String) {
        //        let auth: PAuthenticationHandler = BChatSDK.shared().networkAdapter!.auth()
        
        _ = BChatSDK.imageMessage()?.sendMessage(with: image, withThreadEntityID: threadEntityID)?.thenOnMain({ success in
            print("IMAGE SEND SUCCESSFULLY")
            return success
        }, { error in
            
            return error
        })
        //
    }
    
    func sendLocation(threadEntityID: String) {
        _ = BChatSDK.locationMessage()?.sendMessage(with: CLLocation(latitude: Double(23.5666), longitude: Double(73.5666)), withThreadEntityID: threadEntityID)?.thenOnMain({ success in
            print("Location SEND SUCCESSFULLY")
            return success
        }, { error in
            
            return error
        })
    }
    
    
}
