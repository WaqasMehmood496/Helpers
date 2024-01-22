//
//  FirebaseAuthHelper.swift
//  Firebas-Handling
//
//  Created by Mapple.pk on 01/06/2023.
//

import Foundation
import Firebase

class FirebaseAuthHelper {
    
    static let shared = FirebaseAuthHelper()
    
    var auth: Auth { get { Auth.auth() } }
    
    var verificationId : String {
        get { DataManager.shared.getStringData(key: Keys.firebaseOtpVerificationId.rawValue) }
        set { DataManager.shared.setStringData(value: newValue, key: Keys.firebaseOtpVerificationId.rawValue) }
    }
    
    private init() {}
    
    func getOtpFromFirebase( phoneNumber:String, completion: @escaping (Result<String, Error>) -> Void) {
        if auth.currentUser == nil {
            auth.languageCode = "en"
            PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { [weak self] (verificationID, error) in
                guard let self = self else {
                    completion(.failure(NSError(domain: "Connection Failed", code: 0)))
                    return
                }
                if let error = error {
                    completion(.failure(error))
                    return
                } else {
                    guard let verificationId = verificationID else {
                        completion(.failure(NSError(domain: "Verification id not found", code: 0)))
                        return
                    }
                    self.verificationId = verificationId
                    completion(.success(verificationId))
                }
            }
        } else {
            completion(.failure(NSError(domain: "User Already Login", code: 0)))
        }
    }
    
    func verifyOtp( otp:String, completion: @escaping (Result<String, Error>) -> Void) {
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationId, verificationCode: otp)
        
        auth.signIn(with: credential) { [weak self] (authResult, error) in
            guard let self = self else {
                completion(.failure(NSError(domain: "Connection Failed", code: 0)))
                return
            }
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            print(authResult)
            completion(.success("Successfully Verify"))
        }
    }
    
    func signOutAuthUser( completion: @escaping (Result<String, Error>) -> Void ) {
        do {
            try auth.signOut()
            completion(.success("Signout Sucessfully"))
        } catch let error as NSError {
            completion(.failure(error.localizedDescription as! Error))
            print("Error signing out: %@", error)
        }
    }
    
    func getFirebaseIdToken(completion: @escaping (Result<String, Error>) -> Void) {
        auth.currentUser?.getIDToken(completion: { [weak self] (token, error) in
            guard let self = self else { return }
            if let error = error {
                completion(.failure(error))
                return;
            }
            guard let finalToken = token else { return }
            print("ACCESS TOKEN : \(finalToken)")
            self.verificationId = finalToken
            completion(.success("Successfully get firebase token \(finalToken)"))
        })
    }
    
}
