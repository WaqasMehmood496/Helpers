//
//  ChatListVC.swift
//  ChatSDKIntegrationTesting
//
//  Created by Mapple.pk on 01/08/2023.
//

import UIKit
import ChatSDK

class ChatListVC: UIViewController {
    
    @IBOutlet weak var chatListTable: UITableView!
    
    var listOfThread: [PThread] = []
    var chatHandler = ChatSDKHandler.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Chat List"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logout))
        chatListTable.register(UINib(nibName: "ChatListCell", bundle: nil), forCellReuseIdentifier: "ChatListCell")
        self.chatHandler.addHockForThreads {
            self.getAllThreads()
        }
        getAllThreads()
    }
    
    
    @IBAction func createNewThread(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let userListVC = storyboard.instantiateViewController(withIdentifier: "CreateThreadPopupVC") as! CreateThreadPopupVC
        userListVC.delegate = self
        userListVC.modalTransitionStyle = .coverVertical
        userListVC.modalPresentationStyle = .automatic
        self.navigationController?.pushViewController(userListVC, animated: true)
    }
    
    @objc func logout() {
        BChatSDK.logout()
    }
    
    func moveToconversationVC(thread:PThread) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let conversation = storyboard.instantiateViewController(withIdentifier: "ConversationVC") as! ConversationVC
        //ConversationVC
        conversation.thread = thread
        self.navigationController?.pushViewController(conversation, animated: true)
    }
    
}

extension ChatListVC: UITableViewDataSource, UITableViewDelegate, CreatePopupResponder {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfThread.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatListCell") as! ChatListCell
        cell.config(chatId: listOfThread[indexPath.row].name())
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.moveToconversationVC(thread: listOfThread[indexPath.row])
    }
    
    // CREATE CHAT RESPONDER
    func selectedUserId(userId: String) {
        //        createChatThread(otherUserId: userId)
        createPublicChatThread(otherUserId: userId)
    }
    
}


extension ChatListVC {
    
    func getAllThreads() {
        
        self.chatHandler.threadHandler.fetchUserAllThreads { list, error in
            if list != nil {
                guard let threadList = list else {
                    return
                }
                self.listOfThread = threadList
                self.chatListTable.reloadData()
            }
        }
    }
    
    func createChatThread(otherUserId:String) {
        
        self.chatHandler.threadHandler.createChatThread(otherUserEntityId: otherUserId, chatName: "OneToOne_\(otherUserId)") { thread, error in
            if error == nil {
                //                let chatViewController = ChatVIewController(thread: thread)
                if let thread = thread {
                    self.getAllThreads()
                } else {
                    print("Thread cannot be found")
                }
                
            } else {
                // Show error here
                print(error?.localizedDescription)
            }
        }
    }
    
    func createPublicChatThread(otherUserId:String) {
        
        self.chatHandler.threadHandler.createPublicChatThread(otherUserEntityId: otherUserId, chatName: "PrivateGroup_\(otherUserId)") { thread, error in
            if error == nil {
                //                let chatViewController = ChatVIewController(thread: thread)
                if let thread = thread {
                    self.getAllThreads()
                } else {
                    print("Thread cannot be found")
                }
                
            } else {
                // Show error here
                print(error?.localizedDescription)
            }
        }
    }
    
}
