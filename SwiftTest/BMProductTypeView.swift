//
//  BMProductTypeView.swift
//  SwiftTest
//  商品类目视图  轮播视图，一页显示两行，每行4个商品
//  Created by 张琳 on 2017/7/7.
//  Copyright © 2017年 张琳. All rights reserved.
//


import UIKit
import SwiftyJSON


//定义闭包类型（特定的函数类型函数类型）
typealias ProductClickClosure = (_ product:JSON) -> Void


class BMProductTypeView: UIView,UIScrollViewDelegate {
    
    var scrollView: UIScrollView! //滚动视图
    var contentView: UIView! //滚动视图的内容视图
    var pageControl: UIPageControl! //分页器
    
    let margin:CGFloat = 15  //左右边距
    let cellHeight = (kScreenWidth - 15*2)/4 //单行行高
    
    var productClickClosure: ProductClickClosure? //接收上个页面传过来的闭包块
    
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        
        
        //////////////滚动视图///////////
        self.scrollView = UIScrollView(frame: CGRect.zero)
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.isPagingEnabled = true
        self.scrollView.delegate = self
        self.addSubview(self.scrollView)
        
        self.scrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
            make.height.equalTo(cellHeight*2)
        }
        
        
        ////////////滚动视图上的内容视图//////////////
        self.contentView = UIView()
        self.scrollView.addSubview(self.contentView)
        self.contentView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.scrollView);
            make.height.equalTo(self.scrollView);
            make.width.greaterThanOrEqualTo(0);//此处保证容器View宽度的动态变化 大于等于0的宽度
        }
        
        
        
        ///////////底部分页器视图//////////////
        
        self.pageControl = UIPageControl()
        self.pageControl.currentPage = 0
       // self.pageControl.numberOfPages = 5
        self.pageControl.hidesForSinglePage = true
        //设置显示颜色
        self.pageControl.currentPageIndicatorTintColor = UIColor.colorWithHexString(hex: BMThemeColor)
        //设置页背景指示颜色
        self.pageControl.pageIndicatorTintColor = UIColor.lightGray
        
        self.addSubview(self.pageControl)
        
        
        self.pageControl.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.snp.bottom).offset(-6)
            make.height.equalTo(8)
            make.centerX.equalTo(self.snp.centerX)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    //ScrollView Delegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let offset = scrollView.contentOffset.x / (kScreenWidth - margin*2)
        self.pageControl.currentPage = Int(offset)
    }
    
    
    func updateUIWithProducts(products:JSON) {
        
        let dataList:Array? = products.array
        if let dataList = dataList{
            
            self.pageControl.numberOfPages = Int(dataList.count/8) //设置当前分页器的页数
            
            var lastView:UIView? = nil
            
            for  i in 0..<Int(dataList.count/8){
                let view:BMProductTypeContentView = BMProductTypeContentView(frame: CGRect.zero)
                view.backgroundColor = UIColor.white
                view.productClickClosure = {  //接收商品点击的回调
                    (product:JSON) -> Void in
                    
                    if let _ = self.productClickClosure {  //再把得到的商品数据传回首页
                        self.productClickClosure!(product)
                    }
                    
                }
                self.contentView.addSubview(view)
                
                if let lastView = lastView{
                    
                    view.snp.makeConstraints({ (make) in
                        make.left.equalTo(lastView.snp.right)
                        make.width.equalTo(kScreenWidth-margin*2)
                        make.top.bottom.equalTo(self.contentView)
                    })
                    
                }else{
                    view.snp.makeConstraints({ (make) in
                        make.left.equalTo(self.contentView.snp.left)
                        make.width.equalTo(kScreenWidth-margin*2)
                        make.top.bottom.equalTo(self.contentView)
                    })
                }
                
                lastView = view
                view.layoutIfNeeded()  //强制去重新更新视图，得到视图的frame
    
                view.updateUIWithProducts(products: dataList[(8*i)...(7+8*i)]) //去加载每个页面的子视图
            }
            
            if self.contentView.subviews.count > 0 {
                
                if self.contentView.subviews.count == 1 {
                    
                    lastView?.snp.remakeConstraints({ (make) in
                        make.top.equalTo(self.contentView.snp.top)
                        make.left.right.equalTo(self.contentView)
                        make.bottom.equalTo(self.contentView.snp.bottom)
                        
                    })
                    
                }else {
                    let view:UIView = self.contentView.subviews[self.contentView.subviews.count-2]
                    
                    lastView?.snp.remakeConstraints({ (make) in
                        make.left.equalTo(view.snp.right)
                        make.top.bottom.equalTo(self.contentView)
                        make.right.equalTo(self.contentView.snp.right)
                        
                    })
                }
            }
            
           
        }
      
    }
    
    
    
}

