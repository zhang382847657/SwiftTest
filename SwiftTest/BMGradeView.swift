//
//  BMGradeView.swift
//  SwiftTest
//  评价显示的评分  五颗星星
//  Created by 张琳 on 2017/8/3.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit

//点击星星闭包
typealias GradeClickClosure = (_ score:Int) -> Void

class BMGradeView: UIView {
    
    var isEdit:Bool = false //是否可以编辑
    var gradeClickClosure: GradeClickClosure? //点击星星的回调

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadConfig()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadConfig()
    }
    
    
    //加载内容视图
    private func loadConfig(){
        
        
        var lastView:UIView? = nil
        
        for i in 0..<5 {   //画五个小星星  小星星的高度跟当前视图的高度一致
            
            let starBtn = UIButton(type: .custom)
            starBtn.frame = CGRect.zero
            starBtn.setBackgroundImage(UIImage(named: "star")?.tint(color: UIColor.colorWithHexString(hex: "#CCCCCC"), blendMode: .destinationIn), for: .normal)
            starBtn.setBackgroundImage(UIImage(named: "star")?.tint(color: UIColor.colorWithHexString(hex: "#FFC000"), blendMode: .destinationIn), for: .selected)
            starBtn.addTarget(self, action: #selector(click(sender:)), for: .touchUpInside)
            starBtn.tag = 100 + i //设置tag值 为了方便计算得分
            self.addSubview(starBtn)
            
            if let lastView = lastView{
                
                starBtn.snp.makeConstraints({ (make) in
                    make.top.bottom.equalTo(lastView)
                    make.left.equalTo(lastView.snp.right).offset(5)
                    make.width.equalTo(lastView.snp.width)
                })
                
            }else{
                starBtn.snp.makeConstraints({ (make) in
                    make.top.bottom.equalTo(self)
                    make.left.equalTo(self.snp.left)
                    make.width.equalTo(starBtn.snp.height)
                })
            }
            
            lastView = starBtn
            
        }
    }
    
    
    //显示评价等级
    func setScore(score:Int){
        
        for index in  0..<self.subviews.count{
            let star:UIButton = self.subviews[index] as! UIButton
            star.isSelected = index < score ? true : false
        }
    }
    
    //设置是否可以编辑
    func isEdit(edit:Bool){
        self.isEdit = edit
    }
    
    //点击事件
    func click(sender:UIButton){
        
        if self.isEdit {  //如果可以编辑的话  才相应点击事件
            self.setScore(score: sender.tag - 99)
            if let gradeClickClosure =  self.gradeClickClosure{
                gradeClickClosure(sender.tag - 99)
            }
        
        }
        
    }

}
