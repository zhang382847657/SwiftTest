//
//  BMOrderCell.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/8/23.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit
import SwiftyJSON

class BMOrderCell: UITableViewCell {

    @IBOutlet weak var productImageView: UIImageView! //商品图标
    @IBOutlet weak var productNameLabel: UILabel!  //商品名字
    @IBOutlet weak var priceLabel: UILabel!  //商品合计
    @IBOutlet weak var timeLabel: UILabel!  //创建时间
    @IBOutlet weak var orderStateImageView: UIImageView!  //订单状态
    @IBOutlet weak var orderTypeLabel: UILabel! //订单类型
    
    @IBOutlet weak var bottomView: BMOrderBottomView! //底部视图
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.orderTypeLabel.layer.cornerRadius = 3
        self.orderTypeLabel.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    
    /**
     *  更新保洁和家政类型的单子
     */
    func updateWithHouseAndClean(product:JSON){
        
        let cateId:Int? = product["cateId"].int //1家政 2保洁
        let status:Int? = product["status"].int //订单状态
        let flowStatus:String? = product["flowStatus"].string //
        let serviceType:Int? = product["serviceType"].int //服务类型
        let productName:String? = product["productName"].string  //商品名字
        let cmidFee:Float? = product["cmidFee"].float  //费用
        let ctime:Int? = product["ctime"].int  //创建时间
        
        var canPay:Bool = false  //是否显示付款
        var canCancel:Bool = false  //是否显示申请取消
        var showAunt:Bool = false //是否显示阿姨
        var showEvaluate:Bool = false //是否显示评价
        var showContract:Bool = false //是否显示查看合同
        
    
        self.productImageView?.image = UIImage(named:Config.productByItemId(itemId: serviceType)["icon"]!)
        self.orderTypeLabel.isHidden = true //隐藏订单类型
        
        if let productName = productName{
            self.productNameLabel.text = productName
        }else{
            self.productNameLabel.text = "暂无商品名字"
        }
        
        
        if let cmidFee = cmidFee{
            self.priceLabel.attributedText = NSMutableAttributedString.setLabelText(text: "合计：￥\(cmidFee)", frontFontSize: BMSmallTitleFontSize, frontColor: UIColor.colorWithHexString(hex: BMSmallTitleColor), frontRange: NSRange(location: 0, length: 3), behindTextFontSize: nil, behindColor: nil, behindRange: nil)
            
        }else{
            self.priceLabel.attributedText = NSMutableAttributedString.setLabelText(text: "合计：￥0", frontFontSize: BMSmallTitleFontSize, frontColor: UIColor.colorWithHexString(hex: BMSmallTitleColor), frontRange: NSRange(location: 0, length: 3), behindTextFontSize: nil, behindColor: nil, behindRange: nil)
        }
        
        
        if let ctime = ctime{
            self.timeLabel.text = "创建时间：\(timeFormattingWithStamp(timeStamp: ctime, format: "YYYY-MM-DD HH:mm:ss"))"
        }else{
            self.timeLabel.text = "创建时间：--"
        }
        
        if let cateId = cateId, let status = status, let flowStatus = flowStatus{
            if cateId == 1{  //家政单
                
                if flowStatus == "pending_interview" || flowStatus == "pending_signed"
                    || flowStatus == "pending_pay"  || flowStatus == "complete" {
                    showAunt = true
                }
                
                if flowStatus == "pending_pay"  || flowStatus == "complete" {
                    showContract = true
                }
                
                if status != 9 && status != 8 { //订单未关闭
                    
                    switch flowStatus {
                    case "pending_take_trade": //待接单
                        self.orderStateImageView.image = UIImage(named: "daijiedan")
                        canCancel = true
                    case "pending_choice_aunt": //待选择阿姨
                        self.orderStateImageView.image = UIImage(named: "daimianshi")
                        canCancel = true
                    case "pending_interview": //待面试
                        self.orderStateImageView.image = UIImage(named: "daimianshi")
                        canCancel = true
                    case "pending_signed": //待签订合同
                        self.orderStateImageView.image = UIImage(named: "daiqianyue")
                        canCancel = true
                    case "pending_pay:": //服务中
                        self.orderStateImageView.image = UIImage(named: "yipaigong")
                        if let cmidFee = cmidFee,cmidFee > 0 {
                            canPay = true
                        }
                    case "complete": //服务完成
                        if let cmidFee = cmidFee,cmidFee > 0 {
                            canPay = true
                        }
                    default:
                        break
                    }
                }
                
            }else if cateId == 2{ //保洁单
                
                if flowStatus == "pending_complete"  || flowStatus == "complete" {
                    showAunt = true
                }
                
                if flowStatus == "complete" {
                    showEvaluate = true
                }
                
                if status != 9 && status != 8 { //订单未关闭
                    
                    switch flowStatus {
                    case "pending_take_trade": //待接单
                        self.orderStateImageView.image = UIImage(named: "daijiedan")
                        canCancel = true
                    case "pending_pay": //待付款
                        self.orderStateImageView.image = UIImage(named: "daifukuan")
                        canCancel = true
                        if let cmidFee = cmidFee,cmidFee > 0 {
                            canPay = true
                        }
                    case "pending_choice_aunt": //已派工
                        self.orderStateImageView.image = UIImage(named: "yipaigong")
                        canCancel = true
                        if let cmidFee = cmidFee,cmidFee > 0 {
                            canPay = true
                        }
                    case "pending_complete": //已完成
                        self.orderStateImageView.image = UIImage(named: "yiwancheng")
                        canCancel = true
                        if let cmidFee = cmidFee,cmidFee > 0 {
                            canPay = true
                        }
                    case "complete": //服务完成
                        canCancel = true
                    default:  //其他都是已接单
                        self.orderStateImageView.image = UIImage(named: "daijiedan")
                        canCancel = true
                    }
                }
            }
        }
        
        self.bottomView.updateWithShowPay(showCancel: canCancel, showAunt: showAunt, showContract: showContract, showEvaluate: showEvaluate, showPay: canPay, evaluateState: product["evaluateState"].int, tradeNo:product["tradeNo"].stringValue, flowStatus:flowStatus!)
        
    }
    
    
    /**
     *  更新售后类型的单子
     */
    func updateWithAfterSale(product:JSON){
        
        let serviceType:Int? = product["serviceType"].int
        let productName:String? = product["productName"].string
        let beginTime:Int? = product["beginTime"].int
        let orderType:Int? = product["orderType"].int //订单类型 1服务 2质保
        
        self.productImageView?.image = UIImage(named:Config.productByItemId(itemId: serviceType)["icon"]!)
        
        if let productName = productName{
            self.productNameLabel.text = productName
        }else{
            self.productNameLabel.text = "暂无商品名字"
        }
        
        self.priceLabel.text = nil //不显示合计
        
        
        if let beginTime = beginTime{
            self.timeLabel.text = "创建时间：\(timeFormattingWithStamp(timeStamp: beginTime, format: "YYYY-MM-DD HH:mm:ss"))"
        }else{
            self.timeLabel.text = "创建时间：--"
        }
        
        if let orderType = orderType{
            
            if orderType == 1 { //服务单
                self.orderTypeLabel.isHidden = false
                self.orderTypeLabel.text = "服务"
                self.orderTypeLabel.backgroundColor = UIColor.colorWithHexString(hex: "#70be12")
                
            }else if orderType == 2 {  //质保单
                self.orderTypeLabel.isHidden = false
                self.orderTypeLabel.text = "质保"
                self.orderTypeLabel.backgroundColor = UIColor.colorWithHexString(hex: "#df2020c")
                
            }
            
        }
    }
    
}
