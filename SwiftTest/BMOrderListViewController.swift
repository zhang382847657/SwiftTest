//
//  BMOrderListViewController.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/8/23.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit
import TBEmptyDataSet
import DGElasticPullToRefresh
import SwiftyJSON


enum OrderType{  //订单类型
    case All,Finish,UnFinish,AfterSale
}

class BMOrderListViewController: UIViewController,TBEmptyDataSetDelegate,TBEmptyDataSetDataSource,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var allBtn: UIButton!  //全部按钮
    @IBOutlet weak var finishBtn: UIButton! //已完成按钮
    @IBOutlet weak var unFinishBtn: UIButton! //未完成按钮
    @IBOutlet weak var afterSaleBtn: UIButton! //售后按钮
    

    @IBOutlet weak var allTableView: UITableView! //全部列表
    @IBOutlet weak var unFinishTableView: UITableView! //未完成列表
    @IBOutlet weak var finishTableView: UITableView! //已完成列表
    @IBOutlet weak var afterSaleTableView: UITableView! //售后列表
    
    
    var allDataList:Array<JSON> = [] //全部订单数据源
    var finishDataList:Array<JSON> = [] //已完成订单数据源
    var unFinishDataList:Array<JSON> = [] //未完成订单数据源
    var afterSaleDataList:Array<JSON> = [] //售后订单数据源
    
    var currentSelectType:OrderType = .All //当前选中的订单类型
    let pageSize:Int = 10 //每页加载十条
    let loadingView = DGElasticPullToRefreshLoadingViewCircle() //头部刷新视图
    
    let allLoadMoreControl = JTLoadMoreControl() //全部订单加载更多数据控制器
    let finishLoadMoreControl = JTLoadMoreControl() //已完成订单加载更多数据控制器
    let unFinishLoadMoreControl = JTLoadMoreControl() //未完成订单加载更多数据控制器
    let afterSaleLoadMoreControl = JTLoadMoreControl() //售后订单加载更多数据控制器
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "订单"
        
        self.loadUI() //加载页面布局基本信息
        self.loadData(pageNumber: 0, isRefresh: true)//请求数据
        
        self.finishTableView.isHidden = true
        self.unFinishTableView.isHidden = true
        self.afterSaleTableView.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    deinit {
        self.allTableView.dg_removePullToRefresh() //移除头部刷新视图
        
    }
    
    
    /**
     *   加载页面的相关基本配置
     */
    private func loadUI(){
        
        ////设置头部刷新视图///
        self.loadingView.tintColor = UIColor(red: 78/255.0, green: 221/255.0, blue: 200/255.0, alpha: 1.0)
        
        
        ///////////全部TabelView///////////
        self.allTableView.separatorStyle = UITableViewCellSeparatorStyle.none  //去掉分割线
        self.allTableView.rowHeight = 126
        self.allTableView.tableFooterView = self.allLoadMoreControl
        self.allTableView.register(UINib(nibName: "BMOrderCell", bundle: nil), forCellReuseIdentifier: "BMOrderCell")
        self.allTableView.emptyDataSetDelegate = self  //设置空数据的代理
        self.allTableView.emptyDataSetDataSource = self  //设置空数据的数据源
        self.allTableView.dg_addPullToRefreshWithActionHandler({ [weak self] () -> Void in //刷新回调
            
            self?.loadData(pageNumber: 0, isRefresh: true)   //请求数据
            
            }, loadingView: self.loadingView)
        self.allTableView.dg_setPullToRefreshFillColor(UIColor.colorWithHexString(hex: BMThemeColor)) //设置头部刷新视图的背景色
        self.allTableView.dg_setPullToRefreshBackgroundColor(self.allTableView.backgroundColor!) //设置头部刷新指示器的颜色
        self.allLoadMoreControl.addTarget(self, action: #selector(loadingMore), for: .valueChanged)  //尾部加载更多数据绑定
        
        
        ///////////已完成TabelView///////////
        self.finishTableView.separatorStyle = UITableViewCellSeparatorStyle.none  //去掉分割线
        self.finishTableView.rowHeight = 126
        self.finishTableView.tableFooterView = self.finishLoadMoreControl
        self.finishTableView.register(UINib(nibName: "BMOrderCell", bundle: nil), forCellReuseIdentifier: "BMOrderCell")
        self.finishTableView.emptyDataSetDelegate = self  //设置空数据的代理
        self.finishTableView.emptyDataSetDataSource = self  //设置空数据的数据源
        self.finishTableView.dg_addPullToRefreshWithActionHandler({ [weak self] () -> Void in //刷新回调
            
            self?.loadData(pageNumber: 0, isRefresh: true)   //请求数据
            
            }, loadingView: self.loadingView)
        self.finishTableView.dg_setPullToRefreshFillColor(UIColor.colorWithHexString(hex: BMThemeColor)) //设置头部刷新视图的背景色
        self.finishTableView.dg_setPullToRefreshBackgroundColor(self.allTableView.backgroundColor!) //设置头部刷新指示器的颜色
        self.finishLoadMoreControl.addTarget(self, action: #selector(loadingMore), for: .valueChanged)  //尾部加载更多数据绑定
        
        
        ///////////未完成TabelView///////////
        self.unFinishTableView.separatorStyle = UITableViewCellSeparatorStyle.none  //去掉分割线
        self.unFinishTableView.rowHeight = 126
        self.unFinishTableView.tableFooterView = self.unFinishLoadMoreControl
        self.unFinishTableView.register(UINib(nibName: "BMOrderCell", bundle: nil), forCellReuseIdentifier: "BMOrderCell")
        self.unFinishTableView.emptyDataSetDelegate = self  //设置空数据的代理
        self.unFinishTableView.emptyDataSetDataSource = self  //设置空数据的数据源
        self.unFinishTableView.dg_addPullToRefreshWithActionHandler({ [weak self] () -> Void in //刷新回调
            
            self?.loadData(pageNumber: 0, isRefresh: true)   //请求数据
            
            }, loadingView: self.loadingView)
        self.unFinishTableView.dg_setPullToRefreshFillColor(UIColor.colorWithHexString(hex: BMThemeColor)) //设置头部刷新视图的背景色
        self.unFinishTableView.dg_setPullToRefreshBackgroundColor(self.allTableView.backgroundColor!) //设置头部刷新指示器的颜色
        self.unFinishLoadMoreControl.addTarget(self, action: #selector(loadingMore), for: .valueChanged)  //尾部加载更多数据绑定
        
        
        ///////////售后TabelView///////////
        self.afterSaleTableView.separatorStyle = UITableViewCellSeparatorStyle.none  //去掉分割线
        self.afterSaleTableView.rowHeight = UITableViewAutomaticDimension
        self.afterSaleTableView.estimatedRowHeight = 89
        self.afterSaleTableView.tableFooterView = self.afterSaleLoadMoreControl
        self.afterSaleTableView.register(UINib(nibName: "BMOrderCell", bundle: nil), forCellReuseIdentifier: "BMOrderCell")
        self.afterSaleTableView.emptyDataSetDelegate = self  //设置空数据的代理
        self.afterSaleTableView.emptyDataSetDataSource = self  //设置空数据的数据源
        self.afterSaleTableView.dg_addPullToRefreshWithActionHandler({ [weak self] () -> Void in //刷新回调
            
            self?.loadData(pageNumber: 0, isRefresh: true)   //请求数据
            
            }, loadingView: self.loadingView)
        self.afterSaleTableView.dg_setPullToRefreshFillColor(UIColor.colorWithHexString(hex: BMThemeColor)) //设置头部刷新视图的背景色
        self.afterSaleTableView.dg_setPullToRefreshBackgroundColor(self.allTableView.backgroundColor!) //设置头部刷新指示器的颜色
        self.afterSaleLoadMoreControl.addTarget(self, action: #selector(loadingMore), for: .valueChanged)  //尾部加载更多数据绑定
        
    }
    
    // MARK: 请求数据
    /**
     * 请求数据
     * param pageNumber 页码
     * param isRefresh  是否下拉刷新
     */
    private func loadData(pageNumber:Int, isRefresh:Bool) {
        
        
        var url:String = "\(BMHOST)/trade/queryList"  //默认除了售后都是这个地址
        var params:Dictionary<String,Any> = ["":""]
        
        if self.currentSelectType == .AfterSale {  //如果当前选中的是售后类型
            url = "\(BMHOST)/serviceorder/queryServiceorderList"
        }else{
            params = self.getFilterData()
        }
        
        params.contactWith(dic: ["pageNum":pageNumber,"pageSize":self.pageSize])
    
        
        NetworkRequest.sharedInstance.postRequest(urlString: url, params: params, isLogin: true, success: { (value) in
            
            
            switch self.currentSelectType{
                case .All:
                    self.allLoadMoreControl.endLoading() //停止尾部加载数据动画
                    if isRefresh == true {  //如果是下拉刷新
                        self.allTableView.dg_stopLoading()  //停止刷新动画
                        self.allDataList = [] //清空数据源
                    }
                    
                    self.allDataList += value["dataList"].arrayValue  //数组合并
                    self.allTableView.reloadData()  //刷新数据源
                case .Finish:
                    self.finishLoadMoreControl.endLoading() //停止尾部加载数据动画
                    if isRefresh == true {  //如果是下拉刷新
                        self.finishTableView.dg_stopLoading()  //停止刷新动画
                        self.finishDataList = [] //清空数据源
                    }
                    
                    self.finishDataList += value["dataList"].arrayValue  //数组合并
                    self.finishTableView.reloadData()  //刷新数据源
                case .UnFinish:
                    self.unFinishLoadMoreControl.endLoading() //停止尾部加载数据动画
                    if isRefresh == true {  //如果是下拉刷新
                        self.unFinishTableView.dg_stopLoading()  //停止刷新动画
                        self.unFinishDataList = [] //清空数据源
                    }
                    
                    self.unFinishDataList += value["dataList"].arrayValue  //数组合并
                    self.unFinishTableView.reloadData()  //刷新数据源
                case .AfterSale:
                    self.afterSaleLoadMoreControl.endLoading() //停止尾部加载数据动画
                    if isRefresh == true {  //如果是下拉刷新
                        self.afterSaleTableView.dg_stopLoading()  //停止刷新动画
                        self.afterSaleDataList = [] //清空数据源
                    }
                    
                    self.afterSaleDataList += value["dataList"].arrayValue  //数组合并
                    self.afterSaleTableView.reloadData()  //刷新数据源
            }
            
            
        }) { (error) in
            
            
        }
        
    }
    
    
    /**
     *  得到对应的请求参数
     */
    private func getFilterData() -> Dictionary<String,Any>{
        
        var params:Dictionary<String,Any> = ["":""]
        
        switch self.currentSelectType {
        case .All:
            params = ["":""]
        case .Finish:
            params = ["statusList[0]":9]
        case .UnFinish:
            params = ["statusList[0]":0,"statusList[1]":1]
        default:
            params = ["":""]
        }
        
        return params
    }
    
    
    /**
     *  加载更多数据
     */
    func loadingMore() {
        
        switch self.currentSelectType {
        case .All:
            if self.allDataList.count % self.pageSize == 0{  //还不是最后一页
                self.loadData(pageNumber: self.allDataList.count/self.pageSize+1, isRefresh: false)
            }else{  //已经是最后一页了
                self.allLoadMoreControl.endLoadingDueToNoMoreData() //尾部显示没有更多数据
            }
        case .Finish:
            if self.finishDataList.count % self.pageSize == 0{  //还不是最后一页
                self.loadData(pageNumber: self.finishDataList.count/self.pageSize+1, isRefresh: false)
            }else{  //已经是最后一页了
                self.finishLoadMoreControl.endLoadingDueToNoMoreData() //尾部显示没有更多数据
            }
        case .UnFinish:
            if self.unFinishDataList.count % self.pageSize == 0{  //还不是最后一页
                self.loadData(pageNumber: self.unFinishDataList.count/self.pageSize+1, isRefresh: false)
            }else{  //已经是最后一页了
                self.unFinishLoadMoreControl.endLoadingDueToNoMoreData() //尾部显示没有更多数据
            }
        case .AfterSale:
            if self.afterSaleDataList.count % self.pageSize == 0{  //还不是最后一页
                self.loadData(pageNumber: self.afterSaleDataList.count/self.pageSize+1, isRefresh: false)
            }else{  //已经是最后一页了
                self.afterSaleLoadMoreControl.endLoadingDueToNoMoreData() //尾部显示没有更多数据
            }
        }
    }
    
    

    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch self.currentSelectType {
        case .All:
            return self.allDataList.count
        case .Finish:
            return self.finishDataList.count
        case .UnFinish:
            return self.unFinishDataList.count
        case .AfterSale:
            return self.afterSaleDataList.count
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:BMOrderCell = tableView.dequeueReusableCell(withIdentifier: "BMOrderCell", for: indexPath) as! BMOrderCell
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = .none //去掉点击效果
        
        
        switch self.currentSelectType {
            case .All:
                cell.updateWithHouseAndClean(product: self.allDataList[indexPath.row])
            case .Finish:
                cell.updateWithHouseAndClean(product: self.finishDataList[indexPath.row])
            case .UnFinish:
                cell.updateWithHouseAndClean(product: self.unFinishDataList[indexPath.row])
            case .AfterSale:
                cell.updateWithAfterSale(product: self.afterSaleDataList[indexPath.row])
        }
        
        
        return cell
    }
    
    // MARK: - TabelViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
//        let cell:BMOrderCell = tableView.cellForRow(at: indexPath) as! BMOrderCell
        
       // return cell
        
    }
    
   
    
    
    // MARK: - TBEmptyDataSetDataSource
    
    func imageForEmptyDataSet(in scrollView: UIScrollView) -> UIImage? {
        
        return UIImage(named: "empty")
    }
    
    func titleForEmptyDataSet(in scrollView: UIScrollView) -> NSAttributedString? {
        
        return NSAttributedString(string: "暂无数据")
    }
    

    //订单类型点击事件
    @IBAction func orderTypeClick(_ sender: UIButton) {
        
        for view in self.view.subviews{  //遍历所有子视图
            
            if view is UIButton{  //如果是按钮类型，则做一个单选切换效果
                let btn:UIButton = view as! UIButton
                if btn == sender {
                    btn.isSelected = true
                }else{
                    btn.isSelected = false
                }
            }
            
        }
        
        switch sender.titleLabel!.text! {  //根据当前点击的类型按钮，设置当前选中的订单类型
        case "全部":
            self.currentSelectType = .All
            if self.allDataList.count <= 0 {
                self.loadData(pageNumber: 0, isRefresh: true)
            }
            
            self.allTableView.isHidden = false
            self.finishTableView.isHidden = true
            self.unFinishTableView.isHidden = true
            self.afterSaleTableView.isHidden = true
            
        case "已完成":
            self.currentSelectType = .Finish
            if self.finishDataList.count <= 0 {
                self.loadData(pageNumber: 0, isRefresh: true)
            }
            
            self.allTableView.isHidden = true
            self.finishTableView.isHidden = false
            self.unFinishTableView.isHidden = true
            self.afterSaleTableView.isHidden = true
        case "未完成":
            self.currentSelectType = .UnFinish
            if self.unFinishDataList.count <= 0 {
                self.loadData(pageNumber: 0, isRefresh: true)
            }
            
            self.allTableView.isHidden = true
            self.finishTableView.isHidden = true
            self.unFinishTableView.isHidden = false
            self.afterSaleTableView.isHidden = true
        case "售后":
            self.currentSelectType = .AfterSale
            if self.afterSaleDataList.count <= 0 {
                self.loadData(pageNumber: 0, isRefresh: true)
            }
            
            self.allTableView.isHidden = true
            self.finishTableView.isHidden = true
            self.unFinishTableView.isHidden = true
            self.afterSaleTableView.isHidden = false
        default:
            break
        }
        
        
    }

}
