//
//  DetailViewController.swift
//  Project7
//
//  Created by Burak Güzey on 16.03.2024.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    var webView: WKWebView!
    var detailItem: Petition?

    override func loadView() {
        
        guard let detailItem = detailItem else { return }

        let html = """
        <html>
        <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <style> body { font-size: 150%; } </style>
        </head>
        <body>
        \(detailItem.body)
        </body>
        </html>
        """

        webView.loadHTMLString(html, baseURL: nil)
        
        webView = WKWebView()
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
