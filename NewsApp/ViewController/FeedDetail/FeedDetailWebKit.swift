//
//  FeedDetailWebKit.swift
//  NewsApp
//
//  Created by Ecem Öztürk on 20.09.2023.
//

import UIKit
import WebKit

class FeedDetailWebKit: UIViewController {
    
    // MARK: - Properties
    var url: String? = nil
    var webPage = WKWebView()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        if let url = url {
            loadWebPage(url)
        }
    }
    
    // MARK: - UI Setup
    func setUp() {
        view.addSubview(webPage)
        webPage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webPage.topAnchor.constraint(equalTo: view.topAnchor),
            webPage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            webPage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webPage.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    // MARK: - Web Page Loading
    func loadWebPage(_ urlString: String) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webPage.load(request)
        }
    }
}
