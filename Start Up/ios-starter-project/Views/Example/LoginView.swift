//
//  LoginView.swift
//  ios-starter-project
//
//  Created by Mehtab Ahmed on 21/10/2021.
//

import Foundation

protocol LoginView {
    func loginSuccess()
    func loginFailure(error:String)
}
