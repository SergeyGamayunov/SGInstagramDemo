//
//  AuthViewModel.swift
//  SGInstagramDemo
//
//  Created by Sergey Gamayunov on 24/09/2018.
//  Copyright © 2018 Sergey. All rights reserved.
//

import Foundation

protocol AuthViewModelProtocol {
    var firstStepRequest: URLRequest? { get }
    func requestToken(with code: String)
}

class AuthViewModel {
    let authManager: AuthManagerProtocol
    init(authManager: AuthManagerProtocol) {
        self.authManager = authManager
    }
}

extension AuthViewModel: AuthViewModelProtocol {
    var firstStepRequest: URLRequest? {
        return authManager.firstStepRequest
    }

    func requestToken(with code: String) {
        authManager.requestToken(with: code)
    }
}
