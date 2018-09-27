//
//  MainGalleryViewController.swift
//  SGInstagramDemo
//
//  Created by Sergey Gamayunov on 24/09/2018.
//  Copyright © 2018 Sergey. All rights reserved.
//

import IGListKit
import UIKit
import MBProgressHUD

class MainGalleryViewController: UIViewController {
    let viewModel: MainGalleryViewModelProtocol
    var posts = [SimplePost]()

    private lazy var collectionView: ListCollectionView = {
        let layout = ListCollectionViewLayout(stickyHeaders: false, topContentInset: 0, stretchToEdge: false)
        let view = ListCollectionView(frame: .zero, listCollectionViewLayout: layout)
        view.backgroundColor = SGColor.brand
        return view
    }()

    private lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()

    init(viewModel: MainGalleryViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
        configureCollectionView()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureNavBar()
    }

    func configureNavBar() {
        title = "Main Gallery"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: SGFont.brand()]
    }

    func configureLogoutButton() {
        let button = UIBarButtonItem(title: L10n.logOut, style: .plain, target: self, action: #selector(logout))
        button.setTitleTextAttributes([
            NSAttributedString.Key.font: SGFont.brand,
            NSAttributedString.Key.foregroundColor: SGColor.brand
            ],for: .normal)
        navigationItem.leftBarButtonItem = button
    }

    func configureCollectionView() {
        collectionView.addAndFitEdges(to: view)
        adapter.collectionView = collectionView
        adapter.dataSource = self

    }

    func loadData() {
        MBProgressHUD.showAdded(to: collectionView, animated: true)
        viewModel.getMyRecentMedia { result in
            MBProgressHUD.hide(for: self.collectionView, animated: true)
            switch result {
            case .success(let userData):
                self.posts = SimplePost.initArrayFrom(userData)
                self.adapter.performUpdates(animated: true, completion: nil)
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

extension MainGalleryViewController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return posts
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return MyRecentSectionController()
    }

    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}

extension MainGalleryViewController: ErrorPresentable { }
