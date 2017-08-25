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
    
    var headerView:UIView! //头部视图
    var cleanHeaderView:BMOrderCleanHeaderView! //头部保洁单视图
    var houseKeepingHeaderView:BMOrderHouseKeepingHeaderView! //头部家政单视图
    var userInfoView:BMAfterSaleUserInfoView! //雇主信息视图
    var productView:BMAfterSaleProductView! //商品信息视图
    var priceView:BMOrderPriceView! //价格视图
    var payRecordView:BMOrderPayRecordView! //支付记录
    var bottomView:BMOrderDetailBottomView!  //订单编号+创建时间视图
    var tradeNo:String! //订单编号
    
    
    /**
     * 初始化视图控制器
     * @params tradeNo 订单编号
     */
    init(tradeNo:String) {
        self.tradeNo = tradeNo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "订单详情"
        self.view.backgroundColor = UIColor.colorWithHexString(hex: BMBacgroundColor)
        
        
        self.loadUI()
        self.loadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    /**
     *  加载页面布局
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
        
        
        //////头部视图(先用一个空白视图占位，等数据请求后再根据类型判断用哪个头部视图)/////
        self.headerView = UIView(frame: CGRect.zero)
        self.headerView.backgroundColor = UIColor.colorWithHexString(hex: BMThemeColor)
        self.contentView.addSubview(self.headerView)
        self.headerView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(self.contentView)
            make.height.equalTo(165)
        }
        
        
        //////////////雇主信息视图/////////////
        self.userInfoView = UIView.loadViewFromNib(nibName: "BMAfterSaleUserInfoView") as! BMAfterSaleUserInfoView
        self.contentView.addSubview(self.userInfoView)
        self.userInfoView.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView).offset(10)
            make.right.equalTo(self.contentView).offset(-10)
            make.top.equalTo(self.headerView.snp.bottom).offset(-20)
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
    
    
    /**
     *  加载网络数据
     */
    private func loadData(){
        
        ////////////查询订单详情////////////
        let url = "\(BMHOST)/trade/queryDetail"
        let params:Dictionary<String,Any> = ["tradeNo":self.tradeNo]
        
        
        NetworkRequest.sharedInstance.postRequest(urlString: url, params: params, isLogin: true, success: { (value) in
            
            
            let cateId:Int = value["cateId"].intValue
            
            if cateId == 1{ //家政单
                
                self.houseKeepingHeaderView = UIView.loadViewFromNib(nibName: "BMOrderHouseKeepingHeaderView") as! BMOrderHouseKeepingHeaderView
                self.houseKeepingHeaderView.updateWithOrder(order: value)
                self.headerView.addSubview(self.houseKeepingHeaderView)
                self.houseKeepingHeaderView.snp.makeConstraints { (make) in
                    make.edges.equalTo(self.headerView)
                }
                
            }else if cateId == 2{ //保洁单
                self.cleanHeaderView = UIView.loadViewFromNib(nibName: "BMOrderCleanHeaderView") as! BMOrderCleanHeaderView
                self.cleanHeaderView.updateWithOrder(order: value)
                self.headerView.addSubview(self.cleanHeaderView)
                self.cleanHeaderView.snp.makeConstraints { (make) in
                    make.edges.equalTo(self.headerView)
                }
                
                
            }
            
            self.userInfoView.updateWithAfterSale(afterSale: value)
            self.productView.updateWithAfterSale(afterSale: value)
            
            
           
            
        }) { (error) in
            
            
        }

    }
    


}
