//
//  SignInView.swift
//  MVVMSample
//
//  Created by Mapple.pk on 02/03/2022.
//

import Foundation
import UIKit

class SignInView:ResponseDelegate {
    
    static let share = SignUpView()
        var delegate:ResponseDelegate?
        var signInViewModel = SignInViewModel.share
    
    func validateFields(emailField:UITextField,passwardField:UITextField) {
        
        guard let email = emailField.text else {
            return
        }
        guard let password = passwardField.text else {
            return
        }
        
        // Add into Model
        let userData = SignUpModel(email: email, password: password, gender: "", address: "")
        signInViewModel.delegate = self
        signInViewModel.getFromCache(userData: userData)
    }
    
    func success(message: String) {
        delegate?.success(message: message)
    }
    
    func failed(message: String) {
        delegate?.failed(message: message)
    }
    
}
