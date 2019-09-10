//
//  ViewController.swift
//  WKWebViewTest
//
//  Created by we on 10/09/2019.
//  Copyright © 2019 we. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    @IBOutlet weak var webview: WKWebView!
    static let URLs = "aaa"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        webview.load(URLRequest(url: URL(string: "https://m.naver.com")!))
    }

}

