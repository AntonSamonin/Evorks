//
//  SignInRequest.swift
//  Evorks
//
//  Created by Anton Samonin on 3/30/20.
//  Copyright © 2020 AntonSamonin. All rights reserved.
//

import Alamofire

struct SignInRequest: APIRequestBody {
    private let username: String
    private let password: String
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
    
    var url: String {
        return GlobalDefinitions.domainUrl + "/auth-api/signin"
    }
    
    var method: HTTPMethod {
        return .post
    }
    
    var parameters: Parameters? {
        return [
            "username": username,
            "password": password
        ]
    }
    
    var headers: [String : String]? {
        return [
            "Accept": "*/*"
        ]
    }
}

