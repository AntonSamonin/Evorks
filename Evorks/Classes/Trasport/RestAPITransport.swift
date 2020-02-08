//
//  RestAPITransport.swift
//  Evorks
//
//  Created by Anton Samonin on 1/31/20.
//  Copyright © 2020 AntonSamonin. All rights reserved.
//

import RxSwift
import Alamofire

class RestAPITransport {
    func callServerApi(requestBody: APIRequestBody) -> Single<Any> {
        return Single.create { single in
            let manager = Alamofire.SessionManager.default
            manager.session.configuration.timeoutIntervalForRequest = 30
            
            let encodedUrl = requestBody.url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
            
            let request = manager.request(encodedUrl,
                                          method: requestBody.method,
                                          parameters: requestBody.parameters,
                                          encoding: requestBody.encoding,
                                          headers: requestBody.headers)
                .validate(statusCode: [200, 201])
                .responseJSON(completionHandler: { response in
                    switch response.result {
                    case .success(let json):
                        single(.success(json))
                    case .failure(_):
                        single(.error((response.response?.statusCode ?? -1) == 401 ? ApiError.unauthorized : ApiError.serverNotAvailable))
                    }
                })
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
}

