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

    var isWrappedIntoNavigationController: Bool {
        switch self {
        case .auth:
            return false
        case .mainGallery:
            return true
        }
    }

    func controller(in container: DependencyContainer) -> UIViewController {
        do {
            let controller = try container.resolve(tag: self) as UIViewController
            if isWrappedIntoNavigationController {
                return UINavigationController(rootViewController: controller)
            }
            return controller
        } catch {
            fatalError("Error resolving DI Container controller")
        }
    }
}
