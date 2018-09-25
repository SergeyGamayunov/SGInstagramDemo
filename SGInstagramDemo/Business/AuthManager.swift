//
//  AuthManager.swift
//  SGInstagramDemo
//
//  Created by Sergey Gamayunov on 24/09/2018.
//  Copyright © 2018 Sergey. All rights reserved.
//

import Foundation
import KeychainAccess
import RxSwift

protocol AuthManagerProtocol {
    var authToken: String? { get }
    var isAuthorized: Bool { get }
    var isAuthorizedObservable: Observable<Bool> { get }
    func login()
}

class AuthManager {
    private let tokenKey = "TokenKey"
    private let keychain = Keychain()
    private lazy var isAuthorizedSubject = BehaviorSubject(value: isAuthorized)

    init() { }
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

    func login() {
        isAuthorizedSubject.onNext(true)
    }

    func logout() {
        isAuthorizedSubject.onNext(false)
    }
}
