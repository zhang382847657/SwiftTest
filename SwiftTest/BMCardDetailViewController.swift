//
//  BMCardDetailViewController.swift
//  SwiftTest
//  卡包详情
//  Created by 张琳 on 2017/8/10.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit

class BMCardDetailViewController: UIViewController {
    
    var scrollView:UIScrollView!
    var contentView:UIView!
    var headerView:BMCardHeaderView! //顶部视图
    var servicePlanView:BMCardServicePlanView!  //服务计划
    var elaborate:BMCardElaborate! //详细描述
    var usageLog:BMCardUsageLogView! //使用记录
    
    var cardNo:String! //卡包ID
    var cardType:Int!  //卡包类型  1套餐卡  2储值卡
    var expireDescription:String! //卡包有效期
    
    
    /**
     *  页面初始化
     *  @param cardNo  卡Id
     *  @param cardType 卡包类型  1套餐卡  2储值卡
     *  @param expireDescription  有效期
     *  @param cardName 卡名字
     */
    init(cardNo:String, cardType:Int ,expireDescription:String, cardName:String) {
        
        self.cardNo = cardNo
        self.cardType = cardType
        self.expireDescription = expireDescription
        
        super.init(nibName: nil, bundle: nil)
        self.title = cardName
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.loadUI()
        self.loadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /**
     *  加载界面
     */
    private func loadUI(){
        self.view.backgroundColor = UIColor.colorWithHexString(hex: BMBacgroundColor)
        
        
        //////////滚动视图//////////////
        self.scrollView = UIScrollView(frame: CGRect.zero)
        self.view.addSubview(self.scrollView)
        self.scrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        
        ///////////内容视图////////////
        self.contentView = UIView(frame: CGRect.zero)
        self.scrollView.addSubview(self.contentView)
        self.contentView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.scrollView)
            make.width.equalTo(self.scrollView.snp.width)
            make.height.greaterThanOrEqualTo(0)
        }
        
        
        //////////头部卡片视图///////////
        self.headerView = UIView.loadViewFromNib(nibName: "BMCardHeaderView") as! BMCardHeaderView
        self.contentView.addSubview(self.headerView)
        self.headerView.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentView).offset(20)
            make.left.equalTo(self.contentView).offset(20)
            make.right.equalTo(self.contentView).offset(-20)
            make.height.equalTo(self.headerView.snp.width).multipliedBy(0.89)
        }
        
        
        if self.cardType == 1{  //如果是套餐卡
            
            //////////套餐卡专属服务计划/////////
            self.servicePlanView = UIView.loadViewFromNib(nibName: "BMCardServicePlanView") as! BMCardServicePlanView
            self.contentView.addSubview(self.servicePlanView)
            self.servicePlanView.snp.makeConstraints { (make) in
                make.top.equalTo(self.headerView.snp.bottom).offset(30)
                make.left.equalTo(self.contentView).offset(10)
                make.right.equalTo(self.contentView).offset(-10)
                make.height.equalTo(230)
            }
            
            
            ///////////套餐卡服务详细描述/////////
            self.elaborate = UIView.loadViewFromNib(nibName: "BMCardElaborate") as! BMCardElaborate
            self.contentView.addSubview(self.elaborate)
            self.elaborate.snp.makeConstraints { (make) in
                make.top.equalTo(self.servicePlanView.snp.bottom).offset(20)
                make.left.right.equalTo(self.contentView)
                make.bottom.equalTo(self.contentView).offset(-60)
            }
            
        }else if self.cardType == 2{  //如果是储值卡
            
            ////////////储值卡使用记录//////////////
            self.usageLog = UIView.loadViewFromNib(nibName: "BMCardUsageLogView") as! BMCardUsageLogView
            self.contentView.addSubview(self.usageLog)
            self.usageLog.snp.makeConstraints({ (make) in
                make.top.equalTo(self.headerView.snp.bottom).offset(100)
                make.left.right.equalTo(self.contentView)
                make.bottom.equalTo(self.contentView).offset(-60)
            })
            
        }else{
            
        }
        
        
        
    }
    
    

    
    /**
     * 请求数据
     */
    private func loadData() {
        
        if self.cardType == 1{  //如果是套餐卡
            
            //////////////请求套餐卡详情///////////////////
            let url = "\(BMHOST)/c/packagecard/queryCardDetail"
            let params:Dictionary<String,Int> = ["cardId":Int(self.cardNo)!]
            
            NetworkRequest.sharedInstance.postRequest(urlString: url, params: params, isLogin: true, success: { (value) in
                
                self.headerView.updateUIWithComboCard(card: value, expireDescription: self.expireDescription)
                
                
                //////////////请求套餐卡服务计划///////////////////
                let servicePlanUrl = "\(BMHOST)/acctCard/queryTask"
                let servicePlanParams:Dictionary<String,Int> = ["cardId":Int(self.cardNo)!]
                
                NetworkRequest.sharedInstance.postRequest(urlString: servicePlanUrl, params: servicePlanParams, isLogin: true, success: { (value2) in
                    
                    self.servicePlanView.updateWithServicePlans(task: value2)
                    
                    
                }) { (error) in
                    
                    
                }
                
                
            }) { (error) in
                
                
            }
            
        }else if self.cardType == 2{  //如果是储值卡
            
            //////////////请求储值卡详情///////////////////
            let url = "\(BMHOST)/cuserPcardSale/query"
            let params:Dictionary<String,String> = ["cardNo":self.cardNo]
            
            NetworkRequest.sharedInstance.postRequest(urlString: url, params: params, isLogin: true, success: { (value) in
                
                self.headerView.updateUIWithStoreCard(card: value, expireDescription: self.expireDescription)
                
                
                
                //////////////请求储值使用记录///////////////////
                let usageLogUrl = "\(BMHOST)/payrecord/queryList"
                let usageLogParams:Dictionary<String,Any> = ["inOutType":2,"prepaidCardNo":self.cardNo]
                
                NetworkRequest.sharedInstance.postRequest(urlString: usageLogUrl, params: usageLogParams, isLogin: true, success: { (value2) in
                    
                    self.usageLog.updateWithUsageLogs(usageLogs: value2["dataList"].array)
                    
                    
                }) { (error) in
                    
                    
                }
                
                
            }) { (error) in
                
                
            }
        }
        
        
        
    }
    

}
