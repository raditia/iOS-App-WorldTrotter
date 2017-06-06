//
//  WebViewController.swift
//  TempConverter
//
//  Created by Raditia Madya on 6/6/17.
//  Copyright © 2017 Universitas Gadjah Mada. All rights reserved.
//

import UIKit
import WebKit
class WebViewController: UIViewController, WKUIDelegate {
    
    var webView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string: "http://github.com/raditia")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        
        // TODO: implement goBack() and goForward()
        }
}
