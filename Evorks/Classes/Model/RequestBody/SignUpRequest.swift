//
//  SignUpRequest.swift
//  Evorks
//
//  Created by Anton Samonin on 3/11/20.
//  Copyright © 2020 AntonSamonin. All rights reserved.
//

import Alamofire

struct SignUpRequest: APIRequestBody {
    private let phoneNumber: String
    
    init(phoneNumber: String) {
        self.phoneNumber = phoneNumber
    }
    
    var url: String {
        return GlobalDefinitions.domainUrl + "/api/evorker"
    }
    
    var method: HTTPMethod {
        return .post
    }
    
    var parameters: Parameters? {
        return [
            "phone": "8\(phoneNumber)"
        ]
    }
    
    var headers: [String : String]? {
        return [
            "Accept": "*/*"
        ]
    }
}
