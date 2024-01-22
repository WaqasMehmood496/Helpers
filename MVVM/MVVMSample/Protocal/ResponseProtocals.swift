//
//  ResponseProtocals.swift
//  MVVMSample
//
//  Created by Mapple.pk on 02/03/2022.
//

import Foundation

protocol ResponseDelegate {
    func success(message:String)
    func failed(message:String)
}
