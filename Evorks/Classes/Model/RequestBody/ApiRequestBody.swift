//
//  ApiRequestBody.swift
//  Evorks
//
//  Created by Anton Samonin on 1/31/20.
//  Copyright © 2020 AntonSamonin. All rights reserved.
//

import Alamofire

protocol APIRequestBody {
    var url: String { get }
    var method: HTTPMethod { get }
    var parameters: Parameters? { get }
    var headers: [String: String]? { get }
    var encoding: ParameterEncoding { get }
    var cookies: [HTTPCookie] { get }
}

extension APIRequestBody {
    var url: String {
        return ""
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameters: Parameters? {
        return nil
    }
    
    var headers: [String: String]? {
        return nil
    }
    
    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    var cookies: [HTTPCookie] {
        return []
    }
}
