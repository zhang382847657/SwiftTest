//
//  BMEvaluateRecordTableViewController.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/9/22.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit
import TBEmptyDataSet
import DGElasticPullToRefresh
import SwiftyJSON
import PKHUD

class BMEvaluateRecordTableViewController: UITableViewController,TBEmptyDataSetDelegate,TBEmptyDataSetDataSource {
    
    var dataList:Array<JSON>?  //数据源
    var tradeNo:String! //订单编号
    
    
    //MARK: 页面初始化
    /**
     * param: tradeNo  订单编号
     */
    init(tradeNo:String!) {
        self.tradeNo = tradeNo
        super.init(style: .plain)
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.title = "评价记录"
        
        self.tableView.backgroundColor = UIColor(hex: BMBacgroundColor)
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none  //去掉分割线
        self.tableView.estimatedRowHeight = 200
        self.tableView.tableFooterView = UIView()
        self.tableView.register(UINib(nibName: "BMEvaluateRecord", bundle: nil), forCellReuseIdentifier: "BMEvaluateRecord")
        self.tableView.emptyDataSetDelegate = self  //设置空数据的代理
        self.tableView.emptyDataSetDataSource = self  //设置空数据的数据源
        
        
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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        self.tableView.dg_removePullToRefresh() //移除头部刷新视图
    }
    
    
    //MARK: 加载网络数据
    private func loadData(){
        
        ////////////查询评价详情////////////
        let url = "\(BMHOST)/c/evaluate/queryEvalList"
        let params:Dictionary<String,String> = ["duserCode":BMDUSERCODE,"tradeNo":self.tradeNo]
        NetworkRequest.sharedInstance.getRequest(urlString: url , params: params , success: { value in
            
            self.tableView.dg_stopLoading()  //停止刷新动画
            self.dataList = value["dataList"].array
            self.tableView.reloadData()
            
            
        }) { error in
            
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


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:BMEvaluateRecord = tableView.dequeueReusableCell(withIdentifier: "BMEvaluateRecord", for: indexPath) as! BMEvaluateRecord
        cell.updateWithRecord(record: self.dataList![indexPath.row])

        return cell
    }


   

}
