//
//  UIViewController+ErrorPresentable.swift
//  SGInstagramDemo
//
//  Created by Sergey Gamayunov on 26/09/2018.
//  Copyright © 2018 Sergey. All rights reserved.
//

import UIKit

protocol ErrorPresentable {
    func presentError(_ error: Error)
}

extension ErrorPresentable where Self: UIViewController {
    func presentError(_ error: Error) {
        let alert = UIAlertController(title: L10n.errorOccured, message: error.localizedDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: L10n.ok, style: .default)
        alert.addAction(okAction)

        present(alert, animated: true)
    }
}
