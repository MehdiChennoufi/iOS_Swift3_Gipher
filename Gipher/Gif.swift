//
//  Gif.swift
//  Gipher
//
//  Created by etudiant-06 on 20/03/2017.
//  Copyright © 2017 Mehdi Chennoufi. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct Gif {
    var slug: String
    var link: String
    var rating: String
    
    init(json: JSON) {
        self.slug = json["slug"].stringValue
        self.link = json["images"]["original"]["url"].stringValue
        self.rating = json["rating"].stringValue
    }
    
}
