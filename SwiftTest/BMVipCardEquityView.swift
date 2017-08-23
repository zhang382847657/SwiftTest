//
//  BMVipCardEquityView.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/8/21.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit
import SwiftyJSON

class BMVipCardEquityView: UIView {
    
    var titleLabel:UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        ////////////标题/////////////////
        self.titleLabel = UILabel(frame: CGRect.zero)
        self.titleLabel.text = "您可以享受以下权益"
        self.titleLabel.textAlignment = .center
        self.titleLabel.textColor = UIColor.colorWithHexString(hex: BMSmallTitleColor)
        self.titleLabel.font = UIFont.systemFont(ofSize: BMSubTitleFontSize)
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self)
            make.height.equalTo(46)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func updateWithPriceOffList(priceOffList:Array<JSON>?, cardCouponBOList:Array<JSON>?){
        
        for view in self.subviews{  //先删除所有子视图
            if view is BMVipCardEquityCellView{
                view.removeFromSuperview()
            }
        }
        
        if let priceOffList = priceOffList, priceOffList.count > 0{
            
            for i in 0..<priceOffList.count{
                
                let productBOList:Array<JSON> = priceOffList[i]["productBOList"].arrayValue
                let percent:Float = priceOffList[i]["percent"].floatValue
                
                var productNames:Array<String> = []
                for product in productBOList {
                    productNames.append(product["name"].stringValue)
                }
                
                
                let view:BMVipCardEquityCellView = BMVipCardEquityCellView(title: "部分商品\(percent)折优惠", content: productNames.joined(separator: "、"))
                self.addSubview(view)
                
                view.snp.makeConstraints { (make) in
                    make.left.right.equalTo(self)
                    
                    
                    if i == 0 {
                        make.top.equalTo(self.titleLabel.snp.bottom)
                    }else{
                        let lastView = self.subviews[i] as? BMVipCardEquityCellView
                        make.top.equalTo(lastView!.snp.bottom)
                    }
                    
                }
            }
            
            
            let lastView = self.subviews.last
            
            if let cardCouponBOList = cardCouponBOList , cardCouponBOList.count > 0{
                
                var couponNames:Array<String> = []
                for coupon in cardCouponBOList{
                    
                    let titleString:String = coupon["couponPublishBo"]["title"].stringValue
                    let num:Int = coupon["num"].intValue
                    couponNames.append("\(titleString) \(num)张")
                }
                
                let view:BMVipCardEquityCellView = BMVipCardEquityCellView(title: "赠送优惠券", content: couponNames.joined(separator: "、"))
                self.addSubview(view)
                
                view.snp.makeConstraints({ (make) in
                    make.left.right.equalTo(self)
                    make.top.equalTo(lastView!.snp.bottom)
                    make.bottom.equalTo(self)
                })
                
            }else{
                lastView?.snp.makeConstraints({ (make) in
                    make.bottom.equalTo(self)
                })
            }
            
            
            
        }else{
            
            if let cardCouponBOList = cardCouponBOList, cardCouponBOList.count > 0{
                
                var couponNames:Array<String> = []
                for coupon in cardCouponBOList{
                    
                    let titleString:String = coupon["couponPublishBo"]["title"].stringValue
                    let num:Int = coupon["num"].intValue
                    couponNames.append("\(titleString) \(num)张")
                }
                
                let view:BMVipCardEquityCellView = BMVipCardEquityCellView(title: "赠送优惠券", content: couponNames.joined(separator: "、"))
                self.addSubview(view)
                
                view.snp.makeConstraints({ (make) in
                    make.left.right.equalTo(self)
                    make.top.equalTo(self.titleLabel.snp.bottom)
                    make.bottom.equalTo(self)
                })
                
            }else{
                self.titleLabel.text = nil
                self.titleLabel.snp.makeConstraints({ (make) in
                    make.height.equalTo(0)
                    make.bottom.equalTo(self)
                })
            }
            
        }
        
        
        
        
    }
    

}
