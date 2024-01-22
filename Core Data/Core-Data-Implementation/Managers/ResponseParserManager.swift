//
//  ResponseParserManager.swift
//  Core-Data-Implementation
//
//  Created by Mapple.pk on 23/05/2023.
//

import Foundation
import SwiftyJSON

class ParserManager: NSObject {
    
    override init() {}
    
    class func parseResponse<T: Decodable>(response: JSON?, completion: @escaping (T) -> Void, failure: @escaping (String) -> Void) {
        
        if var response = response {
            
            //            if !(response["error"].bool ?? true)  {
            
            //                if response["data"].bool != nil {
            //                    response["data"] = ["data": response["data"].boolValue]
            parseJSON(json: response, completion: completion, failure: failure)
            return
            //                }
            
            //                if T.self is BaseResponse.Type || parseCompleteResponseToRequiredObject {
            //                    parseJSON(json: response, completion: completion, failure: failure)
            //                }
            
            //                if keyPath != "" {
            //                    var json:JSON?
            //                    if keyPath.contains(",") {
            //                        let keyPathComponents = keyPath.components(separatedBy: ",")
            //                        switch keyPathComponents.count {
            //
            //                        case 1:
            //                            json = response["data"][keyPathComponents[0]]
            //                        case 2:
            //                            json = response["data"][keyPathComponents[0]][keyPathComponents[1]]
            //                        case 3:
            //                            json = response["data"][keyPathComponents[0]][keyPathComponents[1]][keyPathComponents[2]]
            //                        case 4:
            //                            json = response["data"][keyPathComponents[0]][keyPathComponents[1]][keyPathComponents[2]][keyPathComponents[3]]
            //                        case 5:
            //                            json = response["data"][keyPathComponents[0]][keyPathComponents[1]][keyPathComponents[2]][keyPathComponents[3]][keyPathComponents[4]]
            //                        default:
            //                            print("Invalid keyPath")
            //                        }
            //                    }
            //                    else {
            //                        json = response["data"][keyPath]
            //                    }
            //
            //                    parseJSON(json: json!, completion: completion, failure: failure)
            //
            //                } else {
            //
            //                    parseJSON(json: response["data"], completion: completion, failure: failure)
            //                }
            
            //            } else {
            //                if response["message"].string == "Unathorized access" {
            //                        NotificationCenter.default.post(name: NSNotification.Name("com.user.login.stopAudio"),object: nil)
            //                        NotificationCenter.default.post(name: NSNotification.Name("com.user.login.removeMiniAudio"),object: nil)
            //                } else {
            //                    failure(response["message"].string ?? "")
            //                }
            //
            //
            //            }
        }
    }
        
    class func parseJSON<T: Decodable>(json:JSON, completion: @escaping (T) -> Void, failure: @escaping (String) -> Void) {
        
        do {
            let jsonString = json.rawString()!
            let data = Data(jsonString.utf8)
            let parsedData = try JSONDecoder().decode(T.self, from: data)
            completion(parsedData)
            //            let data = try json.rawData()
            //            let parsedData = try JSONDecoder().decode(T.self, from: data)
            //            completion(parsedData)
        }
        
        catch DecodingError.keyNotFound(let key, let context) {
            Swift.print("could not find key \(key) in JSON: \(context.debugDescription)")
            failure(Errors.SERIALIZATION_ERROR.rawValue)
        } catch DecodingError.valueNotFound(let type, let context) {
            Swift.print("could not find type \(type) in JSON: \(context.debugDescription)")
            failure(Errors.SERIALIZATION_ERROR.rawValue)
        } catch DecodingError.typeMismatch(let type, let context) {
            Swift.print("type mismatch for type \(type) in JSON: \(context.debugDescription)")
            failure(Errors.SERIALIZATION_ERROR.rawValue)
        } catch DecodingError.dataCorrupted(let context) {
            Swift.print("data found to be corrupted in JSON: \(context.debugDescription)")
            failure(Errors.SERIALIZATION_ERROR.rawValue)
        } catch let error as NSError {
            NSLog("Error in read(from:ofType:) domain= \(error.domain), description= \(error.localizedDescription)")
            failure(Errors.SERIALIZATION_ERROR.rawValue)
        }
    }
}


enum Errors: String {
    case NETWORK_ERROR, SERIALIZATION_ERROR, OTHER
    
    var description: String {
        switch self {
        case .NETWORK_ERROR:
            return "No internet connection!"
        case .SERIALIZATION_ERROR:
            return "Cannot parse data. Data is not in the correct format"
        case .OTHER:
            return "Something went wrong"
        }
    }
}
