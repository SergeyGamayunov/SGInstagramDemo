//
//  Containers.swift
//  SGInstagramDemo
//
//  Created by Sergey Gamayunov on 24/09/2018.
//  Copyright © 2018 Sergey. All rights reserved.
//

import Dip
import Foundation

enum Containers {
    case viewControllers
    case viewModels
    case managers

    var container: DependencyContainer {
        switch self {
        case .viewModels:
            return type(of: self).viewModelsContainer
        case .viewControllers:
            return type(of: self).viewControllersContainer
        case .managers:
            return type(of: self).managersContainer
        }
    }

    private static let managersContainer: DependencyContainer = {
        let container = DependencyContainer()
        container.register {
            try FirstLaunchManager(
                authManager: container.resolve(),
                viewControllerContainer: viewControllersContainer
            ) as FirstLaunchManagerProtocol
        }

        container.register(.singleton) {
            AuthManager() as AuthManagerProtocol
        }

        return container
    }()

    private static let viewModelsContainer: DependencyContainer = {
        let container = DependencyContainer()

        container.register {
            try AuthViewModel(authManager: managersContainer.resolve()) as AuthViewModelProtocol
        }

        container.register {
            MainGalleryViewModel() as MainGalleryViewModelProtocol
        }

        return container
    }()

    private static let viewControllersContainer: DependencyContainer = {
        let container = DependencyContainer()

        container.register(tag: RouterDestination.auth) {
            try AuthViewController(viewModel: viewModelsContainer.resolve()) as UIViewController
        }

        container.register(tag: RouterDestination.mainGallery) {
            try MainGalleryViewController(viewModel: viewModelsContainer.resolve()) as UIViewController
        }

        return container
    }()
}
