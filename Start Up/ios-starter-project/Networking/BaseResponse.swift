//
//  BaseResponse.swift
//  ios-starter-project
//
//  Created by Mehtab Ahmed on 26/06/21.
//

import Foundation
import SwiftyJSON

/*******************************************************************
 Base response according to specific APIs format. If format changes then have to update this class accordingly
********************************************************************/

struct BaseResponse: Codable {
    
    var error = false
    var message = ""
    var data: JSON?
    
    enum CodingKeys: String, CodingKey {
        
        case error = "error"
        case message = "message"
        case data = "data"
    }
}
