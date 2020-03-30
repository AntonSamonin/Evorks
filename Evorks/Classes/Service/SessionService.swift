//
//  SessionService.swift
//  Evorks
//
//  Created by Anton Samonin on 1/31/20.
//  Copyright © 2020 AntonSamonin. All rights reserved.
//

import RxSwift

struct SessionMeta: Model {
    let accessToken: String
    let accessTokenType: String
    
    enum MetaKeys: String, CodingKey {
        case accessToken = "token"
        case accessTokenType = "type"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MetaKeys.self)
        
        accessToken = try container.decode(String.self, forKey: .accessToken)
        accessTokenType = try container.decode(String.self, forKey: .accessTokenType)
    }
}

class SessionService {
    
    private static let accessTokenKey = "access_token_key"
    private static let accessTokenTypeKey = "access_token_type_key"
    
    static var accessToken: String? {
        return UserDefaults.standard.string(forKey: accessTokenKey)
    }
    
    static var accessTokenType: String? {
        return UserDefaults.standard.string(forKey: SessionService.accessTokenTypeKey)
    }
    
    static var cookies: [HTTPCookie]? {
        guard let cookies = HTTPCookieStorage.shared.cookies(for: URL(string: GlobalDefinitions.domainUrl)!) else { return nil }
        return cookies
    }
    
    static func signUp(phoneNumber: String) -> Single<Void> {
        let request = SignUpRequest(phoneNumber: phoneNumber)

        return RestAPITransport()
            .callServerApi(requestBody: request)
            .map { SessionMeta.parseFromDictionary(any: $0) }
            .map { sessionMeta -> SessionMeta in
                guard let meta = sessionMeta else {
                    throw SignError.unknown
                }

                return meta
            }
            .map { _ -> Void in Void() }
    }
    
    static func signIn(username: String, password: String) -> Single<Void> {
        let request = SignInRequest(username: username, password: password)

        return RestAPITransport()
            .callServerApi(requestBody: request)
            .map { SessionMeta.parseFromDictionary(any: $0) }
            .map { sessionMeta -> SessionMeta in
                guard let meta = sessionMeta else {
                    throw SignError.unknown
                }
                return meta
            }.do(onSuccess: { sessionMeta in
                UserDefaults.standard.set(sessionMeta.accessToken, forKey: SessionService.accessTokenKey)
                UserDefaults.standard.set(sessionMeta.accessTokenType, forKey: SessionService.accessTokenTypeKey)
            })
            .map { _ -> Void in Void() }
    }
}
