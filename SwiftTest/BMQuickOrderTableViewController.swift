//
//  BMQuickOrderTableViewController.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/7/18.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit
import TBEmptyDataSet
import DGElasticPullToRefresh
import SwiftyJSON

class BMQuickOrderTableViewController: UITableViewController,TBEmptyDataSetDelegate,TBEmptyDataSetDataSource {

    var loadMoreControl = JTLoadMoreControl() //加载更多数据控制器
    let pageSize:Int = 10  //每页显示条数
    var pageNum:Int? = 0   //当前页
    var dataList:Array<Any>?     //返回的数据数组
    var alertController:UIAlertController! //提示框
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "快速下单"
        
        
        ///////////对tableView进行设置/////////////
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell") //注册cell
        self.tableView.rowHeight = 130  //行高
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
        
        
        
        ///////////设置提示框////////////////////
        self.alertController = UIAlertController(title: "预约成功", message: "恭喜您预约成功\n我们会尽快与您联系", preferredStyle: UIAlertControllerStyle.alert)

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
        
        //////////////请求所有商品类目///////////////////
        let productURL = "\(BMHOST)/product/queryProductList?duserCode=\(BMDUSERCODE)&state=1&pageSize=\(self.pageSize)&pageNum=\(self.pageNum!)"
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = .none //去掉点击效果
        
        if cell.contentView.subviews.count > 0 {
            
            for view in cell.contentView.subviews{
                view.removeFromSuperview()
            }
        }
        
        //主要视图
        let cellView:BMHotServiceCellView = UIView.loadViewFromNib(nibName: "BMHotServiceCellView") as! BMHotServiceCellView
        cellView.backgroundColor = UIColor.white
        cellView.tag = 10
        cell.contentView.addSubview(cellView)
        
        cellView.snp.makeConstraints { (make) in
            make.left.equalTo(cell.contentView.snp.left).offset(10)
            make.top.equalTo(cell.contentView.snp.top).offset(5)
            make.bottom.equalTo(cell.contentView.snp.bottom)
        }
        
        if let dataList = self.dataList{
            let json: JSON =  dataList[indexPath.row] as! JSON
            cellView.updateUIWithProduct(products: json)
        }
        
        //右侧预约视图
        let cellRightView:UIButton = UIButton(type: .custom)
        cellRightView.frame = CGRect.zero
        //cellRightView.setTitle("预约", for: .normal)
        cellRightView.titleLabel?.font = UIFont.systemFont(ofSize: BMSubTitleFontSize)
        cellRightView.setTitleColor(UIColor.colorWithHexString(hex: BMThemeColor), for:  .normal)
        cellRightView.setImage(UIImage(named:"subscribe"), for: .normal)
        cellRightView.backgroundColor = UIColor.white
        cellRightView.tag = 11
        cellRightView.addTarget(self, action: #selector(appointmentClick), for: .touchUpInside)
        cell.contentView.addSubview(cellRightView)
    
        cellRightView.snp.makeConstraints { (make) in
            make.top.equalTo(cell.contentView.snp.top).offset(5)
            make.bottom.equalTo(cell.contentView.snp.bottom)
            make.left.equalTo(cellView.snp.right)
            make.right.equalTo(cell.contentView.snp.right).offset(-10)
            make.width.equalTo(0)
        }
        
        return cell
    }
    
    // MARK: - TabelViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        let cell = tableView.cellForRow(at: indexPath)
        
        //动画
        UIView.animate(withDuration: 0.6, animations: {
            
            var leftView:BMHotServiceCellView? = nil
            var rightView:UIButton? = nil
            for view in (cell?.contentView.subviews)!{
                if view.tag == 10 {
                    leftView = view as? BMHotServiceCellView
                }else if view.tag == 11 {
                    rightView = view as? UIButton
                }
            }
            
            rightView?.snp.updateConstraints({ (make) in
                make.width.equalTo(110)
            })
            
            leftView?.snp.updateConstraints({ (make) in
                make.left.equalTo((cell?.contentView)!).offset(-110)
            })
            

            //用来立即刷新布局（不写无法实现动画移动，会变成瞬间移动）
            self.view.layoutIfNeeded()
            
            rightView?.set(image: UIImage(named:"subscribe"), title: "预约", titlePosition: .bottom, additionalSpacing: 10, state: .normal)
        })
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath){
        
        let cell = tableView.cellForRow(at: indexPath)
        
        if let cell = cell{
            //动画
            UIView.animate(withDuration: 0.6, animations: {
                
                var leftView:BMHotServiceCellView? = nil
                var rightView:UIButton? = nil
                for view in cell.contentView.subviews{
                    if view.tag == 10 {
                        leftView = view as? BMHotServiceCellView
                    }else if view.tag == 11 {
                        rightView = view as? UIButton
                    }
                }
                
                leftView?.snp.updateConstraints({ (make) in
                    make.left.equalTo(cell.contentView).offset(10)
                })
                
                rightView?.snp.updateConstraints({ (make) in
                    make.width.equalTo(0)
                })
                
                //用来立即刷新布局（不写无法实现动画移动，会变成瞬间移动）
                self.view.layoutIfNeeded()
                
                rightView?.set(image: UIImage(named:""), title: "预约", titlePosition: .bottom, additionalSpacing: 10, state: .normal)
            })
        }
        
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
    
    /**
     *  预约点击事件
     */
    func appointmentClick(){

        self.present(self.alertController, animated: true, completion: {
            
            Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { (timer) in
                
                self.alertController.dismiss(animated: true, completion: nil)
            }
        })
    }

}
