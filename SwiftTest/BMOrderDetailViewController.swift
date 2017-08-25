//
//  BMOrderDetailViewController.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/8/25.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit

class BMOrderDetailViewController: UIViewController {
    
    var scrollView:UIScrollView!
    var contentView:UIView!
    
    var cleanHeaderView:BMOrderCleanHeaderView! //头部保洁单视图
    var houseKeepingHeaderView:BMOrderHouseKeepingHeaderView! //头部家政单视图
    var userInfoView:BMAfterSaleUserInfoView! //雇主信息视图
    var productView:BMAfterSaleProductView! //商品信息视图
    var priceView:BMOrderPriceView! //价格视图
    var payRecordView:BMOrderPayRecordView! //支付记录
    var bottomView:BMOrderDetailBottomView!  //订单编号+创建时间视图

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "订单详情"
        self.view.backgroundColor = UIColor.colorWithHexString(hex: BMBacgroundColor)
        
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
        
        
        //////////////头部保洁单视图////////////
        self.cleanHeaderView = UIView.loadViewFromNib(nibName: "BMOrderCleanHeaderView") as! BMOrderCleanHeaderView
        self.contentView.addSubview(self.cleanHeaderView)
        self.cleanHeaderView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(self.contentView)
            make.height.equalTo(165)
        }
        
        
        //////////////雇主信息视图/////////////
        self.userInfoView = UIView.loadViewFromNib(nibName: "BMAfterSaleUserInfoView") as! BMAfterSaleUserInfoView
        self.contentView.addSubview(self.userInfoView)
        self.userInfoView.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView).offset(10)
            make.right.equalTo(self.contentView).offset(-10)
            make.top.equalTo(self.cleanHeaderView.snp.bottom).offset(-20)
        }
        
        //////////////商品信息视图////////////
        self.productView = UIView.loadViewFromNib(nibName: "BMAfterSaleProductView") as! BMAfterSaleProductView
        self.contentView.addSubview(self.productView)
        self.productView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.userInfoView)
            make.top.equalTo(self.userInfoView.snp.bottom).offset(5)
        }
        
        
        //////////////价格视图///////////////
        self.priceView = UIView.loadViewFromNib(nibName: "BMOrderPriceView") as! BMOrderPriceView
        self.contentView.addSubview(self.priceView)
        self.priceView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.userInfoView)
            make.top.equalTo(self.productView.snp.bottom)
        }
        
        
        ///////////////支付记录///////////////
        self.payRecordView = UIView.loadViewFromNib(nibName: "BMOrderPayRecordView") as! BMOrderPayRecordView
        self.contentView.addSubview(self.payRecordView)
        self.payRecordView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.userInfoView)
            make.top.equalTo(self.priceView.snp.bottom).offset(5)
        }
        
        
        ///////////////订单编号+创建时间视图///////
        self.bottomView = UIView.loadViewFromNib(nibName: "BMOrderDetailBottomView") as! BMOrderDetailBottomView
        self.contentView.addSubview(self.bottomView)
        self.bottomView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.userInfoView)
            make.top.equalTo(self.payRecordView.snp.bottom)
            make.bottom.equalTo(self.contentView)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    


}
