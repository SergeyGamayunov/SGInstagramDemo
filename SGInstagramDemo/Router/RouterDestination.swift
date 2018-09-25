//
//  RouterDestination.swift
//  SGInstagramDemo
//
//  Created by Sergey Gamayunov on 24/09/2018.
//  Copyright © 2018 Sergey. All rights reserved.
//

import Dip
import UIKit

enum RouterDestination: String, DependencyTagConvertible {
    case auth
    case mainGallery

    func controller(in container: DependencyContainer) -> UIViewController {
        do {
            return try container.resolve(tag: self)
        } catch {
            fatalError("Error resolving DI Container controller")
        }
    }
}
