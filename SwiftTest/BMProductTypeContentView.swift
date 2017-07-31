//
//  BMProductTypeContentView.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/7/7.
//  Copyright © 2017年 张琳. All rights reserved.
//


import UIKit
import SwiftyJSON
import AlamofireImage

//定义闭包类型（特定的函数类型函数类型）
typealias ProductClickClosureType = (_ product:JSON) -> Void

class BMProductTypeContentView: UIView {
    
    
    var products:Array<JSON>!  //商品数组
    var productClickClosure: ProductClickClosureType? //接收上个页面传过来的闭包块
    
    
    
    func updateUIWithProducts(products:ArraySlice<JSON>){
        
        let cellWidth:CGFloat = self.frame.size.width/4.0
        
        let newArray:Array<JSON> = Array(products)
        
        self.products = newArray
    
        
        for i in 0..<2{  //两行
            
            for y in 0..<4{  //四列
                
            
                /////包裹图片文字的视图////
                let view = UIView(frame: CGRect(x: CGFloat(y)*cellWidth, y: CGFloat(i)*cellWidth, width: cellWidth, height: cellWidth))
                view.tag = i*4+y //设置tag为数组的下标
                view.isUserInteractionEnabled = true
                self.addSubview(view)
                
                if i == 0 {
                    view.addBorderLayer(color: UIColor.colorWithHexString(hex: BMBorderColor), size: BMBorderSize, boderType: .bottom) //给第一行视图的添加底部的边框
                }
                
                if y != 3 {
                    view.addBorderLayer(color: UIColor.colorWithHexString(hex: BMBorderColor), size: BMBorderSize, boderType: .right) //除了每一行最后一个视图，其他的都给视图添加右侧边框
                }
            
            
                /////图片////
                let imageView = UIImageView(frame: CGRect.zero)
                imageView.contentMode = .scaleAspectFit
                view.addSubview(imageView)
                imageView.snp.makeConstraints({ (make) in
                    make.centerX.equalTo(view.snp.centerX)
                    make.width.height.equalTo(28)
                    make.centerY.equalTo(view.snp.centerY).offset(-15)
                })
                
                /////文字/////
                let label = UILabel(frame: CGRect.zero)
                label.font = UIFont.systemFont(ofSize: BMSubTitleFontSize)
                label.textColor = UIColor.colorWithHexString(hex: BMTitleColor)
                label.textAlignment = .center
                view.addSubview(label)
                label.snp.makeConstraints({ (make) in
                    make.centerX.equalTo(view.snp.centerX)
                    make.centerY.equalTo(view.snp.centerY).offset(15)
                    make.left.equalTo(view).offset(3)
                    make.right.equalTo(view).offset(-3)
                })
                
                
                /////点击手势////
                let singleTap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(productClick))  //点击手势
                view.addGestureRecognizer(singleTap) //给每一个视图添加一个点击的事件
                
                
                
                if 4*i+y <= newArray.count-1 { //防止下标越界
                    
                    
                    let name:String? = newArray[4*i+y]["name"].string  //商品名称
                    let url:String? = newArray[4*i+y]["icon"].string   //商品图标
                    
                    
                    if let url = url {
                        imageView.af_setImage(withURL: URL(string: url)!, placeholderImage: UIImage(named: "tybj")!)
                    }
                    
                    
                    
                    if let name = name{
                        
                        var nameStr:NSString = name as NSString
                        
                        if nameStr.length > 5 { //如果文字长度超过五个字，就用省略号显示
                            nameStr = "\(nameStr.substring(to: 4))..." as NSString
                        }
                        
                        label.text = name

                    }
                }
                
                
            }
            
        }
        
    }
    
    
    
    //商品点击事件
    func productClick(sender:UITapGestureRecognizer){
        
        dPrint(item: "点击了")
        
        let view:UIView? = sender.view
        
        if let view = view {
            dPrint(item: view.tag)
            
            if let _ = self.productClickClosure {
                self.productClickClosure!(self.products[view.tag])
            }
        }
    
    }
    
}


