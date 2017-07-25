//
//  BMComboCardRecommendView.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/6/23.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit
import SwiftyJSON
import SnapKit
import AlamofireImage

class BMComboCardRecommendView: UIView {

    
    var contentView : UIView! //内容视图
    var topView : UIImageView! //顶部图片视图
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        self.topView = UIImageView(image: UIImage(named: "cztck"))
        self.addSubview(self.topView)
        
        self.contentView = UIView()
        self.addSubview(self.contentView)
        
    
        
        self.topView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(self).offset(8)
        }
        
        self.contentView.snp.makeConstraints { (make) in
            make.top.equalTo(self.topView.snp.bottom).offset(8)
            make.left.right.bottom.equalTo(self)
        }
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func updateUIWithComboCards(comboCards:JSON) {
        
        
        if self.contentView != nil {
            
            
            var tmp:UIView? = nil
            
            let listData:Array? = comboCards.arrayObject
            
            if let listData = listData {
                
                for (index,_) in listData.enumerated(){
                    
                    
                    let packageCardItem:JSON? = comboCards[index]["packageCardItemBOList"][0];//商品信息
                    let titleStr:String? = comboCards[index]["name"].string //商品标题内容
                    var subTitleStr:String? = "" //商品副标题内容
                    var descripStr:String? = "" //商品描述
                    let salePrice:Float? = comboCards[index]["salePrice"].float //套餐价格
                    if let packageCardItem = packageCardItem{
                        let itemNum:Int? = packageCardItem["itemNum"].int
                        let unitName:String? = packageCardItem["unitName"].string
                        let name:String? = packageCardItem["name"].string
                        var goodsName:String? = packageCardItem["goodsName"].string
                        let times:Int? = packageCardItem["times"].int
                        if let name = name, let times = times {
                            
                            if(unitName != "次"){
                                if let itemNum = itemNum,let unitName = unitName{
                                    descripStr = "，每次清洁\(itemNum)\(unitName)"
                                    goodsName = ""
                                }
                            }
                            subTitleStr = "包含\(name)\(goodsName!)服务\(times)次\(descripStr!)"
                        }
                    }
                    
                    
                    //每一个cell的视图
                    let tmpView = UIView(frame:CGRect.zero)
                    self.contentView.addSubview(tmpView)
                    
                    //cell左侧视图
                    let leftView = UIView(frame: CGRect.zero)
                    tmpView.addSubview(leftView)
                    
                    //cell左侧视图上的图片
                    let imageView = UIImageView(frame:CGRect.zero)
                    imageView.contentMode = .scaleAspectFill
                    imageView.af_setImage(withURL: URL(string: comboCards[index]["icon"].string!)!, placeholderImage: UIImage(named: "tybj")!)
                    leftView.addSubview(imageView)
                    
                    
                    //cell右侧视图
                    let rightView = UIView(frame:CGRect.zero)
                    tmpView.addSubview(rightView)
                    
                    //右侧视图上的套餐卡标题
                    let titleLabel = UILabel(frame: CGRect.zero)
                    titleLabel.font = UIFont.systemFont(ofSize: BMSubTitleFontSize)
                    titleLabel.textColor = UIColor.colorWithHexString(hex: BMTitleColor)
                    if let titleStr = titleStr{
                        titleLabel.text = titleStr
                    }
                    rightView.addSubview(titleLabel)
                    
                    //右侧视图上的套餐卡副标题
                    let subLabel = UILabel(frame: CGRect.zero)
                    subLabel.font = UIFont.systemFont(ofSize: BMSmallTitleFontSize)
                    subLabel.textColor = UIColor.colorWithHexString(hex: BMSubTitleColor)
                    subLabel.text = subTitleStr
                    rightView.addSubview(subLabel)
                    
                    
                    
                    //右侧视图上套餐卡的价格
                    let priceLabel = UILabel(frame: CGRect.zero)
                    priceLabel.font = UIFont.systemFont(ofSize: BMSubTitleFontSize)
                    priceLabel.textColor = UIColor.red
                    if let salePrice = salePrice{
                        priceLabel.text = "¥\(salePrice)"
                    }
                    rightView.addSubview(priceLabel)
                    
                    
                    if tmp == nil {
                        
                        tmpView.snp.makeConstraints({ (make) in
                            make.top.equalTo(self.contentView.snp.top).offset(3)
                            make.left.equalTo(self.contentView.snp.left).offset(15)
                            make.right.equalTo(self.contentView.snp.right).offset(-15)
                            
                        })
                        
                    }else{
                        tmpView.snp.makeConstraints({ (make) in
                            make.top.equalTo((tmp?.snp.bottom)!)
                            make.left.equalTo(self.contentView.snp.left).offset(15)
                            make.right.equalTo(self.contentView.snp.right).offset(-15)
                        })
                        
                    }
                    
                    
                    leftView.snp.makeConstraints({ (make) in
                        make.height.width.equalTo(60)
                        make.top.equalTo(tmpView.snp.top).offset(13)
                        make.left.equalTo(tmpView.snp.left)
                        make.bottom.equalTo(tmpView.snp.bottom).offset(-12)
                        make.right.equalTo(rightView.snp.left).offset(-15)
                        
                    })
                    
                    imageView.snp.makeConstraints({ (make) in
                        make.height.width.equalTo(30)
                        make.center.equalTo(leftView.snp.center)
                    })
                    
                    rightView.snp.makeConstraints({ (make) in
                        make.height.equalTo(leftView)
                        make.top.equalTo(leftView.snp.top)
                        make.bottom.equalTo(leftView.snp.bottom)
                        make.right.equalTo(tmpView.snp.right)
                    })
                    
                    
                    titleLabel.snp.makeConstraints({ (make) in
                        make.top.left.right.equalTo(rightView)
                        make.height.equalTo(20)
                    })
                    subLabel.snp.makeConstraints({ (make) in
                        make.top.equalTo(titleLabel.snp.bottom)
                        make.left.right.equalTo(rightView)
                        make.height.equalTo(titleLabel)
                    })
                    priceLabel.snp.makeConstraints({ (make) in
                        make.top.equalTo(subLabel.snp.bottom)
                        make.left.right.equalTo(rightView)
                        make.height.equalTo(subLabel)
                    })
                    
                    tmp = tmpView
                    
                    
                }
                
                if self.contentView.subviews.count > 0 {
                    
                    
                    if self.contentView.subviews.count == 1 {
                        
                        tmp?.snp.remakeConstraints({ (make) in
                            make.top.equalTo(self.contentView.snp.top)
                            make.left.equalTo(self.contentView.snp.left).offset(15)
                            make.right.equalTo(self.contentView.snp.right).offset(-15)
                            make.bottom.equalTo(self.contentView.snp.bottom).offset(-8)
                            
                        })
                        
                    }else {
                        let lastView:UIView = self.contentView.subviews[self.contentView.subviews.count-2]
                        
                        tmp?.snp.remakeConstraints({ (make) in
                            make.top.equalTo(lastView.snp.bottom)
                            make.left.equalTo(self.contentView.snp.left).offset(15)
                            make.right.equalTo(self.contentView.snp.right).offset(-15)
                            make.bottom.equalTo(self.contentView.snp.bottom).offset(-8)
                            
                        })
                    }
                }
  
            }else{
                dPrint(item: "没有推荐的套餐卡")
                
            }
        }
        
    }

}
