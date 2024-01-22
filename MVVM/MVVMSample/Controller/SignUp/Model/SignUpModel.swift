//
//  SignUpModel.swift
//  MVVMSample
//
//  Created by Mapple.pk on 02/03/2022.
//

import Foundation

class SignUpModel {
    
    var email:String!
    var password:String!
    var gender:String!
    var address:String!
    
    //MARK: // For create empty object
    init() {}
    
    //MARK: For creating object with values
    init(email:String,password:String,gender:String,address:String) {
        self.email = email
        self.password = password
        self.address = address
        self.gender = gender
    }
    
}
