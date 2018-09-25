//
//  AuthManager.swift
//  SGInstagramDemo
//
//  Created by Sergey Gamayunov on 24/09/2018.
//  Copyright © 2018 Sergey. All rights reserved.
//

import Foundation
import KeychainAccess
import Moya
import RxSwift

protocol AuthManagerProtocol {
    var authToken: String? { get }
    var isAuthorized: Bool { get }
    var isAuthorizedObservable: Observable<Bool> { get }
    func save(token: String)


    var firstStepRequest: URLRequest? { get }
    func requestToken(with code: String)
}

class AuthManager {
    private let tokenKey = "TokenKey"
    private let keychain = Keychain()
    private lazy var isAuthorizedSubject = BehaviorSubject(value: isAuthorized)

    let provider: SGProvider
    init(provider: SGProvider) {
        self.provider = provider
    }
}

extension AuthManager: AuthManagerProtocol {
    var authToken: String? {
        return keychain[tokenKey]
    }

    var isAuthorized: Bool {
        return authToken != nil
    }

    var isAuthorizedObservable: Observable<Bool> {
        return self.isAuthorizedSubject.asObservable()
    }

    var firstStepRequest: URLRequest? {
        return try? SGProvider.defaultEndpointMapping(for: .auth).urlRequest()
    }

    func save(token: String) {
        keychain[tokenKey] = token
    }

    func requestToken(with code: String) {
        let target = SGTarget.requestToken(code: code)
        provider.request(target) { result in
            switch result {
            case .success(let response):
                if let json = try? response.mapJSON(),
                    let dict = json as? [String: Any],
                    let token = dict["access_token"] as? String
                {
                    self.save(token: token)
                    self.isAuthorizedSubject.onNext(true)
                }
            case .failure(let error):
                self.isAuthorizedSubject.onNext(false)
            }
        }
    }
}
