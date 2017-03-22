//
//  NetworkManager.swift
//  gipher
//
//  Created by blackbriar on 3/20/17.
//  Copyright © 2017 teressa. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


typealias ServiceResponse2 = ((JSON?, Error?) -> Void)
class NetworkManager_Corrige {
    
    let endPoint = "http://api.giphy.com/v1/gifs/"
    
    let apiKey = "dc6zaTOxFJmzC"
    
    let trending = "trending"
    
    let search = "search"
    
    static let sharedInstance = NetworkManager_Corrige()
    fileprivate init() {}
    
    func getTrending(_ completion: @escaping ServiceResponse2)
    {
        let params = [ "api_key" : apiKey]
        
        Alamofire.request(endPoint+trending, method: .get, parameters: params, encoding: JSONEncoding.default, headers: nil).validate().responseJSON() { response in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print("DATA \(json)")
                    completion(json, nil)
                }
            case .failure(let error):
                print(error)
                completion(nil, error)
            }
        }
    }
    func getInfoWithPath(path: String, completion: @escaping ServiceResponse)
    {
        let headers = [
            "Accept": "application/json"
        ]
        let params = [ "q" : path.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil),
                       "api_key" : apiKey ]
        Alamofire.request(endPoint+search, method: .get, parameters: params, headers: headers).validate().responseJSON() { response in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print("DATA \(json)")
                    completion(json, nil)
                }
            case .failure(let error):
                print(error)
                completion(nil, error)
            }
        }
    }
}




