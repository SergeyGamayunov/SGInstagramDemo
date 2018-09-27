//
//  AuthViewController.swift
//  SGInstagramDemo
//
//  Created by Sergey Gamayunov on 24/09/2018.
//  Copyright © 2018 Sergey. All rights reserved.
//

import UIKit
import WebKit
import MBProgressHUD

class AuthViewController: UIViewController {
    let viewModel: AuthViewModelProtocol
    var indicator: MBProgressHUD!

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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureIndicator()
        openAuthPage()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        configureWebView()
    }

    func configureIndicator() {
        indicator = MBProgressHUD.showAdded(to: webView, animated: true)
        indicator.label.text = L10n.loading
        indicator.label.font = SGFont.brand(size: 12)
    }

    func configureWebView() {
        if #available(iOS 11.0, *) {
            webView.addAndFitEdges(to: view, andBindWith: view.safeAreaInsets)
        } else {
            webView.addAndFitEdges(to: view)
        }
    }

    func openAuthPage() {
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

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {

    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        MBProgressHUD.hide(for: webView, animated: true)
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        MBProgressHUD.hide(for: webView, animated: true)
    }

    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        MBProgressHUD.hide(for: webView, animated: true)
    }
}
