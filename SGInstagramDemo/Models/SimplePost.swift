//
//  SimplePost.swift
//  SGInstagramDemo
//
//  Created by Sergey Gamayunov on 26/09/2018.
//  Copyright © 2018 Sergey. All rights reserved.
//

import Foundation

struct SimplePost {
    let url: URL
    let likes: Int
}

extension SimplePost {
    static func initArrayFrom(_ userData: UserData) -> [SimplePost] {
        var result = [SimplePost]()
        for data in userData.data {
            if let url = URL(string: data.images.standardResolution.url) {
                let post = SimplePost(url: url, likes: data.likes.count)
                result.append(post)
            }
        }

        return result
    }
}
