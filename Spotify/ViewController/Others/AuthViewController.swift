//
//  AuthViewController.swift
//  Spotify
//
//  Created by user212878 on 6/19/22.
//

import UIKit
import WebKit

class AuthViewController: UIViewController , WKNavigationDelegate {
    private let webView:WKWebView = {
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = prefs
        let webView = WKWebView(frame: .zero, configuration: config)
        return webView
    }()
    //setting a completion handler to inform other VC's whether user has been logged in or not
    public var completionHandler: ((Bool) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        title = "Authentication"
        view.addSubview(webView)
        guard let url = AuthManger.shared.signInURL else{
            return
        }
        webView.load(URLRequest(url: url))
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        guard let url = webView.url else{
            return
        }
        guard let code = URLComponents(string: url.absoluteString)?.queryItems?.first(where: { $0.name == "code"})?.value else{
            return
        }
        webView.isHidden = true
        print("Code: \(code)")
        AuthManger.shared.exchangeCodeForToken(code: code) { [weak self] (sucess) in
            DispatchQueue.main.async {
                self?.navigationController?.popToRootViewController(animated: true)
                self?.completionHandler?(sucess)
            }
        }
    }
}
