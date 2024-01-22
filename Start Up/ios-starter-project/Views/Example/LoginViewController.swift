
//  LoginViewController.swift
//  ios-starter-project
//
//  Created by Mehtab Ahmed on 26/06/21.
//

import UIKit

 /*******************************************************************
 Example viewController to show how to use networking in the project.
 Just pass required model object or array in completion and wrapper will do all the work for you.
 ********************************************************************/

class LoginViewController: UIViewController, LoginView {
    
    var loginViewModel: LoginViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        loginViewModel = LoginViewModel(view: self)
        loginViewModel?.login(email: "storeowner@mail.com", password: "password")
    }

    // Mark:- LoginView methods
    func loginSuccess() {
        print("Login successful")
    }
    
    
    func loginFailure(error: String) {
        print("Login error: \(error)")
    }
}

