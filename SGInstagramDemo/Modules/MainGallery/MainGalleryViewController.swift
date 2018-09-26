//
//  MainGalleryViewController.swift
//  SGInstagramDemo
//
//  Created by Sergey Gamayunov on 24/09/2018.
//  Copyright © 2018 Sergey. All rights reserved.
//

import UIKit

class MainGalleryViewController: UIViewController {
    let viewModel: MainGalleryViewModelProtocol
    var posts = [SimplePost]()

    init(viewModel: MainGalleryViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .red
        let button = UIBarButtonItem(title: "Log out", style: .plain, target: self, action: #selector(logout))

        navigationItem.leftBarButtonItem = button

        loadData()
    }

    func loadData() {
        viewModel.getMyRecentMedia { result in
            switch result {
            case .success(let userData):
                self.posts = SimplePost.initArrayFrom(userData)
            case .failure(let error):
                self.presentError(error)
            }
        }
    }

    @objc
    func logout() {
        viewModel.logout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MainGalleryViewController: ErrorPresentable { }
