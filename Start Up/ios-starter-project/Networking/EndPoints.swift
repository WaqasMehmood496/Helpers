//
//  EndPoints.swift
//  ios-starter-project
//
//  Created by Mehtab Ahmed on 26/06/21.
//

import Foundation

class EndPoints {
    public static let BASE_URL = "https://aussiecamp.ls.codesorbit.net/api/v1"
    public static let loginUrl = BASE_URL + "/login"
    public static let logoutUrl = BASE_URL + "/logout"
    public static let signupUrl = BASE_URL + "/register"
    public static let approveUserUrl = BASE_URL + "/approve-user"
    public static let forgetUrl = BASE_URL + "/reset-password"
    public static let currentUserUrl = BASE_URL + "/current-user"
    public static let changePasswordUrl = BASE_URL + "/change-password"
    
    //public static let forgetUrl = BASE_URL + "/reset-password"
    public static let updateProfileUrl = BASE_URL + "/update-profile"
}
