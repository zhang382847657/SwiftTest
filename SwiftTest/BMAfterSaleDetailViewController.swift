//
//  BMAfterSaleDetailViewController.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/8/24.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit

class BMAfterSaleDetailViewController: UIViewController {
    
    
    var scrollView:UIScrollView!  //滚动视图
    var contentView:UIView! //内容视图
    
    var headerView:BMAfterSaleHeaderView! //头部视图
    var userInfoView:BMAfterSaleUserInfoView! //用户信息视图
    var productView:BMAfterSaleProductView! //商品信息
    var auntView:BMAfterSaleAuntView! //阿姨信息
    var aboutOrders:BMAfterSaleAboutOrders! //相关订单
    let serviceNo:String! //服务单、质保单编号
    
    
    /**
     *  初始化当前视图控制器
     * @params serviceNo 服务单、质保单编号
     */
    init(serviceNo:String) {
        self.serviceNo = serviceNo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "售后单"
        self.view.backgroundColor = UIColor.colorWithHexString(hex: BMBacgroundColor)
        
        self.loadUI()
        self.loadData()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
    
    /**
     *  初始化界面布局
     */
    private func loadUI(){
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
        
        
        //////////头部视图//////////
        self.headerView = UIView.loadViewFromNib(nibName: "BMAfterSaleHeaderView") as! BMAfterSaleHeaderView
        self.contentView.addSubview(self.headerView)
        self.headerView.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentView)
            make.left.right.equalTo(self.contentView)
            make.height.equalTo(165)
            
        }
        
        
        ///////////用户信息视图///////
        self.userInfoView = UIView.loadViewFromNib(nibName: "BMAfterSaleUserInfoView") as! BMAfterSaleUserInfoView
        self.contentView.addSubview(self.userInfoView)
        self.userInfoView.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView).offset(10)
            make.right.equalTo(self.contentView).offset(-10)
            make.top.equalTo(self.headerView.snp.bottom).offset(-20)
        }
        
        ////////////商品信息//////////
        self.productView = UIView.loadViewFromNib(nibName: "BMAfterSaleProductView") as! BMAfterSaleProductView
        self.contentView.addSubview(self.productView)
        self.productView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.userInfoView)
            make.top.equalTo(self.userInfoView.snp.bottom).offset(5)
        }
        
        
        ////////////阿姨信息//////////
        self.auntView = UIView.loadViewFromNib(nibName: "BMAfterSaleAuntView") as! BMAfterSaleAuntView
        self.contentView.addSubview(self.auntView)
        self.auntView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.userInfoView)
            make.top.equalTo(self.productView.snp.bottom).offset(5)
            
        }
        
        ////////////相关订单///////////
        self.aboutOrders = UIView.loadViewFromNib(nibName: "BMAfterSaleAboutOrders") as! BMAfterSaleAboutOrders
        self.contentView.addSubview(self.aboutOrders)
        self.aboutOrders.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.userInfoView)
            make.top.equalTo(self.auntView.snp.bottom).offset(5)
            make.bottom.equalTo(self.contentView)
        }
    }
    
    
    /**
     *  请求网络数据
     */
    private func loadData(){
        
        ////////////查询服务单质保单详情////////////
        let url = "\(BMHOST)/serviceorder/queryServiceorder"
        let params:Dictionary<String,Any> = ["serviceNo":self.serviceNo]
        
        
        NetworkRequest.sharedInstance.postRequest(urlString: url, params: params, isLogin: true, success: { (value) in
            
            self.headerView.updateWithAfterSale(afterSale: value)
            self.userInfoView.updateWithAfterSale(afterSale: value)
            self.productView.updateWithAfterSale(afterSale: value)
            
        }) { (error) in
            
            
        }
        
        
        ////////////根据服务单编号查询所有服务阿姨////////////
        let queryAuntByServiceUrl = "\(BMHOST)/serviceorder/queryAuntByService"
        
        
        NetworkRequest.sharedInstance.postRequest(urlString: queryAuntByServiceUrl, params: params, isLogin: true, success: { (value) in
            
            self.auntView.updateWithAunts(aunts: value["dataList"].arrayValue)
            
        }) { (error) in
            
            
        }
        
        
        ////////////查询相关订单////////////
        let queryRelatedOrderUrl = "\(BMHOST)/trade/queryList"
        
        
        NetworkRequest.sharedInstance.postRequest(urlString: queryRelatedOrderUrl, params: params, isLogin: true, success: { (value) in
            
            self.aboutOrders.updateWithAboutOrders(aboutOrders: value["dataList"])
            
        }) { (error) in
            
            
        }

        
        
    }
    

}
