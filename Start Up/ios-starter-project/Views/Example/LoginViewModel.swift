//
//  ViewModel.swift
//  ios-starter-project
//
//  Created by Mehtab Ahmed on 27/06/21.
//

import Foundation

class LoginViewModel {
    
    var loginView: LoginView?
    
    init(view: LoginView) {
        loginView = view
    }
    
    func login(email:String , password: String) {
        let params = ["email": email, "password": password] as [String: AnyObject]
        
        NetworkClient.shared.postRequest("https://nukta.ls.codesorbit.net/api/login", parameters: params, headers: [:], completion: { [weak self] (user: User) in
            print(user)
            self?.loginView?.loginSuccess()
        }, failure: { [weak self] (error) in
            print(error)
            self?.loginView?.loginFailure(error: error)
        })
    }
    
}
