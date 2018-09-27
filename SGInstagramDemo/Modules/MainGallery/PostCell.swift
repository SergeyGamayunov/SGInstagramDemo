//
//  PostCell.swift
//  SGInstagramDemo
//
//  Created by Sergey Gamayunov on 27/09/2018.
//  Copyright © 2018 Sergey. All rights reserved.
//

import UIKit

class PostCell: UICollectionViewCell {
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        let width: CGFloat = 100
        imageView.center(in: contentView, width: width, height: width)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
