//
//  ViewController.swift
//  ChatSDKIntegrationTesting
//
//  Created by Mapple.pk on 21/07/2023.
//

import UIKit
import ChatSDK

class ViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Authentication"
//        if ChatSDKHandler.shared.isUserAlreadyLogin() {
//            moveToChatListVC()
//        }
    }
    
    
    @IBAction func openChatBtnAction( _ sender: UIButton) {
        
        if ChatSDKHandler.shared.authHandler.isUserAlreadyLogin() {
            print("USER ALREADY EXIST")
            self.loginUser()
//            moveToChatListVC()
        } else {
            createAccount()
        }
    }
}


// CHAR SDK HANDLER METHOD'S
extension ViewController {
    
    func createAccount() {
        
        guard let email = emailField.text else {return}
        guard let password = passwordField.text else {return}
        
        ChatSDKHandler.shared.authHandler.createAccount(email: email, password: password) { success, error in
            if error == nil {
                print("USER ACCOUNT CREATED SUCCESSFULLY")
                if BChatSDK.auth().isAuthenticated() {
                    // SAVE CURRENT USER INTO CACHE OR SERVER
                    //                    let user: PUser = BChatSDK.currentUser()
                    //                    Create chat Thread
//                    self.fetchThread()
//                    self.createChatThread()
                    self.moveToChatListVC()
                } else {
                    self.loginUser()
                }
            } else {
                // Show Error
                print(error?.localizedDescription)
                self.loginUser()
            }
        }
    }
    
    func loginUser() {
        guard let email = emailField.text else {return}
        guard let password = passwordField.text else {return}
        ChatSDKHandler.shared.authHandler.authenticateUser(email: email, password: password) { success, error in
            if error == nil {
                print("USER ACCOUNT LOGIN SUCCESSFULLY")
                //                    Create chat Thread
                self.moveToChatListVC()
//                self.createChatThread()
//                self.fetchThread()
            } else {
                // Show Error
                print(error?.localizedDescription)
            }
        }
    }
    
//    func fetchThread() {
//        
//        var otherUserId = String()
//        if emailField.text == "waqas1@codesorbit.com" {
//            otherUserId = "j85ga4ZszEO6c8L9Vn8sAFBXxhm1"
//        } else {
//            otherUserId = "ljjYFfWNMrZRRtCoS2hevIk73yX2"
//        }
//        
//        ChatSDKHandler.shared.fetchSingleThread(otherUserEntityId: otherUserId) { thread, error in
//            if let thread = thread {
//                self.moveToconversationVC(thread: thread)
//            } else {
//                self.createChatThread()
//                print("Thread cannot be found")
//            }
//        }
//    }
    
    func moveToChatListVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let chatList = storyboard.instantiateViewController(withIdentifier: "ChatListVC") as! ChatListVC
        self.navigationController?.pushViewController(chatList, animated: true)
    }
    
}
