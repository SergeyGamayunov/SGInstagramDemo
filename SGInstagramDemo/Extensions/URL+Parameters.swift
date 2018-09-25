//
//  URL+Parameters.swift
//  SGInstagramDemo
//
//  Created by Sergey Gamayunov on 25/09/2018.
//  Copyright © 2018 Sergey. All rights reserved.
//

import Foundation

extension URL {
    var queryParameters: [String: String] {
        var parameters = [String: String]()
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: true), let queryItems = components.queryItems else {
            return parameters
        }

        for item in queryItems {
            parameters[item.name] = item.value
        }

        return parameters
    }
}
