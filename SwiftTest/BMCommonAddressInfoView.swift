//
//  BMCommonAddressInfoView.swift
//  SwiftTest
//  常用地址
//  Created by 张琳 on 2017/9/1.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit
import TBEmptyDataSet
import DGElasticPullToRefresh
import SwiftyJSON

class BMCommonAddressInfoView: UIView,UITableViewDataSource,UITableViewDelegate,TBEmptyDataSetDelegate,TBEmptyDataSetDataSource {


    var tableView:UITableView! //tableView
    var addAddressBtn:UIButton! //新增地址按钮
    var dataList:Array<JSON>?  //数据源
    var alertController:UIAlertController! //提示框
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.loadUI() //加载布局
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
        
        self.loadUI() //加载布局
    }
    
    deinit {
        self.tableView.dg_removePullToRefresh() //移除头部刷新视图
    }
    
    
    //MARK: 加载布局
    private func loadUI(){
        
        
        /////////////新增地址按钮/////////////////
        self.addAddressBtn = UIButton(type: .custom)
        self.addAddressBtn.frame = CGRect.zero
        self.addAddressBtn.backgroundColor = UIColor.white
        self.addAddressBtn.setTitle("新增地址", for: .normal)
        self.addAddressBtn.setImage(UIImage(named:"xinzengdizhi"), for: .normal)
        self.addAddressBtn.setTitleColor(UIColor(hex:BMThemeColor), for: .normal)
        self.addAddressBtn.titleLabel?.font = UIFont.systemFont(ofSize: BMTitleFontSize)
        self.addAddressBtn.addTarget(self, action: #selector(addAddressClick), for: .touchUpInside)
        self.addSubview(self.addAddressBtn)
        self.addAddressBtn.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self)
            make.height.equalTo(60)
        }
        
        
        /////////////UITableView/////////////////
        self.tableView = UITableView(frame: CGRect.zero, style: .plain)
        self.tableView.backgroundColor = UIColor(hex: BMBacgroundColor)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.emptyDataSetDelegate = self  //设置空数据的代理
        self.tableView.emptyDataSetDataSource = self  //设置空数据的数据源
        self.tableView.separatorInset = UIEdgeInsets.zero
        self.tableView.layoutMargins = UIEdgeInsets.zero
        self.tableView.cellLayoutMarginsFollowReadableWidth = false
        self.tableView.register(UINib(nibName: "BMCommonAddressInfoCell", bundle: nil), forCellReuseIdentifier: "BMCommonAddressInfoCell")
        self.tableView.rowHeight = 70
        self.tableView.tableFooterView = UIView()
        
        ///////////显示头部刷新视图//////////////////
        let loadingView = DGElasticPullToRefreshLoadingViewCircle()
        loadingView.tintColor = UIColor(red: 78/255.0, green: 221/255.0, blue: 200/255.0, alpha: 1.0)
        self.tableView.dg_addPullToRefreshWithActionHandler({ [weak self] () -> Void in //刷新回调
            
            self?.loadData()   //请求数据
            
            }, loadingView: loadingView)
        self.tableView.dg_setPullToRefreshFillColor(UIColor.colorWithHexString(hex: BMThemeColor)) //设置头部刷新视图的背景色
        self.tableView.dg_setPullToRefreshBackgroundColor(self.tableView.backgroundColor!) //设置头部刷新指示器的颜色
        self.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(10)
            make.right.equalTo(self).offset(-10)
            make.top.equalTo(self).offset(10)
            make.bottom.equalTo(self.addAddressBtn.snp.top).offset(-10)
        }
        
        self.loadData() //加载数据
        
        ///////////设置提示框////////////////////
        self.alertController = UIAlertController(title: "删除", message: "确定要删除该地址吗？", preferredStyle: UIAlertControllerStyle.alert)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: {
            (action: UIAlertAction) -> Void in //取消操作
            self.alertController.dismiss(animated: true, completion: nil)
        })
        let okAction = UIAlertAction(title: "确定", style: .destructive, handler: {
            (action: UIAlertAction) -> Void in //确定操作
            self.alertController.dismiss(animated: true, completion: nil)
        })
        self.alertController.addAction(cancelAction)
        self.alertController.addAction(okAction)
        
        
    }
    
    //MARK: 请求数据
    func loadData() {
        
        //////////////请求所有商品类目///////////////////
        let url = "\(BMHOST)/cuser/queryAddressList"
        let params = ["":""]
        
        NetworkRequest.sharedInstance.postRequest(urlString: url, params: params, isLogin: true, success: { (value) in
            
            self.tableView.dg_stopLoading()  //停止刷新动画
            self.dataList = value["dataList"].array
            self.tableView.reloadData()  //刷新数据源
            
        }) { (error) in
            
            
        }
        
    }
    
    
    //MARK: UITabelView - DataSource
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if let dataList = self.dataList{
            return dataList.count
        }
        return 0
    }
    
  
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell:BMCommonAddressInfoCell = tableView.dequeueReusableCell(withIdentifier: "BMCommonAddressInfoCell", for: indexPath) as! BMCommonAddressInfoCell
        cell.updateWithAddress(address: self.dataList![indexPath.row])
        cell.editClosure = { //编辑回调
            () -> Void in
            let myInfoVC:BMMyInfoViewController = self.getViewController() as! BMMyInfoViewController
            
            let editAddressVC:BMEditCommonAddressViewController = BMEditCommonAddressViewController(withCommonAddress: self.dataList![indexPath.row])
            myInfoVC.navigationController?.pushViewController(editAddressVC, animated: true)
        }
        
        cell.deleteClosure = { //删除回调
            () -> Void in
            
            let vc:BMMyInfoViewController =  self.getViewController() as! BMMyInfoViewController
            vc.present(self.alertController, animated: true, completion: nil)
            
            
        }
        return cell
    }
    
    //MARK: UITabelView - Delegate
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell:BMCommonAddressInfoCell = tableView.cellForRow(at: indexPath) as! BMCommonAddressInfoCell
        cell.rightWidthConstraint.constant = 110
        cell.leftLeadingConstraint.constant = -110
        UIView.animate(withDuration: 0.3) {
            cell.layoutIfNeeded()
        }
    }
    
    public func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell:BMCommonAddressInfoCell = tableView.cellForRow(at: indexPath) as! BMCommonAddressInfoCell
        cell.rightWidthConstraint.constant = 0
        cell.leftLeadingConstraint.constant = 0
        UIView.animate(withDuration: 0.3) {
            cell.layoutIfNeeded()
        }
    }
    
    
    // MARK: - TBEmptyDataSetDataSource
    
    func imageForEmptyDataSet(in scrollView: UIScrollView) -> UIImage? {
        return UIImage(named: "empty_address")
    }
    
    func backgroundColorForEmptyDataSet(in scrollView: UIScrollView) -> UIColor? {
        return UIColor(hex: BMBacgroundColor)
    }
    

    //新增地址点击事件
    func addAddressClick(sender: UIButton) {
        
        let myInfoVC:BMMyInfoViewController = self.getViewController() as! BMMyInfoViewController
        
        let editAddressVC:BMEditCommonAddressViewController = BMEditCommonAddressViewController()
        myInfoVC.navigationController?.pushViewController(editAddressVC, animated: true)
    }
}
