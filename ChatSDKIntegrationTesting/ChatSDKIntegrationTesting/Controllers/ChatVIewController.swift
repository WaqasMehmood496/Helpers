//
//  ChatVIewController.swift
//  ChatSDKIntegrationTesting
//
//  Created by Mapple.pk on 24/07/2023.
//

import UIKit
import ChatSDK

class ChatVIewController: UIViewController {
    
    @IBOutlet weak var messagesList: UITextView!
    @IBOutlet weak var messageField: UITextField!
    @IBOutlet weak var sendBtn: UIButton!
    
    var thread: PThread?
    var threadId = String()
    let networkAdapter = BChatSDK.shared().networkAdapter
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let user: PUser = BChatSDK.currentUser()
        print(user.entityID() ?? "")
        //        threadId = thread.userAccountID
        fetchAllMessages()
        
        BChatSDK.hook().add(BHook.init(onMain: { dict in
            if let message = dict?[bHook_PMessage] as? PMessage {
                //                print(message.text())
                self.fetchAllMessages()
            }
        }, weight: 10), withNames: [bHookMessageRecieved, bHookMessageWillSend])
    }
    
    @IBAction func sendButton(_ sender: UIButton) {
        
        if let threadId = thread?.entityID() {
            sendTextMessage(text: messageField.text!, threadEntityID: threadId)
        } else {
            print("THRESD IS NIL")
        }
        
    }
    
    @IBAction func sendLocation(_ sender: UIButton) {
        if let threadId = thread?.entityID() {
            self.sendLocation(threadEntityID: threadId)
        }
    }
    
    @IBAction func sendImage(_ sender: UIButton) {
        if let threadId = thread?.entityID() {
            sendImage(image: UIImage(named: "chat_bubble_right_S0")!, threadEntityID: threadId)
        } else {
            print("THRESD IS NIL")
        }
    }
    
    @IBAction func sendAudio(_ sender: UIButton) {
        if let threadId = thread?.entityID() {
            sendAudio(audioName: "SampleAudio", audioType: ".mp3", threadEntityID: threadId)
        } else {
            print("THRESD IS NIL")
        }
    }
    
    @IBAction func sendVideo(_ sender: UIButton) {
        
    }
    
    @IBAction func sendFile(_ sender: UIButton) {
        
    }
    
}


//MARK: UIIMPROVEMENT'S
extension ChatVIewController {
    
    func sendTextMessage(text: String, threadEntityID: String) {
        _ = BChatSDK.thread().sendMessage(withText: text, withThreadEntityID: threadEntityID)?.thenOnMain({ success in
            print("MESSAGE SEND SUCCESSFULLY")
            //            var textViewText = self.messagesList.text!
            //            self.messagesList.text = textViewText.appending("\n\n \(text)")
            
            self.fetchAllMessages()
            return success
        }, { error in
            
            return error
        })
    }
    
    func sendAudio(audioName:String, audioType:String, threadEntityID: String) {
        //        if let path = Bundle.main.url(forResource: audioName, withExtension: audioType) {
        //            guard let data = try? Data(contentsOf: path) else {
        //                print("Fail to send audio")
        //                return
        //            }
        //            _ = BChatSDK.audioMessage()?.sendMessage(withAudio: data, duration: Double(00.28), withThreadEntityID: threadEntityID)?.thenOnMain({ success in
        //                print("AUDIO SEND SUCCESSFULLY")
        //                self.fetchAllMessages()
        //                return success
        //            }, { error in
        //                print(error)
        //                return error
        //            })
        //        }
        
        
        if let path = Bundle.main.path(forResource: audioName, ofType: audioType) {
            let fileManager = FileManager.default
            
            // Check if the file exists at the specified path
            if fileManager.fileExists(atPath: path) {
                if let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
                    BChatSDK.audioMessage()?.sendMessage(withAudio: data, duration: 28.0, withThreadEntityID: threadEntityID)
                        .thenOnMain({ success in
                            print("AUDIO SEND SUCCESSFULLY")
                            self.fetchAllMessages()
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
        let auth: PAuthenticationHandler = networkAdapter!.auth()
        
        _ = BChatSDK.imageMessage()?.sendMessage(with: image, withThreadEntityID: threadEntityID)?.thenOnMain({ success in
            print("IMAGE SEND SUCCESSFULLY")
            self.fetchAllMessages()
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
    
    func sendFile(threadEntityID: String) {
        
    }
    
    func fetchAllMessages() {
        
        if let messageList = BChatSDK.db().loadAllMessages(for: thread, newestFirst: false) {
            self.messagesList.text = ""
            var textViewText = self.messagesList.text!
            for message in messageList {
                if let mesg = message as? PMessage {
                    textViewText = textViewText.appending("\(String(describing: mesg.text())) \n\n ")
                    print(mesg.text())
                    print(mesg.isDelivered())
                    print(mesg.isRead())
                    print(mesg.type())
                    print(mesg.meta())
                    //                    var longitude =
                    //                    var latitude = [message.meta[bMessageLatitude] floatValue];
                    //                    mesg.setType(1)
                    
                    //                    if  {
                    //                        //                    print((message as! PLocationMessageHandler))
                    //                    }
                }
            }
            self.messagesList.text = textViewText
            print(messageList.count)
        }
    }
    
    
    func chatEvents() {
        BChatSDK.hook().add(BHook.init(onMain: { dict in
            if let message = dict?[bHook_PMessage] as? PMessage {
                print(message.text())
            }
        }, weight: 10), withNames: [bHookMessageRecieved, bHookMessageWillSend])
    }
}

extension ChatVIewController {
    
}
