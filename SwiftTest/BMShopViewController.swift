//
//  BMShopViewController.swift
//  SwiftTest
//  门店首页
//  Created by 张琳 on 2017/8/1.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit
import SKPhotoBrowser

class BMShopViewController: UIViewController {
    
    var scrollView:UIScrollView!
    var contentView:UIView!
    var headerView:BMShopHeaderView!
    var recommentAuntView:BMShopRecommendAuntView!
    var recommentCommentView:BMShopRecommendCommentView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false //这样可以防止scrollview没有置顶
        
        self.loadUI() //加载UI
        self.loadData() //加载网络数据
        
        
        
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
    
    
    //加载UI
    private func loadUI(){
        //////////////UIScrollView//////////
        self.scrollView = UIScrollView(frame: CGRect.zero)
        self.view.addSubview(self.scrollView)
        self.scrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        if #available(iOS 11.0, *) {
            /* 防止内容偏移20个像素 */
            self.scrollView.contentInsetAdjustmentBehavior = .never
        }
        
        //////////////内容视图//////////
        self.contentView = UIView(frame: CGRect.zero)
        self.scrollView.addSubview(self.contentView)
        self.contentView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.scrollView)
            make.width.equalTo(self.scrollView.snp.width)
            make.height.greaterThanOrEqualTo(0)
        }
        
        
        /////////////头部视图///////////
        self.headerView = UIView.loadViewFromNib(nibName: "BMShopHeaderView") as! BMShopHeaderView
        self.headerView.lookAllShopClickClosure = {  //查看所有门店点击回调
            () -> Void in
            self.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(BMStoreListTableViewController(style: .plain), animated: true)
            self.hidesBottomBarWhenPushed = false
        }
        self.contentView.addSubview(headerView)
        self.headerView.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(self.contentView)
            make.height.equalTo(215)
        }
        
        
        /////////////地址+网站+手机////////
        let toolsView:BMShopToolsView = UIView.loadViewFromNib(nibName: "BMShopToolsView") as! BMShopToolsView
        self.contentView.addSubview(toolsView)
        toolsView.snp.makeConstraints { (make) in
            make.top.equalTo(self.headerView.snp.bottom).offset(-8)
            make.left.equalTo(self.contentView).offset(10)
            make.right.equalTo(self.contentView).offset(-10)
            make.height.equalTo(40)
        }
        
        
        /////////////店铺推荐阿姨/////////
        self.recommentAuntView = UIView.loadViewFromNib(nibName: "BMShopRecommendAuntView") as! BMShopRecommendAuntView
        self.recommentAuntView.lookAllAuntsClickClosure = {  //查看所有阿姨按钮回调
            () -> Void in
            
            let vc:BMAuntListViewController = BMAuntListViewController(style: .plain)
            self.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
            self.hidesBottomBarWhenPushed = false
        }
        self.contentView.addSubview(self.recommentAuntView)
        recommentAuntView.snp.makeConstraints { (make) in
            make.top.equalTo(toolsView.snp.bottom).offset(5)
            make.left.right.equalTo(toolsView)
        }
        
        /////////////用户评价////////////
        self.recommentCommentView = UIView.loadViewFromNib(nibName: "BMShopRecommendCommentView") as! BMShopRecommendCommentView
        self.contentView.addSubview(self.recommentCommentView)
        recommentCommentView.snp.makeConstraints { (make) in
            make.top.equalTo(self.recommentAuntView.snp.bottom).offset(5)
            make.left.right.equalTo(toolsView)
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-20)
        }
    }
    
    
    //加载数据
    private func loadData(){
        
        
        ////////////查询总店信息////////////
        let companyUrl = "\(BMHOST)/custom/getDuserInfo?duserCode=\(BMDUSERCODE)"
        let params = ["":""]
        NetworkRequest.sharedInstance.getRequest(urlString: companyUrl , params: params , success: { value in
            
            self.headerView.updateWithCompany(company: value)
            

        }) { error in
            
        }
        
        ////////////查询推荐阿姨////////////
        let auntsUrl = "\(BMHOST)/c/aunt/auntOpenInfoList"
        let auntsParams:Dictionary <String,Any> = ["jobStatus":0,"state":1,"relationState":1,"blackState":1,"pageNum":0,"pageSize":3,"sortInfos[0].field":"optTime","sortInfos[0].sort":"DESC","duserCode":"\(BMDUSERCODE)","relationUserCode":"\(BMDUSERCODE)"]
        
        NetworkRequest.sharedInstance.postRequest(urlString: auntsUrl, params: auntsParams, isLogin: true, success: { (value) in
            
            self.recommentAuntView.updateWithRecommendAunts(aunts: value["dataList"])
            
        }) { (error) in
            
            
        }
        
        
        ////////////查询用户评价////////////
        let commentUrl = "\(BMHOST)/c/evaluate/queryEvalList?duserCode=\(BMDUSERCODE)&pageSize=3&hasRemark=1&minScore=4&maxScore=5"
        NetworkRequest.sharedInstance.getRequest(urlString: commentUrl , params: params , success: { value in
            
            self.recommentCommentView.updateWithRecommendComments(comments: value["dataList"])
            
            
        }) { error in
            
        }

    }

}
