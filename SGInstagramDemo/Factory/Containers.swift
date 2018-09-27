//
//  Containers.swift
//  SGInstagramDemo
//
//  Created by Sergey Gamayunov on 24/09/2018.
//  Copyright © 2018 Sergey. All rights reserved.
//

import Dip
import Foundation
import Moya

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

        container.register {
            SGProvider(endpointClosure: { (target: SGTarget) -> Endpoint in
                let endpoint = SGProvider.defaultEndpointMapping(for: target)

                if let authManager = try? container.resolve() as AuthManagerProtocol,
                    let token = authManager.authToken {
                    if case var .requestParameters(parameters, encoding) = target.task {
                        parameters[SGTarget.ParamaterKey.accessToken] = token
                        return endpoint.replacing(task: .requestParameters(parameters: parameters, encoding: encoding))
                    }
                }

                return endpoint
            }) as SGProvider
        }

        container.register(.singleton) {
            try AuthManager(provider: container.resolve()) as AuthManagerProtocol
        }

        container.register(.singleton) {
            try MediaService(provider: container.resolve()) as MediaServiceProtocol
        }

        return container
    }()

    private static let viewModelsContainer: DependencyContainer = {
        let container = DependencyContainer()

        container.register {
            try AuthViewModel(authManager: managersContainer.resolve()) as AuthViewModelProtocol
        }

        container.register {
            try MainGalleryViewModel(
                authManager: managersContainer.resolve(),
                mediaService: managersContainer.resolve()
            ) as MainGalleryViewModelProtocol
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
