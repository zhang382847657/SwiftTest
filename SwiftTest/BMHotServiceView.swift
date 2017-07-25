//
//  BMHotServiceView.swift
//  SwiftTest
//  热门服务
//  Created by 张琳 on 2017/7/7.
//  Copyright © 2017年 张琳. All rights reserved.
//


import UIKit
import SwiftyJSON



class BMHotServiceView: UIView {
    
    var headerView: UIView! //头部视图
    var contentView: UIView! //内容视图
    
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        
        ///////////头部视图////////////
        self.headerView = UIView(frame: CGRect.zero)
        self.addSubview(headerView)
        
        let titleTextLable = UILabel(frame: CGRect.zero)
        titleTextLable.text = "热门服务"
        titleTextLable.font = UIFont.systemFont(ofSize: BMTitleFontSize)
        titleTextLable.textAlignment = .center
        titleTextLable.textColor = UIColor.colorWithHexString(hex: BMTitleColor)
        self.headerView.addSubview(titleTextLable)
        
        let subTextLable = UILabel(frame: CGRect.zero)
        subTextLable.text = "精挑细选  品质服务"
        subTextLable.font = UIFont.systemFont(ofSize: BMSmallTitleFontSize)
        subTextLable.textColor = UIColor.colorWithHexString(hex: BMSmallTitleColor)
        subTextLable.textAlignment = .center
        self.headerView.addSubview(subTextLable)
        
        self.headerView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(self)
        }
        
        titleTextLable.snp.makeConstraints { (make) in
            
            make.left.right.equalTo(self.headerView)
            make.top.equalTo(self.headerView).offset(20)
        }
        
        subTextLable.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.headerView)
            make.top.equalTo(titleTextLable.snp.bottom).offset(8)
            make.bottom.equalTo(self.headerView.snp.bottom).offset(-10)
        }
        
        
        /////内容视图//////
        self.contentView = UIView(frame: CGRect.zero)
        self.addSubview(self.contentView)
        self.contentView.snp.makeConstraints { (make) in
            make.top.equalTo(self.headerView.snp.bottom)
            make.left.equalTo(self).offset(10)
            make.right.equalTo(self).offset(-10)
            make.bottom.equalTo(self)
        }
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func updateUIWithProduct(products:JSON) {
        
        let dataList:Array? = products.array
        if let dataList = dataList{
            
            var lastView:UIView? = nil
            
            for (index,_) in dataList.enumerated(){
                
                let cellView:BMHotServiceCellView = UIView.loadViewFromNib(nibName: "BMHotServiceCellView") as! BMHotServiceCellView
                cellView.updateUIWithProduct(products: dataList[index])
                self.contentView.addSubview(cellView)
                
                if let lastView = lastView{
                    
                    cellView.snp.makeConstraints({ (make) in
                        make.top.equalTo(lastView.snp.bottom).offset(10)
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
                        make.bottom.equalTo(self.contentView.snp.bottom)
                        
                    })
                    
                }else {
                    let view:BMHotServiceCellView = self.contentView.subviews[self.contentView.subviews.count-2] as! BMHotServiceCellView
                    
                    lastView?.snp.remakeConstraints({ (make) in
                        make.top.equalTo(view.snp.bottom).offset(10)
                        make.left.right.equalTo(self.contentView)
                        make.bottom.equalTo(self.contentView.snp.bottom).offset(-10)
                        
                    })
                }
            }
        }
        
        
        
    }
    
    
    
    
    
}




