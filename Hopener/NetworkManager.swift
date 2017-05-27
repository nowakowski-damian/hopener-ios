//
//  NetworkManager.swift
//  Hopener
//
//  Created by Damian Nowakowski on 09/05/2017.
//  Copyright © 2017 Damian Nowakowski. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class NetworkManager {
    
    static let shared = NetworkManager()
    
    static let server = "https://1.1.1.1"
    static let endpoint = "/hopener/api/RestController.php"
    let url:String
    
    init() {
        url = NetworkManager.server + NetworkManager.endpoint
    }
    
    
    let Manager: Alamofire.SessionManager = {
        
        let serverTrustPolicies: [String: ServerTrustPolicy] = [
            "1.1.1.1": .pinCertificates(
                certificates: ServerTrustPolicy.certificates(),
                validateCertificateChain: true,
                validateHost: true
            )]
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        
        return Alamofire.SessionManager(
            configuration: configuration,
            serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
        )
    }()
    
    func makeRequest(request:Request,callback: @escaping (Int, Response) -> Void)  {
        Manager
            .request( url, method: .post, parameters: request.toJSON(), encoding: JSONEncoding.default, headers: ["Content-Type":"application/json"])
            .responseObject{ (response: DataResponse<Response>) in
                
                if let code = response.response?.statusCode, let response = response.result.value  {
                    callback(code,response)
                }
                else {
                    print(response)
                }
        }
    }
    
    
    

}
