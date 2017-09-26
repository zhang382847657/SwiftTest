//
//  BMCouponListView.swift
//  SwiftTest
//  优惠券列表
//  Created by 张琳 on 2017/8/14.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit
import DGElasticPullToRefresh
import SwiftyJSON
import PKHUD

enum CouponListFrom:NSInteger{  //优惠券是从哪个页面跳转过来的
    case me,order   //me  代表我的   order代表订单
}

class BMCouponListView: UITableViewController {

    
    var sourceFrom:CouponListFrom!  //判断是从哪个页面跳转过来的
    var filterData:Dictionary<String,Any>?  //订单页面带过来的数据，用来当请求的参数
    var dataList:Array<JSON>?  //数据源
    var detailView:BMCouponDetailView? //详情页
    
    
    /**
     * 初始化页面
     * @param sourceFrom 是从哪个页面跳转过来的   枚举类型 
     * @param filterData  订单页面需要带过来的有关查询优惠券的数据  订单页面需要穿的参数
     */
    init(sourceFrom:CouponListFrom!,filterData:Dictionary<String,Any>?) {
        
        self.sourceFrom = sourceFrom
        self.filterData = filterData
        super.init(style: .grouped)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.title = "优惠券"
        self.tableView.backgroundColor = UIColor(hex: BMBacgroundColor)
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none  //去掉分割线
        self.tableView.rowHeight = 119
        self.tableView.tableFooterView = UIView()
        self.tableView.register(UINib(nibName: "BMCouponCell", bundle: nil), forCellReuseIdentifier: "BMCouponCell")
        
        
        ///////////显示头部刷新视图//////////////////
        let loadingView = DGElasticPullToRefreshLoadingViewCircle()
        loadingView.tintColor = UIColor(red: 78/255.0, green: 221/255.0, blue: 200/255.0, alpha: 1.0)
        self.tableView.dg_addPullToRefreshWithActionHandler({ [weak self] () -> Void in //刷新回调
            
            self?.loadData()   //请求数据
            
            }, loadingView: loadingView)
        self.tableView.dg_setPullToRefreshFillColor(UIColor.colorWithHexString(hex: BMThemeColor)) //设置头部刷新视图的背景色
        self.tableView.dg_setPullToRefreshBackgroundColor(self.tableView.backgroundColor!) //设置头部刷新指示器的颜色
        
        self.loadData()//请求数据
        
        

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        self.tableView.dg_removePullToRefresh() //移除头部刷新视图
    }
    
    
    /**
     * 请求数据
     */
    func loadData() {
        
        
        //////////////请求优惠券///////////////////
        let url = "\(BMHOST)/c/coupon/queryList"
        var params:Dictionary<String,Any> = ["":""]
        
        
        if self.sourceFrom == CouponListFrom.me{  //如果是从我的页面跳转过来
            params = ["status":0,"expireFlag":0,"pageSize":10000,"pageNum":0]
            
        }else if self.sourceFrom == CouponListFrom.order{  //如果是从订单页面跳转过来
            
//            params = ["serviceType":self.filterData!["serviceType"],"expireFlag":0,"pageSize":10000,"pageNum":0]
        }
        
        NetworkRequest.sharedInstance.postRequest(urlString: url, params: params, isLogin: true, success: { (value) in
            
            self.tableView.dg_stopLoading()  //停止刷新动画
            self.dataList = value["dataList"].array
            self.tableView.reloadData()
            
        }) { (error) in
            
            
        }
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let dataList = self.dataList{
            return dataList.count
        }else{
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        return 10
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:BMCouponCell = tableView.dequeueReusableCell(withIdentifier: "BMCouponCell", for: indexPath) as! BMCouponCell
        cell.selectionStyle = .none //去掉选中效果
        cell.updateWithCoupons(coupon: self.dataList![indexPath.row])
        
        return cell
    }
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        
        if self.detailView == nil{
            self.detailView = UIView.loadViewFromNib(nibName: "BMCouponDetailView") as? BMCouponDetailView
            self.detailView?.couponDetailCloseClickClosure = { //优惠券弹窗关闭点击回调
                () -> Void in
                PKHUD.sharedHUD.hide(true) //关闭弹窗
            }
            PKHUD.sharedHUD.contentView = self.detailView!  //设置弹窗的contentView
        }
        
        self.detailView!.updateWithCoupon(coupon: self.dataList![indexPath.row]) //更新数据
        PKHUD.sharedHUD.show() //显示弹窗
        
    }
 

   

}
