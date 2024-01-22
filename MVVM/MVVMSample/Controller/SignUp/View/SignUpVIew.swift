//
//  SignUpVIew.swift
//  MVVMSample
//
//  Created by Mapple.pk on 02/03/2022.
//

import Foundation
import UIKit

public class SignUpView:ResponseDelegate {
    
    //Variable's
    static let share = SignUpView()
    var delegate:ResponseDelegate?
    var signUpViewModel = SignUpViewModel.share
    
    
    func validateFields(emailField:UITextField,passwardField:UITextField,genderField:UITextField,addressField:UITextField) {
        
        guard let email = emailField.text else {
            return
        }
        guard let password = passwardField.text else {
            return
        }
        guard let gender = genderField.text else {
            return
        }
        guard let address = addressField.text else {
            return
        }
        
        // Add into Model
        let userData = SignUpModel(email: email, password: password, gender: gender, address: address)
        signUpViewModel.delegate = self
        signUpViewModel.saveIntoCache(userData: userData)
    }
    
    //DELEGATES METHOD'S
    func success(message: String) {
        delegate?.success(message: message)
    }
    
    func failed(message: String) {
        delegate?.failed(message: message)
    }
    
}
