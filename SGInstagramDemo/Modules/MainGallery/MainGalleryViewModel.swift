//
//  MainGalleryViewModel.swift
//  SGInstagramDemo
//
//  Created by Sergey Gamayunov on 24/09/2018.
//  Copyright © 2018 Sergey. All rights reserved.
//

import Foundation

protocol MainGalleryViewModelProtocol {
    func logout()
    func getMyRecentMedia(completion: @escaping MyRecentMediaCompletion)
}

class MainGalleryViewModel {
    let authManager: AuthManagerProtocol
    let mediaService: MediaServiceProtocol
    init(authManager: AuthManagerProtocol, mediaService: MediaServiceProtocol) {
        self.authManager = authManager
        self.mediaService = mediaService
    }
}

extension MainGalleryViewModel: MainGalleryViewModelProtocol {
    func logout() {
        authManager.logout()
    }

    func getMyRecentMedia(completion: @escaping MyRecentMediaCompletion) {
        mediaService.getMyRecentMedia(completion: completion)
    }
}
