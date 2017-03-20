//
//  NetworManager.swift
//  Gipher
//
//  Created by etudiant-06 on 20/03/2017.
//  Copyright © 2017 Mehdi Chennoufi. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

// Singleton pour l'appel réseau

typealias ServiceResponse = ((JSON?, Error?) -> Void)

class NetworkManager {
    let endPoint = "http://api.giphy.com/v1/gifs/trending?api_key=dc6zaTOxFJmzC"
    
    static let sharedInstance = NetworkManager()
    fileprivate init() {}
    
    func getInfo(_ completion: @escaping ServiceResponse) {
        Alamofire.request(endPoint).validate().responseJSON { (response) in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    completion(json, nil)
                }
            case .failure(let error):
                print(error)
                completion(nil, error)
            }
        }
    }
}
