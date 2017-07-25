//
//  BMProductBottomView.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/7/21.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit

class BMProductBottomView: UIView {

    var bottomView:UIView! //底部视图
    var circleView:BMProductCircleView! //圆环视图
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.backgroundColor = UIColor(white: 0.3, alpha: 0.5)
        
        
        //////////////底部视图////////////////
        self.bottomView = UIView(frame: CGRect(x: 0, y: kScreenHeight, width: kScreenWidth, height: kScreenHeight*0.75))
        self.addSubview(self.bottomView)

        /////右上角关闭按钮////
        let closeBtn:UIButton = UIButton(type: .custom)
        closeBtn.frame = CGRect.zero
        closeBtn.setImage(UIImage(named:"close_drawer"), for: .normal)
        closeBtn.addTarget(self, action: #selector(hidden), for: .touchUpInside)
        self.bottomView.addSubview(closeBtn)
        
        closeBtn.snp.makeConstraints { (make) in
            make.top.equalTo(self.bottomView)
            make.right.equalTo(self.bottomView.snp.right).offset(-30)
            make.height.width.equalTo(30)
        }
        
        //////下方内容视图////
        let contentView:UIView = UIView(frame: CGRect.zero)
        contentView.backgroundColor = UIColor.colorWithHexString(hex: BMBacgroundColor)
        self.bottomView.addSubview(contentView)
        
        contentView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.bottomView)
            make.top.equalTo(closeBtn.snp.bottom)
        }
        
        
        ///////立即下单按钮////
        let orderBtn:UIButton = UIButton(type: .custom)
        orderBtn.frame = CGRect.zero
        orderBtn.setTitle("立即下单", for: .normal)
        orderBtn.titleLabel?.font = UIFont.systemFont(ofSize: BMTitleFontSize)
        orderBtn.setTitleColor(UIColor.white, for: .normal)
        orderBtn.backgroundColor = UIColor.colorWithHexString(hex: BMSmallTitleColor)
        orderBtn.addTarget(self, action: #selector(orderClick), for: .touchUpInside)
        contentView.addSubview(orderBtn)
        
        orderBtn.snp.makeConstraints { (make) in
            make.width.equalTo(165)
            make.height.equalTo(45)
            make.centerX.equalTo(contentView.snp.centerX)
            make.bottom.equalTo(contentView.snp.bottom).offset(-15)
        }
        
        //////总计//////////
        let totalPriceLable = UILabel(frame: CGRect.zero)
        totalPriceLable.text = "合计：￥100.00"
        totalPriceLable.font = UIFont.systemFont(ofSize: BMTitleFontSize)
        totalPriceLable.textColor = UIColor.red
        totalPriceLable.textAlignment = .center
        contentView.addSubview(totalPriceLable)
        
        totalPriceLable.snp.makeConstraints { (make) in
            make.bottom.equalTo(orderBtn.snp.top).offset(-5)
            make.left.right.equalTo(contentView)
        }
        
        
        //////中间的滚动视图//////
        let scrollView = UIScrollView(frame: CGRect.zero)
       // scrollView.showsVerticalScrollIndicator = false
        contentView.addSubview(scrollView)
        
        scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(15)
            make.left.equalTo(contentView).offset(15)
            make.right.equalTo(contentView).offset(-15)
            make.bottom.equalTo(totalPriceLable.snp.top).offset(-20)
        }
        
        /////滚动视图的内容视图//////
        let centerContentView = UIView(frame: CGRect.zero)
        scrollView.addSubview(centerContentView)
        
        centerContentView.snp.makeConstraints { (make) in
            make.edges.equalTo(scrollView)
            make.height.greaterThanOrEqualTo(0);//此处保证容器View高度的动态变化 大于等于0的高度
            make.width.equalTo(scrollView.snp.width)
        }
        
        /////购物车加减视图//////
        let symbolsView:BMProductSymbolsView = UIView.loadViewFromNib(nibName: "BMProductSymbolsView") as! BMProductSymbolsView
        centerContentView.addSubview(symbolsView)
        
        symbolsView.snp.makeConstraints { (make) in
            make.top.equalTo(centerContentView)
            make.left.right.equalTo(centerContentView)
        }
        
        
        //////圆环视图/////
        self.circleView = UIView.loadViewFromNib(nibName: "BMProductCircleView") as! BMProductCircleView
        
        centerContentView.addSubview(circleView)
        
        circleView.snp.makeConstraints { (make) in
            make.top.equalTo(symbolsView.snp.bottom).offset(5)
            make.left.right.equalTo(centerContentView)
            make.bottom.equalTo(centerContentView.snp.bottom).offset(-50)
        }
    
    }
    
   
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //显示当前视图
    func show(){
        
        let superView = self.superview
        
        if let superView = superView{
            self.snp.remakeConstraints{ (make) in
                make.edges.equalTo(superView)
            }
            
            UIView.animate(withDuration: 0.4) {
                self.bottomView.frame = CGRect(x: self.bottomView.frame.origin.x, y: kScreenHeight-self.bottomView.frame.size.height, width: self.bottomView.frame.size.width, height: self.bottomView.frame.size.height)
            }
        }
    }
    
    
    //隐藏当前视图
    func hidden(){
        let superView = self.superview
        
        if let superView = superView{
            
            
            UIView.animate(withDuration: 0.2, animations: {
                
                self.bottomView.frame = CGRect(x: self.bottomView.frame.origin.x, y: kScreenHeight, width: self.bottomView.frame.size.width, height: self.bottomView.frame.size.height)
                
            }, completion: { (true) in
                
                self.snp.remakeConstraints { (make) in
                    make.top.equalTo(superView.snp.bottom)
                    make.left.right.equalTo(superView)
                    make.height.equalTo(0)
                }
            })
            
        }
    }
    
    //当前视图点击事件
    func viewClick(sender:UITapGestureRecognizer){
        dPrint(item: "我被点击了")
        self.hidden()
        
    }
    
    
    
    //立即下单点击时间
    func orderClick(sender:UIButton){
        dPrint(item: "立即下单被点击了")
        
//        circleView.circleView.setProgress(circleView.circleView.progress + 55, animated: true, withDuration: 10)
    }

}
