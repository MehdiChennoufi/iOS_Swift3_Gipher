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
    
    //MARK: - CONSTANTES
    let endPoint = "http://api.giphy.com/v1/gifs/"
    let apiKey = "dc6zaTOxFJmzC"
    let trending = "trending"
    let search = "search"
    
    
    // -----
    static let sharedInstance = NetworkManager()
    fileprivate init() {}
    
    //MARK: - FONCTIONS
    
    // Premier appel - normal
    func getInfo(_ completion: @escaping ServiceResponse) {
        
        let params = ["api_key" : apiKey]
        
        Alamofire.request(endPoint+trending, method: .get, parameters: params, headers: nil).validate().responseJSON() { (response) in
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
    
    // Second appel - avec des params
    // Dès lors que j'utilise un paramètre "completion" il doit se trouver en dernier paramètre
    func getInfoWithPath(path: String, completion: @escaping ServiceResponse) {
        
        let headers = ["Accept": "application/json"]
        let params = ["q" : path.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil), "api_key" : apiKey ]
        
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
