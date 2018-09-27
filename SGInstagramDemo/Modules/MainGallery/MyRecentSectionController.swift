//
//  MyRecentSectionController.swift
//  SGInstagramDemo
//
//  Created by Sergey Gamayunov on 27/09/2018.
//  Copyright © 2018 Sergey. All rights reserved.
//

import Foundation
import IGListKit
import Kingfisher

class MyRecentSectionController: ListSectionController {
    var post: SimplePost!
}

extension MyRecentSectionController {
    override func didUpdate(to object: Any) {
        post = object as? SimplePost
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard
            let context = collectionContext,
            let cell = context.dequeueReusableCell(of: PostCell.self, for: self, at: index) as? PostCell,
            let post = post
        else { return UICollectionViewCell() }


        cell.imageView.kf.setImage(with: post.url)
        return cell
    }

    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width / 3, height: 150)
    }
}
