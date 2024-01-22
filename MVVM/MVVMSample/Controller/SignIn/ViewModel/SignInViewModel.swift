//
//  SignInViewModel.swift
//  MVVMSample
//
//  Created by Mapple.pk on 02/03/2022.
//

import Foundation

class SignInViewModel {
    
    static let share = SignInViewModel()
    var userDefault = UserDefaults.standard
    var delegate:ResponseDelegate?
    
    // Save user data into Cache
    func getFromCache(userData:SignUpModel) {
        
        let email = userDefault.string(forKey: Constant.email)
        let password = userDefault.string(forKey: Constant.password)
        
        if email == userData.email {
            if password == userData.password {
                delegate?.success(message: Constant.loginSuccessMessage)
            } else {
                delegate?.failed(message: Constant.failurTitle)
            }
        } else {
            delegate?.failed(message: Constant.failurTitle)
        }
    }
    
}
