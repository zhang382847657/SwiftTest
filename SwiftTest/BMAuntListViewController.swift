//
//  BMAuntListViewController.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/8/4.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit
import TBEmptyDataSet
import DGElasticPullToRefresh
import SwiftyJSON

class BMAuntListViewController: UITableViewController,TBEmptyDataSetDelegate,TBEmptyDataSetDataSource {
    
    var loadMoreControl = JTLoadMoreControl() //加载更多数据控制器
    let pageSize:Int = 10  //每页显示条数
    var pageNum:Int? = 0   //当前页
    var dataList:Array<Any>?     //返回的数据数组

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "查看阿姨"
        self.hidesBottomBarWhenPushed = true
        
        
    
        ///////////对tableView进行设置/////////////
        self.tableView.register(UINib(nibName: "BMAuntListCell", bundle: nil), forCellReuseIdentifier: "BMAuntListCell")
        self.tableView.rowHeight = 95 //行高
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none  //去掉分割线
        self.tableView.tableFooterView = loadMoreControl
        self.tableView.emptyDataSetDelegate = self  //设置空数据的代理
        self.tableView.emptyDataSetDataSource = self  //设置空数据的数据源
        self.tableView.backgroundColor = UIColor.colorWithHexString(hex: BMBacgroundColor)
        
        ///////////显示头部刷新视图//////////////////
        let loadingView = DGElasticPullToRefreshLoadingViewCircle()
        loadingView.tintColor = UIColor(red: 78/255.0, green: 221/255.0, blue: 200/255.0, alpha: 1.0)
        self.tableView.dg_addPullToRefreshWithActionHandler({ [weak self] () -> Void in //刷新回调
            
            self?.pageNum = 0  //重置当前页为0
            self?.dataList = nil  //重置请求数据为空
            self?.loadData()   //请求数据
            
            }, loadingView: loadingView)
        self.tableView.dg_setPullToRefreshFillColor(UIColor.colorWithHexString(hex: BMThemeColor)) //设置头部刷新视图的背景色
        self.tableView.dg_setPullToRefreshBackgroundColor(self.tableView.backgroundColor!) //设置头部刷新指示器的颜色
        
        ///////////显示尾部加载更多视图//////////////
        self.loadMoreControl.addTarget(self, action: #selector(loadingMore), for: .valueChanged)
        
    
        
        self.loadData()//请求数据
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    deinit {
        self.tableView.dg_removePullToRefresh() //移除头部刷新视图
    }
    
    
    /**
     * 请求数据
     */
    func loadData() {
        
        //////////////请求所有商品类目///////////////////
        let productURL = "\(BMHOST)/app/aunt/queryList?duserCode=\(BMDUSERCODE)&pageSize=\(self.pageSize)&pageNum=\(self.pageNum!)"
        let params = ["":""]
        NetworkRequest.sharedInstance.getRequest(urlString: productURL , params: params , success: { value in
            
            self.loadMoreControl.endLoading() //停止尾部加载数据动画
            
            if self.pageNum == 0{  //如果是下拉刷新
                self.tableView.dg_stopLoading()  //停止刷新动画
            }
            
            if let dataList = self.dataList{ //如果已经有数据了，就把新数据追到到数组最后面
                
                let array:Array<Any> = value["dataList"].arrayValue
                self.dataList = dataList + array
                
                if array.count < self.pageSize{ //如果是最后一页数据
                    self.loadMoreControl.endLoadingDueToNoMoreData() //尾部显示没有更多数据
                }
                
            }else{  //如果没有数据，则把请求得来的数据赋值给dataList
                self.dataList = value["dataList"].array
            }
            
            self.tableView.reloadData()  //刷新数据源
            
        }) { error in
            
            self.loadMoreControl.endLoadingDueToFailed() //加载失败后，停止尾部加载动画，并且提示用户点击重试
        }
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let dataList = self.dataList{
            return dataList.count
        }
        return 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:BMAuntListCell = tableView.dequeueReusableCell(withIdentifier: "BMAuntListCell", for: indexPath) as! BMAuntListCell
        cell.backgroundColor = UIColor.clear
       // cell.selectionStyle = .none //去掉点击效果
        
        if let dataList = self.dataList{
            let json: JSON =  dataList[indexPath.row] as! JSON
            cell.updateWithAunt(aunt: json)
        }
        
        return cell
    }
    
    // MARK: - TabelViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        let cell = tableView.cellForRow(at: indexPath)
        let vc:BMAuntDetailViewController = BMAuntDetailViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    
    }
    
  
    
    
    // MARK: - TBEmptyDataSetDataSource
    
    func imageForEmptyDataSet(in scrollView: UIScrollView) -> UIImage? {
        
        return UIImage(named: "empty")
    }
    
    func titleForEmptyDataSet(in scrollView: UIScrollView) -> NSAttributedString? {
        
        return NSAttributedString(string: "暂无数据")
    }
    
    // MARK: - 内部函数
    
    
    /**
     *  加载更多数据
     */
    func loadingMore() {
        
        self.pageNum! += 1  //页数+1
        self.loadData()  //请求数据
        
    }
    
    

}
