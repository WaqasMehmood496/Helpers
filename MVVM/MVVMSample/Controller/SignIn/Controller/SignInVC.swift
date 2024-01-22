//
//  SignInVC.swift
//  MVVMSample
//
//  Created by Mapple.pk on 02/03/2022.
//

import UIKit

class SignInVC: UIViewController {
    
    
    //MARK: IBOUTLET'S
    @IBOutlet weak var EmailField: UITextField!
    @IBOutlet weak var PasswordField: UITextField!
    
    //MARK: VARIABLE'S
    var signInView = SignInView()
    
    //MARK: VIEW CONTROLLER LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    //MARK: IBACTION'S
    @IBAction func SignInBtnAction(_ sender: UIButton) {
        signInView.validateFields(emailField: EmailField, passwardField: PasswordField)
    }
    
    func setupUI() {
        signInView.delegate = self
    }
    
}


extension SignInVC: ResponseDelegate {
    
    func success(message: String) {
        PopupHelper.alertMessage(title: Constant.successTitle, message: message, controler: self)
    }
    
    func failed(message: String) {
        PopupHelper.alertMessage(title: Constant.failurTitle, message: message, controler: self)
    }
    
}
