//
//  SessionService.swift
//  Evorks
//
//  Created by Anton Samonin on 1/31/20.
//  Copyright © 2020 AntonSamonin. All rights reserved.
//

import RxSwift

struct SessionMeta: Model {
    let userId: Int
    let accessToken: String
    let accessTokenType: String
    
    enum ContentKey: CodingKey {
        case result
    }
    
    enum Keys: CodingKey {
        case data
        case meta
    }
    
    enum UserKeys: String, CodingKey {
        case userId = "id"
    }
    
    enum MetaKeys: String, CodingKey {
        case accessToken = "access_token"
        case accessTokenType = "token_type"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ContentKey.self)
        let result = try container.nestedContainer(keyedBy: Keys.self, forKey: .result)
        let data = try result.nestedContainer(keyedBy: UserKeys.self, forKey: .data)
        let meta = try result.nestedContainer(keyedBy: MetaKeys.self, forKey: .meta)
        
        userId = try data.decode(Int.self, forKey: .userId)
        accessToken = try meta.decode(String.self, forKey: .accessToken)
        accessTokenType = try meta.decode(String.self, forKey: .accessTokenType)
    }
}

class SessionService {
    
    private static let userIdKey = "user_id_key"
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
}
