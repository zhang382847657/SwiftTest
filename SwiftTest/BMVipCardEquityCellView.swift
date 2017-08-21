//
//  BMVipCardEquityCellView.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/8/21.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit

class BMVipCardEquityCellView: UIView {
    
    var titleLabel:UILabel! //标题视图
    var button:UIButton! //折叠按钮
    var contentLabel:UILabel! //内容视图
    let contentStr:String! //内容文字

    init(title:String, content:String) {
        
        self.contentStr = content
        
        super.init(frame: CGRect.zero)
        
        
        //////////展开折叠按钮//////////
        self.button = UIButton(type: .custom)
        self.button.frame = CGRect.zero
        self.button.contentHorizontalAlignment = .right
        self.button.setImage(UIImage(named:"arrow_open"), for: .normal)
        self.button.setImage(UIImage(named:"arrow_close"), for: .selected)
        self.button.isSelected = false
        self.button.addTarget(self, action: #selector(openClick), for: .touchUpInside)
        self.addSubview(self.button)
        self.button.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-14)
            make.top.equalTo(self)
            make.height.width.equalTo(44)
        }
        
        
        //////////标题//////////////
        self.titleLabel = UILabel(frame: CGRect.zero)
        self.titleLabel.textColor = UIColor.colorWithHexString(hex: "#222222")
        self.titleLabel.font = UIFont.systemFont(ofSize: BMSubTitleFontSize)
        self.titleLabel.text = title
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.left.equalTo(self).offset(14)
            make.right.equalTo(self.button.snp.left).offset(-8)
            make.height.equalTo(self.button.snp.height)
        }
        
        //////////内容/////////////
        self.contentLabel = UILabel(frame: CGRect.zero)
        self.contentLabel.numberOfLines = 0
        self.contentLabel.textColor = UIColor.colorWithHexString(hex: BMSmallTitleColor)
        self.contentLabel.font = UIFont.systemFont(ofSize: BMSmallTitleFontSize)
        self.addSubview(contentLabel)
        self.contentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.titleLabel.snp.bottom)
            make.left.equalTo(self).offset(14)
            make.right.equalTo(self).offset(-14)
            make.bottom.equalTo(self)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //折叠/展开点击事件
    func openClick(sender:UIButton){
        
        if self.button.isSelected {
            
            self.button.isSelected = false
            self.contentLabel.text = nil
            
            
            //布局动画效果
            UIView.animate(withDuration: 0.5, animations: {
                
                self.contentLabel.snp.updateConstraints({ (make) in
                    make.top.equalTo(self.titleLabel.snp.bottom).offset(0)
                    make.bottom.equalTo(self).offset(0)
                })
                
                self.layoutIfNeeded()
            })
            
        
        }else{
            
            self.button.isSelected = true
            self.contentLabel.text = self.contentStr
           
            
            //布局动画效果
            UIView.animate(withDuration: 0.5, animations: {
                
                self.contentLabel.snp.updateConstraints({ (make) in
                    make.top.equalTo(self.titleLabel.snp.bottom).offset(5)
                    make.bottom.equalTo(self).offset(-10)
                })
                
                self.layoutIfNeeded()
            })
            
        }
        
       
        
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //给每个cell视图添加上边框
        self.addBorderLayer(color: UIColor.colorWithHexString(hex: BMBorderColor), size: BMBorderSize, boderType: BorderType.top)
    }

}
