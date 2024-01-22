//
//  ChatSdkDBHandler.swift
//  ChatSDKIntegrationTesting
//
//  Created by Mapple.pk on 03/08/2023.
//

import Foundation
import ChatSDK

class ChatSdkDBHandler {
    
    init() {}
    
    func fetchAllMessages(thread: PThread) -> [PMessage] {
        var threadList: [PMessage] = []
        if let messageList = BChatSDK.db().loadAllMessages(for: thread, newestFirst: false) {
            //            self.messagesList.text = ""
            //            var textViewText = self.messagesList.text!
            
            for message in messageList {
                if let mesg = message as? PMessage {
                    //                    textViewText = textViewText.appending("\(String(describing: mesg.text())) \n\n ")
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
                    
                    threadList.append(mesg)
                }
            }
            //            self.messagesList.text = textViewText
            print(messageList.count)
        }
        return threadList
    }
    
}
