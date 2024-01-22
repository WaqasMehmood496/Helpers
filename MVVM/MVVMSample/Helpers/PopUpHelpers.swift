//
//  PopUpHelpers.swift
//  MVVMSample
//
//  Created by Mapple.pk on 02/03/2022.
//

import Foundation
import UIKit

class PopupHelper {
        
    static func alertMessage(title: String,message: String,controler:UIViewController){
        let alertController = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        
        let saveAction = UIAlertAction.init(title: "Ok", style: .default) { (alertAction) in
            controler.navigationController?.popViewController(animated: true)
        }
        
        alertController.addAction(saveAction)
        controler.present(alertController, animated: true, completion: nil)

    }
}
