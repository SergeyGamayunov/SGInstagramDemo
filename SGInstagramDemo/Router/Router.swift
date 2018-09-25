//
//  Router.swift
//  SGInstagramDemo
//
//  Created by Sergey Gamayunov on 24/09/2018.
//  Copyright © 2018 Sergey. All rights reserved.
//

import Dip
import UIKit
import RxSwift

protocol FirstLaunchManagerProtocol {
    func createRootViewController(in window: UIWindow) -> Observable<UIViewController>
}

class FirstLaunchManager {
    let authManager: AuthManagerProtocol
    let viewControllerContainer: DependencyContainer
    let disposeBag = DisposeBag()

    init(authManager: AuthManagerProtocol, viewControllerContainer: DependencyContainer) {
        self.authManager = authManager
        self.viewControllerContainer = viewControllerContainer
    }
}

extension FirstLaunchManager: FirstLaunchManagerProtocol {
    func createRootViewController(in window: UIWindow) -> Observable<UIViewController> {
        return Observable.create { [unowned self] observer in
            self.authManager.isAuthorizedObservable
                .subscribe(onNext: { isAuthorized in
                    if isAuthorized {
                        self.switchRootModule(in: window, observer: observer, for: .mainGallery)
                    } else {
                        self.switchRootModule(in: window, observer: observer, for: .auth)
                    }
                }).disposed(by: self.disposeBag)

            return Disposables.create()
        }
    }

    private func switchRootModule(
        in window: UIWindow,
        observer: AnyObserver<UIViewController>,
        for destination: RouterDestination
        ) {
        let viewController = destination.controller(in: viewControllerContainer)
        observer.onNext(viewController)
        animateRootWindowChange(in: window, viewController: viewController)
    }

    private func animateRootWindowChange(in window: UIWindow, viewController: UIViewController) {
        guard let snapshot = (window.snapshotView(afterScreenUpdates: true)) else {
            window.rootViewController = viewController
            return
        }

        viewController.view.addSubview(snapshot)
        window.rootViewController = viewController
        UIView.animate(
            withDuration: 0.3,
            animations: {
                snapshot.layer.opacity = 0
                snapshot.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.5)
        },
            completion: { _ in
                snapshot.removeFromSuperview()
        }
        )
    }
}
