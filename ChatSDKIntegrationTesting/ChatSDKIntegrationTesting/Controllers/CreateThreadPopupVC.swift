//
//  CreateThreadPopupVC.swift
//  ChatSDKIntegrationTesting
//
//  Created by Mapple.pk on 01/08/2023.
//

import UIKit

protocol CreatePopupResponder: NSObject {
    func selectedUserId(userId:String)
}

struct userModel {
    
    var userId: String
    var userName: String
    
    init(userId: String, userName: String) {
        self.userId = userId
        self.userName = userName
    }
}

class CreateThreadPopupVC: UIViewController {
    
    // UICOMPONENT'S
    @IBOutlet weak var userListTable: UITableView!
    
    var chatHandler = ChatSDKHandler.shared
    
    var userList: [userModel] = [
        userModel(userId: "j85ga4ZszEO6c8L9Vn8sAFBXxhm1", userName: "Waqas"),
        userModel(userId: "ljjYFfWNMrZRRtCoS2hevIk73yX2", userName: "Waqas1"),
        userModel(userId: "jC8a1NDSFXMInfl5JX0sFhkfjLG2", userName: "Waqas555"),
        userModel(userId: "O2UEKFD7mtRSwPvj5Zsb8nP3oIk1", userName: "Malik"),
        userModel(userId: "47RnS33eGwMd0Cs6vzMEiWgkLk43", userName: "Malik123"),
        userModel(userId: "a0egIXCfy0PawrCPFVqSBuOUx9u2", userName: "fatima"),
        userModel(userId: "5i9OT1mAiMUnwlqBFe1inC6Ex063", userName: "fatima1"),
        userModel(userId: "Mc0eCUkPQOdnR6quoaJEie2jyun2", userName: "tatheer"),
        userModel(userId: "IkNiOnAKcLRWFefJk3gpczNGxV72", userName: "tatheerf10"),
        userModel(userId: "LeDDbmo29HZm1LxLsbVomefXgfg1", userName: "test11"),
        userModel(userId: "DKN3wM4BMCYWpGuzPsoOiRNPdRh2", userName: "tatheerf2"),
        userModel(userId: "K9B5IjggPdQtQMDjzJ8MtBrGkr83", userName: "tatheerf12"),
        userModel(userId: "Uuh1NrNrYGgy0n81HSba52ZGiGG3", userName: "+923045947386"),
        userModel(userId: "0pgkwtfC9xYNbYM9tsXOJ8qhtPZ2", userName: "+923318983086"),
        userModel(userId: "5YjCyEUeFdZH8xUyy8Dm8yinnO33", userName: "tatheerf42"),
        userModel(userId: "iJzD4zD1U1YjwvA1n1WoyNvUA133", userName: "tatheerf26")
    ]
    weak var delegate:CreatePopupResponder?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userListTable.register(UINib(nibName: "UserListCell", bundle: nil), forCellReuseIdentifier: "UserListCell")
    }
}

extension CreateThreadPopupVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserListCell", for: indexPath) as! UserListCell
        cell.config(user: userList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.selectedUserId(userId: userList[indexPath.row].userId)
        self.navigationController?.popViewController(animated: true)
    }
    
}

// MARK: ----------------- CHAT SDK MESSAGES ---------------
extension CreateThreadPopupVC {
    
    //    func fetchAllUsersList() {
    //        print(ChatSDKHandler.shared.fetchAllUsersList())
    //    }
    
    
    //
}
