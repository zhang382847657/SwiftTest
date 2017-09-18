//
//  BMOrderServicesAuntListViewController.swift
//  SwiftTest
//  服务过该订单的阿姨列表页
//  Created by 张琳 on 2017/9/4.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit
import TBEmptyDataSet
import DGElasticPullToRefresh
import SwiftyJSON


class BMOrderServicesAuntListViewController: UITableViewController,TBEmptyDataSetDelegate,TBEmptyDataSetDataSource {

    var dataList:Array<JSON> = []  //数据源
    var tradeNo:String //订单编号
    var flowStatus:String //订单状态
    
    
    //MARK: 页面初始化
    //params tradeNo 订单编号
    init(tradeNo:String, flowStatus:String) {
        self.tradeNo = tradeNo
        self.flowStatus = flowStatus
        super.init(style: .grouped)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        self.tableView.dg_removePullToRefresh() //移除头部刷新视图
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "查看阿姨"

        self.tableView.backgroundColor = UIColor(hex: BMBacgroundColor)
        self.tableView.emptyDataSetDelegate = self  //设置空数据的代理
        self.tableView.emptyDataSetDataSource = self  //设置空数据的数据源
        self.tableView.separatorInset = UIEdgeInsets.zero
        self.tableView.layoutMargins = UIEdgeInsets.zero
        self.tableView.cellLayoutMarginsFollowReadableWidth = false
        self.tableView.register(UINib(nibName: "BMCommonAddressInfoCell", bundle: nil), forCellReuseIdentifier: "BMCommonAddressInfoCell")
        self.tableView.rowHeight = 95
        self.tableView.tableFooterView = UIView()
        
        ///////////显示头部刷新视图//////////////////
        let loadingView = DGElasticPullToRefreshLoadingViewCircle()
        loadingView.tintColor = UIColor(red: 78/255.0, green: 221/255.0, blue: 200/255.0, alpha: 1.0)
        self.tableView.dg_addPullToRefreshWithActionHandler({ [weak self] () -> Void in //刷新回调
            
            self?.loadData()   //请求数据
            
            }, loadingView: loadingView)
        self.tableView.dg_setPullToRefreshFillColor(UIColor.colorWithHexString(hex: BMThemeColor)) //设置头部刷新视图的背景色
        self.tableView.dg_setPullToRefreshBackgroundColor(self.tableView.backgroundColor!) //设置头部刷新指示器的颜色
        
        self.loadData() //加载数据

       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: 请求网络数据
    func loadData() {
        
        //////////////订单列表中查看阿姨接口查询///////////////////
        let url = "\(BMHOST)/trade/aunt/getInterviewPerson"
        let params = ["tradeId":self.tradeNo]
        
        NetworkRequest.sharedInstance.postRequest(urlString: url, params: params, isLogin: true, success: { (res) in
            
            if res.arrayValue.count > 0{
                
                let auntIdList = res.arrayValue.map({ (aunt)  in
                    aunt["auntId"].stringValue
                })
                
                let queryAuntByCacheUrl = "\(BMHOST)/aunt/queryAuntByCache"
                let queryAuntByCacheParams = ["auntIdList":auntIdList]
                NetworkRequest.sharedInstance.postRequest(urlString: queryAuntByCacheUrl, params: queryAuntByCacheParams, isLogin: true, success: { (response) in
                    
                   // var servicedAuntList:Array<JSON> = [];
                    
                    let queryRecordListUrl = "\(BMHOST)/interview/queryRecordList"
                    let queryRecordListParams = ["tradeNo":self.tradeNo]
                    NetworkRequest.sharedInstance.postRequest(urlString: queryRecordListUrl, params: queryRecordListParams, isLogin: true, success: { (result) in
                        
                        
                        for aunt in  res.arrayValue {
                            
                            let auntItem:JSON? = self.getAunt(auntId: aunt["auntId"].stringValue, auntList: result["dataList"].arrayValue)
                            
                            
                            let joinedAunt = aunt //Object.assign(aunt, response[aunt.auntId]);
                            
                            
//                            if let auntItem = auntItem {
//                                joinedAunt.interviewAddress = `${auntItem.interviewProvince}${auntItem.interviewCity}${auntItem.interviewDistrict}${auntItem.interviewAddress}`;
//                                joinedAunt.interviewTime = auntItem.interviewTime;
//                            }
//                            
//                            joinedAunt.serviceAddress = `${joinedAunt.district ? joinedAunt.district : ''}${joinedAunt.address ? joinedAunt.address : ''}${joinedAunt.houseNumber ? joinedAunt.houseNumber : ''}`;
//                            if (joinedAunt.interviewAddress && self.flowStatus != 'complete') {
//                                joinedAunt.showInterview = true;
//                            } else {
//                                joinedAunt.showInterview = false;
//                            }
//                            joinedAunt.interviewTime = joinedAunt.interviewTime ? timeFormat(new Date(joinedAunt.interviewTime), 'YYYY-MM-DD HH:mm:ss') : '-';
                            self.dataList.append(joinedAunt)
                            
                        }
                        
                        
                        
                    }) { (error) in
                        
                        
                    }
                    
                   
                    
                }) { (error) in
                    
                    
                }
                
            }
            
//            self.tableView.dg_stopLoading()  //停止刷新动画
//            self.dataList = value["dataList"].array
//            self.tableView.reloadData()  //刷新数据源
            
        }) { (error) in
            
            
        }

        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    public override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "服务过的阿姨"
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:BMAuntListCell = tableView.dequeueReusableCell(withIdentifier: "BMAuntListCell", for: indexPath) as! BMAuntListCell
        cell.backgroundColor = UIColor.clear
        
        let json: JSON =  dataList[indexPath.row]
        cell.updateWithAunt(aunt: json)
       
        return cell
    }
    
    
    // MARK: TBEmptyDataSet - DataSource
    
    func imageForEmptyDataSet(in scrollView: UIScrollView) -> UIImage? {
        
        return UIImage(named: "empty")
    }
    
    func titleForEmptyDataSet(in scrollView: UIScrollView) -> NSAttributedString? {
        
        return NSAttributedString(string: "暂无数据")
    }

    
    
    private func getAunt(auntId:String, auntList:Array<JSON>) -> JSON? {
        
        var filtered:Array = auntList.filter { (item) -> Bool in
            
            return item["auntId"].stringValue == auntId
        }
        
        return filtered.count > 0 ? filtered[0] : nil;
    
    }
    

    

}
