//
//  SignUpVC.swift
//  MVVMSample
//
//  Created by Mapple.pk on 02/03/2022.
//

import UIKit

class SignUpVC: UIViewController {
    
    //MARK: IBOUTLET'S
    @IBOutlet weak var EmailField: UITextField!
    @IBOutlet weak var PasswordField: UITextField!
    @IBOutlet weak var GenderField: UITextField!
    @IBOutlet weak var AddressField: UITextField!
    
    //MARK: VARIABLE'S
    var signUpView = SignUpView()
    
    //MARK: VIEW CONTROLLER LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    //MARK: IBACTION'S
    @IBAction func SignUpAction(_ sender: UIButton) {
        signUpView.validateFields(emailField: EmailField, passwardField: PasswordField, genderField: GenderField, addressField: AddressField)
    }
    
    func setupUI() {
        signUpView.delegate = self
    }
    
}

extension SignUpVC:ResponseDelegate {
    
    func success(message: String) {
        self.performSegue(withIdentifier: "SignInSegue", sender: nil)
    }
    
    func failed(message: String) {
        PopupHelper.alertMessage(title: Constant.failurTitle, message: message, controler: self)
    }
    
}
