//
//  BMNearesStoreView.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/6/26.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit
import SwiftyJSON

//定义闭包类型（特定的函数类型函数类型）
typealias StoreClickClosureType = () -> Void

class BMNearesStoreView: UIView {

    var headerView:UIView! //头部视图
    var contentView:UIView! //内容视图
    var cellView:BMNearestStoreCellView! //某一行Cell视图
    var storeClickClosure: StoreClickClosureType? //接收上个页面传过来的闭包块
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        
        ///////////头部视图//////////////
        self.headerView = UIView(frame: CGRect.zero)
        self.addSubview(self.headerView)
        self.headerView.snp.makeConstraints { (make) in
            make.height.equalTo(42)
            make.left.right.top.equalTo(self)
        }
        
        let headerLeftLabel:UILabel = UILabel(frame: CGRect.zero)
        headerLeftLabel.text = "最近门店"
        headerLeftLabel.font = UIFont.systemFont(ofSize: BMTitleFontSize)
        headerLeftLabel.textColor = UIColor.colorWithHexString(hex: BMTitleColor)
        self.headerView.addSubview(headerLeftLabel)
        
        headerLeftLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.headerView).offset(15)
            make.top.bottom.equalTo(self.headerView)
        }
        
        
        let moreButton = UIButton(type: .system)
        moreButton.frame = CGRect.zero
        moreButton.setTitle("更多 >", for: .normal)
        moreButton.setTitleColor(UIColor.colorWithHexString(hex: BMSmallTitleColor), for: .normal)
        moreButton.titleLabel?.font = UIFont.systemFont(ofSize: BMSubTitleFontSize)
        moreButton.contentHorizontalAlignment = .right
        moreButton.addTarget(self, action: #selector(moreClick(sender:)), for: .touchUpInside)
        self.headerView.addSubview(moreButton)
        
        moreButton.snp.makeConstraints { (make) in
            make.right.equalTo(self.headerView.snp.right).offset(-15)
            make.top.bottom.equalTo(self.headerView)
        }
        
        ////////////内容视图//////////////
        self.contentView = UIView()
        self.addSubview(self.contentView)
        self.contentView.snp.makeConstraints { (make) in
            make.top.equalTo(self.headerView.snp.bottom)
            make.left.right.bottom.equalTo(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func updateUIWithNearesStores(nearesStores:JSON) {
        
        let dataList:Array? = nearesStores.array
        if let dataList = dataList{
            
            var lastView:BMNearestStoreCellView? = nil
            
            for (index,_) in dataList.enumerated(){
                
                let cellView:BMNearestStoreCellView = UIView.loadViewFromNib(nibName: "BMNearestStoreCellView") as! BMNearestStoreCellView
                cellView.updateUIWithStore(store: dataList[index])
                self.contentView.addSubview(cellView)
                
                if let lastView = lastView{
                    
                    cellView.snp.makeConstraints({ (make) in
                        make.top.equalTo(lastView.snp.bottom)
                        make.left.right.equalTo(self.contentView)
                    })
                    
                }else{
                    cellView.snp.makeConstraints({ (make) in
                        make.top.equalTo(self.contentView.snp.top)
                        make.left.right.equalTo(self.contentView)
                    })
                }
                
                lastView = cellView

            }
            
            if self.contentView.subviews.count > 0 {
                
                if self.contentView.subviews.count == 1 {
                    
                    lastView?.snp.remakeConstraints({ (make) in
                        make.top.equalTo(self.contentView.snp.top)
                        make.left.right.equalTo(self.contentView)
                        make.bottom.equalTo(self.contentView.snp.bottom).offset(-8)
                        
                    })
                    
                }else {
                    let view:BMNearestStoreCellView = self.contentView.subviews[self.contentView.subviews.count-2] as! BMNearestStoreCellView
                    
                    lastView?.snp.remakeConstraints({ (make) in
                        make.top.equalTo(view.snp.bottom)
                        make.left.right.equalTo(self.contentView)
                        make.bottom.equalTo(self.contentView.snp.bottom)
                        
                    })
                }
            }
        }
    }
    
    /**
    *  查看更多门店点击事件
    */
    func moreClick(sender:UIButton) {
        
        if let _ = self.storeClickClosure {
                self.storeClickClosure!()
        }
        
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.headerView.addBorderLayer(color: UIColor(hex:BMBorderColor), size: BMBorderSize, boderType: BorderType.bottom)
    }


}
