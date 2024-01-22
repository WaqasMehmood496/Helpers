//
//  GlobalFunctions.swift
//  ios-starter-project
//
//  Created by CodesOrbit on 28/06/2021.
//

import Foundation
import ObjectMapper
import SwiftyJSON


// pass keyPath to parse a specific object from JSON
func parse<T:Mappable>(json:JSON, keyPath:String = "") -> T {
    if keyPath == "" {
        return Mapper<T>().map(JSONString: json.rawString()!)!
    }
    return Mapper<T>().map(JSONString: json[keyPath].rawString()!)!
}
