//
//  BMCardsViewController.swift
//  SwiftTest
//  卡包
//  Created by 张琳 on 2017/8/10.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit
import TBEmptyDataSet
import DGElasticPullToRefresh
import SwiftyJSON

class BMCardsViewController: UITableViewController,TBEmptyDataSetDelegate,TBEmptyDataSetDataSource {

    
    var acctCardList:Array<JSON>? = nil //套擦卡数据源
    var memberCard:JSON? = nil //会员卡数据源
    var prepaidCardList:Array<JSON>? = nil //储值卡数据源
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        self.title = "卡包"
        self.tableView.backgroundColor = UIColor.colorWithHexString(hex: BMBacgroundColor)
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none  //去掉分割线
        self.tableView.rowHeight = 75
        self.tableView.tableFooterView = UIView()
        self.tableView.register(UINib(nibName: "BMCardsCell", bundle: nil), forCellReuseIdentifier: "BMCardsCell")
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
    
    
    /**
     * 请求数据
     */
    func loadData() {
        
        //////////////请求所有商品类目///////////////////
        let url = "\(BMHOST)/cuserCardPack/query"
        let params = ["":""]
        
        NetworkRequest.sharedInstance.postRequest(urlString: url, params: params, isLogin: true, success: { (value) in
            
            self.tableView.dg_stopLoading()  //停止刷新动画
            self.prepaidCardList = value["prepaidCard"].array //储值卡
            self.memberCard = value["card"]  //会员卡
            self.acctCardList = value["acctCard"].array //套餐卡
            self.tableView.reloadData()  //刷新数据源
            
            
        }) { (error) in
            
            
        }
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        var count:Int = 0
        if let _ = self.acctCardList{
            count += 1
        }
        if let _ = self.memberCard{
            count += 1
        }
        if let _ = self.acctCardList{
            count += 1
        }
        
        return count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        switch section {
        case 0:
            if let acctCardList = self.acctCardList{  //套餐卡
                return acctCardList.count
            }
        case 1:
            if let prepaidCardList = self.prepaidCardList{  //储值卡
                return prepaidCardList.count
            }
        case 2:
            if let _ = self.memberCard{  //会员卡
                return 1
            }
        default:
            return 0
        }
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        return 44
    }

    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:BMCardsCell = tableView.dequeueReusableCell(withIdentifier: "BMCardsCell", for: indexPath) as! BMCardsCell
        
        
        switch indexPath.section {
        case 0:
            if let acctCardList = self.acctCardList{
                cell.updateWithComboCard(comboCard: acctCardList[indexPath.row])  //套餐卡
            }
        case 1:
            if let prepaidCardList = self.prepaidCardList{
                cell.updateWithStoreCard(storeCard: prepaidCardList[indexPath.row])  //储值卡
            }
        case 2:
            if let memberCard = self.memberCard{
                cell.updateWithMemberCard(memberCard: memberCard)  //会员卡
            }
        default: break
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 44))
        //view.backgroundColor = UIColor.white
        
        let titleLabel:UILabel = UILabel(frame: CGRect.zero)
        titleLabel.textColor = UIColor.colorWithHexString(hex: BMSubTitleColor)
        titleLabel.font = UIFont.systemFont(ofSize: BMTitleFontSize)
        view.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(view)
            make.left.equalTo(view).offset(10)
        }
        
        switch section {
        case 0:
            titleLabel.text = "套餐卡"
            return view
        case 1:
            titleLabel.text = "储值卡"
            return view
        case 2:
            titleLabel.text = "会员卡"
            return view
        default:
            return nil
        }
        
    }
    
    
    // MARK: - TBEmptyDataSetDataSource
    
    func imageForEmptyDataSet(in scrollView: UIScrollView) -> UIImage? {
        
        return UIImage(named: "empty")
    }
    
    func titleForEmptyDataSet(in scrollView: UIScrollView) -> NSAttributedString? {
        
        return NSAttributedString(string: "暂无数据")
    }



   
}
