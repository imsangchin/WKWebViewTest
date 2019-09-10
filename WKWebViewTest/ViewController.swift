//
//  ViewController.swift
//  WKWebViewTest
//
//  Created by we on 10/09/2019.
//  Copyright © 2019 we. All rights reserved.
//

import UIKit
import WebKit

import UIKit
import WebKit

class ViewController: UIViewController {
    
    static let SCRIPT_HANDLER = "callbackHandler"
    
    @IBOutlet weak var webViewContainer: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    
    weak var myWebView: WKWebView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initWebView()
        initButton()
    }
    
    func initWebView() {
        let contentController = WKUserContentController()
        contentController.add(self, name: ViewController.SCRIPT_HANDLER)
        let config = WKWebViewConfiguration()
        config.userContentController = contentController
        
        // 웹뷰를 동적으로 생성해서 붙임
        let webview = WKWebView(frame: webViewContainer.bounds, configuration: config)
        webViewContainer.addSubview(webview)
        
        //javascript
        webview.configuration.preferences.javaScriptEnabled = true
        webview.configuration.preferences.javaScriptCanOpenWindowsAutomatically = true
        
        webview.navigationDelegate = self
        webview.uiDelegate = self
        
        //로컬 웹페이지 열기
        let url = Bundle.main.url(forResource: "webview", withExtension: "html", subdirectory: "web")!
        webview.loadFileURL(url, allowingReadAccessTo: url)
        let request = URLRequest(url: url)
        webview.load(request)
        
        myWebView = webview
    }
    
    func initButton() {
        // 버튼 클릭 리스너
        button.addTarget(self, action: #selector(onButtonClicked), for: .touchUpInside)
    }
    
    @objc func onButtonClicked() {
        myWebView?.evaluateJavaScript("changeKeyword('OK Apple');", completionHandler: { (result, error) in
            //처리 결과
            if let result = result {
                print(result)
            }
        })
    }
}

/*
 스크립트 핸들러
 */
extension ViewController: WKScriptMessageHandler {
    //Web -> Navie 호출
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if(message.name == ViewController.SCRIPT_HANDLER) {
            print("message.name -> \(message.name)")
            if let body = message.body as? String {
                label.text = body
            }
        }
    }
}

/*
 웹페이지 이동 핸들러
 */
extension ViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("페이지 로딩 완료")
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let urlText = navigationAction.request.url?.absoluteString {
            print("페이지 이동 \(urlText)")
        }
        decisionHandler(.allow)
    }
}

/*
 웹페이지와 네이티브 사용자간의 인터랙션 핸들러
 */
extension ViewController: WKUIDelegate {
    
    /*
    * alert 함수 호출시 콜백
    */
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "확인", style: .default, handler: { (action) in completionHandler() }))
        self.present(alertController, animated: true, completion: nil)
    }
}
