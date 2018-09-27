//
//  SimplePost.swift
//  SGInstagramDemo
//
//  Created by Sergey Gamayunov on 26/09/2018.
//  Copyright © 2018 Sergey. All rights reserved.
//

import Foundation
import IGListKit

class SimplePost: NSObject {
    let url: URL
    let likes: Int

    init(url: URL, likes: Int) {
        self.url = url
        self.likes = likes
    }
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

extension NSObject: ListDiffable {
    public func diffIdentifier() -> NSObjectProtocol {
        return self
    }

    public func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return isEqual(object)
    }
}
