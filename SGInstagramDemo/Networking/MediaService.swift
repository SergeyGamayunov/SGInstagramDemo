//
//  MediaService.swift
//  SGInstagramDemo
//
//  Created by Sergey Gamayunov on 26/09/2018.
//  Copyright © 2018 Sergey. All rights reserved.
//

import Foundation
import Moya
import Result

typealias MyRecentMediaCompletion = (Result<UserData, MoyaError>) -> Void

protocol MediaServiceProtocol {
    func getMyRecentMedia(completion: @escaping MyRecentMediaCompletion)
}

class MediaService {
    let provider: SGProvider
    init(provider: SGProvider) {
        self.provider = provider
    }
}

extension MediaService: MediaServiceProtocol {
    func getMyRecentMedia(completion: @escaping MyRecentMediaCompletion) {
        let target = SGTarget.myRecent

        provider.request(target) { result in
            switch result {
            case .success(let response):
                if let userData = try? JSONDecoder().decode(UserData.self, from: response.data) {
                    completion(Result.success(userData))
                } else {
                    let parseError = MoyaError.objectMapping(NSError(), response)
                    completion(Result.failure(parseError))
                }
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
    }
}
