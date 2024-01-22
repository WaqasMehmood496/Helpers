//
//  NetworkManager.swift
//  ios-starter-project
//
//  Created by Mehtab Ahmed on 26/06/21.
//

import Foundation
import AlamofireObjectMapper
import Alamofire
import UIKit
import SwiftyJSON

class NetworkManager: SessionManager {
    
    
    // MARK: - Public methods
    func getRequest(_ url: String, parameters: [String : AnyObject]?, headers: [String : String]?, completion: @escaping (JSON?) -> Void ) {
        
        Alamofire.request(url, method: .get , parameters: parameters, encoding: URLEncoding.default, headers: headers).responseJSON { response in
            self.handleResponse(response: response, completion: completion)
        }
    }
    
    
    func postRequest(_ url: String, parameters: [String : AnyObject]?, headers: [String : String]?, completion: @escaping (JSON?) -> Void) {
        
        Alamofire.request(url, method: .post , parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { response in
                self.handleResponse(response: response, completion: completion)
        }
    }
    
    
    func multipartRequest(_ url: String, parameters: [String : AnyObject]?, headers: [String : String]?, completion: @escaping (JSON?) -> Void, failure: @escaping (String) -> Void) {

        var parameters = parameters

        Alamofire.upload(multipartFormData: { (multipartFormData) in

            for (key, value) in parameters ?? [:] {

                if key == "image" {

                    let image = value as! UIImage
                    let data = image.jpeg(.lowest)
                    multipartFormData.append(data!, withName: "image", fileName: "profilePicture.jpeg", mimeType: "image/jpeg")
                    parameters?.removeValue(forKey: "image")

                } else if key == "images" {

                    let images = value as! [UIImage]
                    for image in images {
                        let data = image.jpeg(.lowest)
                        multipartFormData.append(data!, withName: "images", fileName: "profilePicture.jpeg", mimeType: "image/jpeg")
                    }
                    parameters?.removeValue(forKey: "images")
                }
                else {
                    multipartFormData.append(String(describing: value).data(using: .utf8)!, withName: key)
                }
            }

        }, usingThreshold: 0, to: url, method: .post, headers: headers, encodingCompletion: { (encodingResult) in

            switch encodingResult {

            case .success(let upload, _ , _):
                upload.uploadProgress(closure: { (progress) in
                    print(progress)
                })

                upload.responseJSON { response in
                    self.handleResponse(response: response, completion: completion)

                }
            case .failure(let error):
                failure(error.localizedDescription)
                break
            }
        })
    }

    
    
    func handleResponse(response: DataResponse<Any>, completion: @escaping (JSON?) -> Void) {

        switch response.result {
        case .success:
            self.showRequestDetailForSuccess(responseObject: response)
            completion(JSON(response.result.value!))
            break

        case .failure:
            self.showRequestDetailForFailure(responseObject: response)
            completion(JSON(response.result.value!))
            break
        }
    }


    func showRequestDetailForSuccess(responseObject response : DataResponse<Any>) {

        print("\n\n\n ✅ ✅ ✅ ✅ ✅  ------- Success Response Start -------  ✅ ✅ ✅ ✅ ✅ \n")
        print(""+(response.request?.url?.absoluteString ?? ""))
        print("\n=========   allHTTPHeaderFields   ========== \n")
        print("%@",response.request!.allHTTPHeaderFields!)

        if let bodyData : Data = response.request?.httpBody
        {
            let bodyString = String(data: bodyData, encoding: String.Encoding.utf8)
            print("\n=========   Request httpBody   ========== \n" + bodyString!)

        } else {
            print("\n=========   Request httpBody   ========== \n" + "Found Request Body Nil")
        }

        if let responseData : Data = response.data {
            let responseString = String(data: responseData, encoding: String.Encoding.utf8)
            print("\n=========   Response Body   ========== \n" + responseString!)

        } else {
            print("\n=========   Response Body   ========== \n" + "Found Response Body Nil")
        }

        print("\n\n\n ✅ ✅ ✅  ------- Success Response End -------  ✅ ✅ ✅ \n\n\n")

    }


    func showRequestDetailForFailure(responseObject response : DataResponse<Any>) {

        print("\n\n\n ❌ ❌ ❌ ❌ ❌ ------- Failure Response Start ------- ❌ ❌ ❌ ❌ ❌ \n")
        print(""+(response.request?.url?.absoluteString ?? ""))
        print("\n=========   allHTTPHeaderFields   ========== \n")
        print("%@",response.request!.allHTTPHeaderFields!)

        if let bodyData : Data = response.request?.httpBody {
            let bodyString = String(data: bodyData, encoding: String.Encoding.utf8)
            print("\n=========   Request httpBody   ========== \n" + bodyString!)

        } else {
            print("\n=========   Request httpBody   ========== \n" + "Found Request Body Nil")
        }

        if let responseData : Data = response.data {
            let responseString = String(data: responseData, encoding: String.Encoding.utf8)
            print("\n=========   Response Body   ========== \n" + responseString!)

        } else {
            print("\n=========   Response Body   ========== \n" + "Found Response Body Nil")
        }

        print("\n\n\n ❌ ❌ ❌ ------- Failure Response End ------- ❌ ❌ ❌ \n")

    }
}

