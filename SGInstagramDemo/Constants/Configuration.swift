//
//  Configuration.swift
//  SGInstagramDemo
//
//  Created by Sergey Gamayunov on 25/09/2018.
//  Copyright © 2018 Sergey. All rights reserved.
//

import Foundation

enum Configuration {
    case debug, release

    static var current: Configuration {
        #if DEBUG
        return .debug
        #else
        return .release
        #endif
    }

    var instagramBaseURL: URL {
        return URL(string: "https://api.instagram.com")!
    }

    var instagramClientID: String {
        return "b8f81a4b6c364ab28bdf36d61aa68134"
    }

    var instagramSecretID: String {
        return "ec11573d296c43ebb0443f2c27c8787f"
    }

    var redirectURI: String {
        return "http://localhost:8000"
    }
}
