//
//  ViewController.swift
//  Firebas-Handling
//
//  Created by Mapple.pk on 01/06/2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var otpField : UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getOtpCode()
    }

    @IBAction func verifyOtpBtnAction(_ sender: UIButton) {
        FirebaseAuthHelper.shared.verifyOtp(otp: otpField.text!) { result in
            switch result {
            case .success(let response):
                print(response)
                break
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
        }
    }
    
    func getOtpCode() {
        FirebaseAuthHelper.shared.getOtpFromFirebase(phoneNumber: "+923461207787") { result in
            switch result {
            case .success(let varificationId):
                print(varificationId)
                break
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
        }
    }
    
    func getFirebaseIdToken() {
        FirebaseAuthHelper.shared.getFirebaseIdToken { result in
            switch result {
            case .success(let success):
                print(success)
                break
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
        }
    }

}

