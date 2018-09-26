//
//  SGTarget.swift
//  SGInstagramDemo
//
//  Created by Sergey Gamayunov on 25/09/2018.
//  Copyright © 2018 Sergey. All rights reserved.
//

import Foundation
import Moya

typealias SGProvider = MoyaProvider<SGTarget>

enum SGTarget {
    case auth
    case requestToken(code: String)
    case myRecent
}

extension SGTarget: TargetType {
    var baseURL: URL {
        return Configuration.current.instagramBaseURL
    }

    var path: String {
        switch self {
        case .auth:
            return "oauth/authorize/"
        case .requestToken:
            return "oauth/access_token/"
        case .myRecent:
            return "v1/users/self/media/recent/"
        }
    }

    var method: Moya.Method {
        switch self {
        case .auth, .myRecent:
            return .get
        case .requestToken:
            return .post
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case .auth:
            let parameters = [
                ParamaterKey.clientID: Configuration.current.instagramClientID,
                ParamaterKey.redirectURI: Configuration.current.redirectURI,
                ParamaterKey.responseType: "code"
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding())

        case let .requestToken(code: code):
            var parameters = [MultipartFormData]()
            parameters.appendParam(Configuration.current.instagramClientID, name: ParamaterKey.clientID)
            parameters.appendParam(Configuration.current.instagramSecretID, name: ParamaterKey.secretID)
            parameters.appendParam(Configuration.current.redirectURI, name: ParamaterKey.redirectURI)
            parameters.appendParam(code, name: ParamaterKey.code)
            parameters.appendParam("authorization_code", name: ParamaterKey.grantType)

            return .uploadMultipart(parameters)

        case .myRecent:
            return .requestParameters(parameters: [:], encoding: URLEncoding())
        }
    }

    var headers: [String : String]? {
        if case .requestToken = self {
            return ["Content-Type": "application/x-www-form-urlencoded"]
        }

        return nil
    }

    enum ParamaterKey {
        static let clientID = "client_id"
        static let secretID = "client_secret"
        static let grantType = "grant_type"
        static let redirectURI = "redirect_uri"
        static let responseType = "response_type"
        static let accessToken = "access_token"
        static let code = "code"
    }
}

extension Array where Element == MultipartFormData {
    mutating func appendParam<T: LosslessStringConvertible>(_ element: T?, name: String) {
        if let element = element, let data = String(element).data(using: .utf8) {
            append(MultipartFormData(provider: .data(data), name: name))
        }
    }
}
