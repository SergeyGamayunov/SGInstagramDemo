//
//  AuthViewModel.swift
//  SGInstagramDemo
//
//  Created by Sergey Gamayunov on 24/09/2018.
//  Copyright © 2018 Sergey. All rights reserved.
//

import Foundation

protocol AuthViewModelProtocol {
    var authManager: AuthManagerProtocol { get }
}

class AuthViewModel {
    let authManager: AuthManagerProtocol
    init(authManager: AuthManagerProtocol) {
        self.authManager = authManager
    }
}

extension AuthViewModel: AuthViewModelProtocol {
    
}
