//
//  BMAuntDetailViewController.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/8/4.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit
import SwiftyJSON

class BMAuntDetailViewController: UIViewController {
    
    var scrollView:UIScrollView!
    var contentView:UIView!
    
    var servicesTypeView:BMAuntServicesTypeScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "阿姨详情"
        self.view.backgroundColor = UIColor.colorWithHexString(hex: BMBacgroundColor)

        self.loadUI()
        self.loadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //加载内容视图
    func loadUI(){
        self.scrollView = UIScrollView(frame: CGRect.zero)
        self.view.addSubview(self.scrollView)
        self.scrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        self.contentView = UIView(frame: CGRect.zero)
        self.scrollView.addSubview(self.contentView)
        self.contentView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.scrollView)
            make.width.equalTo(self.scrollView.snp.width)
            make.height.greaterThanOrEqualTo(0)
        }
        
        
        //////////阿姨头部视图//////////////
        let headerView:BMAuntDetailHeaderView = UIView.loadViewFromNib(nibName: "BMAuntDetailHeaderView") as! BMAuntDetailHeaderView
        self.contentView.addSubview(headerView)
        headerView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self.contentView)
            make.height.equalTo(210)
        }
        
        
        //////////阿姨服务类型///////////////
        self.servicesTypeView = BMAuntServicesTypeScrollView(frame: CGRect.zero)
        self.contentView.addSubview(self.servicesTypeView)
        self.servicesTypeView.snp.makeConstraints { (make) in
            make.top.equalTo(headerView.snp.bottom).offset(-10)
            make.left.equalTo(self.contentView.snp.left).offset(10)
            make.right.equalTo(self.contentView.snp.right).offset(-10)
            make.height.equalTo(100)
            make.bottom.equalTo(self.contentView)
        }
    }
    
    
    //请求数据
    func loadData(){
        
        //////////////请求轮播图///////////////////
        
        let bannerURL = "\(BMHOST)/c/aunt/queryAuntItem?auntId=A0016984"
        let params = ["":""]
        
        NetworkRequest.sharedInstance.postRequest(urlString: bannerURL, params: params, isLogin: true, success: { (value) in
            
            self.servicesTypeView.updateWithServiceType(serviceType: value)
            
        }) { (error) in
            
            
        }
        
    }
    


}
