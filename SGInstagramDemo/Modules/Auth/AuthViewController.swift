//
//  AuthViewController.swift
//  SGInstagramDemo
//
//  Created by Sergey Gamayunov on 24/09/2018.
//  Copyright © 2018 Sergey. All rights reserved.
//

import UIKit
import WebKit

class AuthViewController: UIViewController {
    let viewModel: AuthViewModelProtocol

    private lazy var webView: WKWebView = {
        let view = WKWebView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.navigationDelegate = self
        return view
    }()

    init(viewModel: AuthViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green

        webView.addAndFitEdges(to: view, andBindWith: view.safeAreaInsets)
        if let request = viewModel.firstStepRequest {
            webView.load(request)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AuthViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        guard let url = webView.url else { return }

        if let code = url.queryParameters[SGTarget.ParamaterKey.code] {
            viewModel.requestToken(with: code)
        }
    }
}
