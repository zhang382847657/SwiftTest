//
//  BMProductViewController.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/7/19.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit
import SwiftyJSON
import WebKit

class BMProductViewController: UIViewController,WKNavigationDelegate {
    
    var scrollView: UIScrollView!  //最底层的滚动视图
    var contentView: UIView!    //滚动视图的内容视图  所有内容视图全都被加载此视图上
    var productView: BMProductsView!     //商品基本信息
    var productDetailView: WKWebView!  //商品详细信息
    var productBottomView: BMProductBottomView! //商品底部弹窗视图
    var product:JSON? = nil //商品对象
    var productID:Int! //商品ID
    
    
    
    init(productId:Int) {
        self.productID = productId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
       
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false //这样可以防止scrollview没有置顶
        self.loadContentView() //加载内容视图
        self.loadData()  //加载网络数据


    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
   
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)  //隐藏导航栏
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true) //显示导航栏
    }

    /**
     *  加载内容视图
     */
    func loadContentView(){
        
        
        /////////最底层的滚动视图/////////
        self.scrollView = UIScrollView(frame: CGRect.zero)
        self.scrollView.autoresizingMask = UIViewAutoresizing.flexibleHeight
        self.scrollView.isPagingEnabled = true
        self.scrollView.showsVerticalScrollIndicator = false
        self.view.addSubview(self.scrollView)
        self.scrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        /////////最底层滚动视图的内容视图/////////
        self.contentView = UIView(frame: CGRect.zero)
        self.contentView.backgroundColor = UIColor.blue
        self.scrollView.addSubview(self.contentView)
        self.contentView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.scrollView);
            make.width.equalTo(self.scrollView);
            make.height.greaterThanOrEqualTo(0);//此处保证容器View高度的动态变化 大于等于0的高度
        }
        
        
        ///////////商品基本信息////////////////
        self.productView = UIView.loadViewFromNib(nibName: "BMProductsView") as! BMProductsView
        self.productView.backClickClosure = {  //返回按钮的回调
            () -> Void in
            self.navigationController?.popViewController(animated: true)
        }
        self.productView.lookDetailClickClosure = {  //查看详情按钮的回调
            () -> Void in
            self.scrollView.setContentOffset(CGPoint(x: 0, y: kScreenHeight), animated: true)
        }
        self.productView.orderCarClickClosure = {  //返回按钮的回调
            () -> Void in
            self.productBottomView.show() //显示弹窗
        }
        
        self.contentView.addSubview(self.productView)
        
        self.productView.snp.makeConstraints { (make) in
            make.height.equalTo(kScreenHeight)
            make.top.equalTo(self.contentView)
            make.left.right.equalTo(self.contentView)
        }
        
        
        ///////////商品底部弹窗///////////
        self.productBottomView = BMProductBottomView(frame: CGRect.zero)
        self.productView.addSubview(self.productBottomView)
        
        
        ///////////商品详细信息////////////
        self.productDetailView = WKWebView(frame: CGRect.zero)
        self.productDetailView.backgroundColor = UIColor.red
        self.productDetailView.navigationDelegate = self
        self.productDetailView.scrollView.showsVerticalScrollIndicator = false
        self.contentView.addSubview(self.productDetailView)
        
        self.productDetailView.snp.makeConstraints { (make) in
            make.top.equalTo(self.productView.snp.bottom)
            make.left.right.equalTo(self.contentView)
            make.bottom.equalTo(self.contentView.snp.bottom)
            make.height.equalTo(kScreenHeight)
            
        }

    }
    
    
    /**
     *  请求网络数据
     */
    func loadData() {
        
        
        
        let parmas = ["productId":NSNumber(value: self.productID)]
        //////////////请求商品详情///////////////////
        let productTypeURL = "\(BMHOST)/product/queryProductDetail"
        
        NetworkRequest.sharedInstance.postRequest(urlString: productTypeURL, params: parmas, isLogin: false, success: { (value) in
            
            self.product = value
            self.productView.updateUIWithProduct(product: self.product!)
            
            let url = NSURL(string: "\(BMHOST)/productDetail?productId=\(self.productID!)")
            let requst = NSURLRequest(url: url! as URL)
            self.productDetailView.load(requst as URLRequest)
            
        }) { (error) in
            
            
        }
        
    }
    
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
       
//        self.productDetailView.snp.updateConstraints({ (make) in
//            //make.height.equalTo(webView.scrollView.contentSize.height)
//        })

    }


}
