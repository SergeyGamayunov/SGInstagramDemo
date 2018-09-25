//
//  AppDelegate.swift
//  SGInstagramDemo
//
//  Created by Sergey Gamayunov on 24/09/2018.
//  Copyright © 2018 Sergey. All rights reserved.
//

import RxSwift
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    var firstLaunchManager: FirstLaunchManagerProtocol?
    let disposeBag = DisposeBag()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        do {
            let firstLaunchManager = try Containers.managers.container.resolve() as FirstLaunchManagerProtocol
            firstLaunchManager.createRootViewController(in: window)
                .subscribe()
                .disposed(by: disposeBag)
            self.firstLaunchManager = firstLaunchManager
        } catch {
            window.rootViewController = UIViewController()
        }

        window.makeKeyAndVisible()
        self.window = window
        return true
    }
}

