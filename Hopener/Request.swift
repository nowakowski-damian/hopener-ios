//
//  Request.swift
//  Hopener
//
//  Created by Damian Nowakowski on 09/05/2017.
//  Copyright © 2017 Damian Nowakowski. All rights reserved.
//

import Foundation
import ObjectMapper

class Request:Mappable {
    
    enum Device {
        case garage
        case fence
        
        func name() -> String {
            switch self {
            case .garage:
                return "garage"
            case .fence:
                return "fence"
            }
        }
    }
    
    enum Activity {
        case open
        case pause
        case close
        
        func name() -> String {
            switch self {
            case .open:
                return "open"
            case .pause:
                return "stop"
            case .close:
                return "close"
            }
        }
        
    }
    
    var uuid:String?
    var device:String?
    var activity:String?
    
    required init?(map: Map) {
    
    }
    
    required init(uuid:String, device: Device, activity: Activity) {
        self.uuid = uuid
        self.device = device.name()
        self.activity = activity.name()
    }
    
    func mapping(map: Map) {
        uuid <- map["uuid"]
        device <- map["device"]
        activity <- map["activity"]
    }
    
}


