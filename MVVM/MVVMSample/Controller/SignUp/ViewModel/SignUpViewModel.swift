//
//  SignUpViewModel.swift
//  MVVMSample
//
//  Created by Mapple.pk on 02/03/2022.
//

import Foundation

class SignUpViewModel {
    
    //Variables
    static let share = SignUpViewModel()
    var userDefault = UserDefaults.standard
    var delegate:ResponseDelegate?
    
    // Save user data into Cache
    func saveIntoCache(userData:SignUpModel) {
        userDefault.set(userData.email, forKey: Constant.email)
        userDefault.set(userData.password, forKey: Constant.password)
        userDefault.set(userData.gender, forKey: Constant.gender)
        userDefault.set(userData.address, forKey: Constant.address)
        // Success Callback
        delegate?.success(message: Constant.successMessage)
    }
    
}
