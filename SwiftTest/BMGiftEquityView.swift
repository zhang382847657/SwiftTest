//
//  BMGiftEquityView.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/7/24.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit
import SwiftyJSON

typealias GiftEquityBackClickClosure = () -> Void

class BMGiftEquityView: UIView {

    @IBOutlet weak var scrollView: UIScrollView!
    var contentView: UIView!
    
    var giftEquityBackClickClosure: GiftEquityBackClickClosure? //赠送权益返回点击回调
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView = UIView(frame: CGRect.zero)
        self.scrollView.addSubview(self.contentView)
        
        self.contentView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.scrollView)
            make.width.equalTo(self.scrollView.snp.width)
            make.height.greaterThanOrEqualTo(0);//此处保证容器View高度的动态变化 大于等于0的高度
        }
    }

    //返回点击事件
    @IBAction func backClick(_ sender: UIButton) {
        
        if let _ = self.giftEquityBackClickClosure {
            self.giftEquityBackClickClosure!()
        }
    }
    
    func updatUIWithCoupons(coupons:JSON){
        
        for view in self.contentView.subviews{
            view.removeFromSuperview()
        }
        
        let dataList:Array? = coupons.array
        
        if let dataList = dataList{
            
            var lastView:UIView? = nil
            
            for (_,value) in dataList.enumerated(){
                
                let cellView:BMGiftEquityCellView = UIView.loadViewFromNib(nibName: "BMGiftEquityCellView") as! BMGiftEquityCellView
                cellView.updataUIWithCoupon(coupon: value)
                self.contentView.addSubview(cellView)
                
                if let lastView = lastView{
                    
                    cellView.snp.makeConstraints({ (make) in
                        make.top.equalTo(lastView.snp.bottom).offset(10)
                        make.left.equalTo(self.contentView).offset(20)
                        make.right.equalTo(self.contentView).offset(-20)
                        make.height.equalTo(61)
                    })
                    
                }else{
                    cellView.snp.makeConstraints({ (make) in
                        make.top.equalTo(self.contentView.snp.top)
                        make.left.equalTo(self.contentView).offset(20)
                        make.right.equalTo(self.contentView).offset(-20)
                        make.height.equalTo(61)
                    })
                }
                
                lastView = cellView
                
            }
            
            if self.contentView.subviews.count > 0 {
                
                if self.contentView.subviews.count == 1 {
                    
                    lastView?.snp.remakeConstraints({ (make) in
                        make.top.equalTo(self.contentView.snp.top)
                        make.left.equalTo(self.contentView).offset(20)
                        make.right.equalTo(self.contentView).offset(-20)
                        make.bottom.equalTo(self.contentView.snp.bottom).offset(-10)
                        make.height.equalTo(61)
                        
                    })
                    
                }else {
                    let view:BMGiftEquityCellView = self.contentView.subviews[self.contentView.subviews.count-2] as! BMGiftEquityCellView
                    
                    lastView?.snp.remakeConstraints({ (make) in
                        make.top.equalTo(view.snp.bottom).offset(10)
                        make.left.equalTo(self.contentView).offset(20)
                        make.right.equalTo(self.contentView).offset(-20)
                        make.bottom.equalTo(self.contentView.snp.bottom).offset(-10)
                        make.height.equalTo(61)
                    })
                }
            }
        }
        
    }
}
