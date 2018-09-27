//
//  SGColor.swift
//  SGInstagramDemo
//
//  Created by Sergey Gamayunov on 27/09/2018.
//  Copyright © 2018 Sergey. All rights reserved.
//

import UIKit

enum SGColor {
    static let brand = UIColor(red: 52, green: 52, blue: 62)
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int, transp: CGFloat = 1.0) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: transp
        )
    }
}
