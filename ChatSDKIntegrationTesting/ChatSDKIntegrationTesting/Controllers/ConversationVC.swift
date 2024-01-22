//
//  ConversationVC.swift
//  ChatSDKIntegrationTesting
//
//  Created by Mapple.pk on 03/08/2023.
//

import UIKit
import ChatSDK

class ConversationVC: UIViewController {
    
    @IBOutlet weak var conversationTable: UITableView!
    @IBOutlet weak var messageField: UITextField!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userActiveStatusLabel: UILabel!
    
    @IBOutlet weak var inputViewBottom: NSLayoutConstraint!
    
    var thread: PThread!
    var messageList: [PMessage] = []
    var chatHandler = ChatSDKHandler.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        addMessageObserver()
        addTapGestureOnView()
        conversationTable.register(UINib(nibName: "TextCell", bundle: nil), forCellReuseIdentifier: "TextCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addKeyboardObserver()
    }
    
    @IBAction func sendMessageBtn(_ sender: UIButton) {
        if let threadId = thread?.entityID() {
            self.chatHandler.threadHandler.sendTextMessage(text: messageField.text!, threadEntityID: threadId)
        } else {
            print("THRESD IS NIL")
        }
    }
    
    @IBAction func assetSelectionBtn(_ sender: UIButton) {
        if let threadId = thread?.entityID() {
            self.chatHandler.sendLocation(threadEntityID: threadId)
        }
    }
    
}


// MARK: ------------------- UITABLEVIEW DATASOURCE AND DELEGATE HANDLING -----------------
extension ConversationVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TextCell") as! TextCell
        cell.config(message: messageList[indexPath.row])
        return cell
    }
    
}



// MARK: ------------------- HANDLING MESSAGES -----------------
extension ConversationVC {
    
    func addMessageObserver() {
        self.chatHandler.addHockForMessages {
            self.messageField.text = ""
            self.fetchData()
            self.scrollToBottom()
        }
    }
    
    func fetchData() {
        self.messageList = self.chatHandler.dbHandler.fetchAllMessages(thread: thread)
        self.userNameLabel.text = self.thread.otherUser().meta()["name"] as? String ?? ""
        self.userActiveStatusLabel.text = "\(String(describing: self.thread.otherUser().online()))"
        self.conversationTable.reloadData()
    }
    
}



// MARK: ------------------- KEYBOARD HANDLING -----------------
extension ConversationVC {
    
    func scrollToBottom() {
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: self.messageList.count - 1, section: 0)
            if indexPath.row >= 0 {
                self.conversationTable.scrollToRow(at: indexPath, at: .bottom, animated: false)
            }
        }
    }
    
    func addTapGestureOnView() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(endEditingHandler))
        tap.numberOfTapsRequired = 1
        view.addGestureRecognizer(tap)
    }
    
    @objc func endEditingHandler(gesture: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    func addKeyboardObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardFrameChange(notification:)), name: UIResponder.keyboardDidChangeFrameNotification, object: nil)
    }
    
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        let keyboardInfo = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        let keyboardSize = keyboardInfo.cgRectValue.size
        
        if keyboardSize.height > 200  && inputViewBottom.constant <= 0 {
            let window = UIApplication.shared.keyWindow
            
            UIView.animate(withDuration: 0.1) {
                
                if let win = window {
                    self.inputViewBottom.constant = (keyboardSize.height) * -1 // -  win.safeAreaInsets.bottom
                }
                self.view.layoutIfNeeded()
                self.scrollToBottom()
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        let keyboardInfo = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        let keyboardSize = keyboardInfo.cgRectValue.size
        
        if keyboardSize.height > 200  && inputViewBottom.constant < 0 {
            
            UIView.animate(withDuration: 0.1) {
                self.inputViewBottom.constant = 0
                self.view.layoutIfNeeded()
            }
        }
    }

    @objc func keyboardFrameChange(notification: NSNotification) {
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        let keyboardInfo = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        let keyboardSize = keyboardInfo.cgRectValue.size

        if keyboardSize.height > 200  && inputViewBottom.constant > 51 {
            let window = UIApplication.shared.keyWindow

            UIView.animate(withDuration: 0.1) {

                if let win = window {
                    self.inputViewBottom.constant = (keyboardSize.height) * -1 // -  win.safeAreaInsets.bottom
                }
                self.view.layoutIfNeeded()
            }
        }
    }
    
}
