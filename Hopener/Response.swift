//
//  Response.swift
//  Hopener
//
//  Created by Damian Nowakowski on 09/05/2017.
//  Copyright © 2017 Damian Nowakowski. All rights reserved.
//

import Foundation
import ObjectMapper

class Response:Mappable {
    
    var message:String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        message <- map["message"]
    }
}


