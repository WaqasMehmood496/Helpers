//
//  User.swift
//  ios-starter-project
//
//  Created by Mehtab Ahmed on 27/06/21.
//

import Foundation
import ObjectMapper

class User:Codable {
  
    var id : Int?
    var name : String?
    var email : String?
    var email_verified_at : String?
    var pin : Int?
    var pin_status : Int?
    var role : String?
    var owner_full_name : String?
    var phone_number : String?
    var industry : String?
    var bussiness_legal_name : String?
    var commercial_registration_number : String?
    var city : String?
    var address : String?
    var status : String?
    var permission_id : String?
    var branch_id : Int?
    var created_at : String?
    var updated_at : String?
}
