//
//  UIView+Layout.swift
//  SGInstagramDemo
//
//  Created by Sergey Gamayunov on 25/09/2018.
//  Copyright © 2018 Sergey. All rights reserved.
//

import UIKit

extension UIView {
    func addAndFitEdges(to superview: UIView, andBindWith insets: UIEdgeInsets = UIEdgeInsets.zero) {
        translatesAutoresizingMaskIntoConstraints = false
        superview.addSubview(self)

        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor, constant: insets.top),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -insets.bottom),
            leftAnchor.constraint(equalTo: superview.leftAnchor, constant: insets.left),
            rightAnchor.constraint(equalTo: superview.rightAnchor, constant: -insets.right),
        ])
    }

    func center(in superview: UIView, width: CGFloat, height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        superview.addSubview(self)

        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: superview.centerXAnchor),
            centerYAnchor.constraint(equalTo: superview.centerYAnchor),
            widthAnchor.constraint(equalToConstant: width),
            heightAnchor.constraint(equalToConstant: height)
        ])
    }
}
