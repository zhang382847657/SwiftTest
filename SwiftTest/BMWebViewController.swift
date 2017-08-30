//
//  BMWebViewController.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/6/28.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit
import WebKit
import SnapKit
import PKHUD

class BMWebViewController: UIViewController,WKUIDelegate,WKNavigationDelegate {
    
    var webView = WKWebView()
    var url:String!

    override func viewDidLoad() {
        super.viewDidLoad()

        //////////////初始化WKWebView///////////////
        self.webView.uiDelegate = self
        self.webView.navigationDelegate = self
        self.view.addSubview(self.webView)
        self.webView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        if url != "" {  //如果请求地址存在，就去加载地址
            HUD.show(.progress) //一进入页面就显示hud
            let request:NSURLRequest = NSURLRequest(url: NSURL(string: url)! as URL)
            self.webView.load(request as URLRequest)
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
     * 重写构造函数
     * param: url  请求地址
     */
    init(url:String) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.url = nil
        super.init(coder: aDecoder)
    }
    
    
    // MARK: - WKWebView WKNavigationDelegate

    //开始加载
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!){
        HUD.show(.progress)
    }
    
    //加载失败
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error){
        HUD.hide()
    }
        
    //加载成功
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!){
        HUD.hide(animated: true)

    }
}
