//
//  InforPickerView.swift
//  SwiftTest
//  选择框   cell样式
//  __________________________
// | 文字             选择值 > |
//  --------------------------
//  Created by 张琳 on 2017/8/30.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit

//定义点击事件的闭包
typealias InforPickerViewClickClosure = () -> Void

class InforPickerView: UIView {
    var leftTitleLabel:UILabel!  //左侧标题label
    var rightLabel:UILabel!  //右侧选择值内容
    var arrowImageView:UIImageView! //右侧箭头
    var clickClosure: InforPickerViewClickClosure? //点击事件闭包
    
    
    var titile:String = ""{  //左侧标题
        didSet{
            self.leftTitleLabel.text = titile
        }
    }

    var valueText:String? = nil {  //右侧选择的值
        didSet{
            self.rightLabel.text = valueText
        }
    }

    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.loadUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.loadUI()
    }
    
    
    /**
     *  加载布局
     */
    private func loadUI(){
        
        /////////////左侧标题/////////////
        self.leftTitleLabel = UILabel(frame: CGRect.zero)
        self.leftTitleLabel.textColor = UIColor.colorWithHexString(hex: BMTitleColor)
        self.leftTitleLabel.font = UIFont.systemFont(ofSize: BMSubTitleFontSize)
        self.addSubview(self.leftTitleLabel)
        self.leftTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(10)
            make.bottom.equalTo(self).offset(-10)
            make.left.equalTo(self).offset(10)
        }
        
        
        /////////////右侧箭头/////////////
        self.arrowImageView = UIImageView(image: UIImage(named: "infor"))
        self.addSubview(self.arrowImageView)
        self.arrowImageView.snp.makeConstraints { (make) in
            make.width.equalTo(7)
            make.height.equalTo(13)
            make.centerY.equalTo(self.snp.centerY)
            make.right.equalTo(self.snp.right).offset(-10)
        }
        
        /////////////右侧选择值///////////
        self.rightLabel = UILabel(frame: CGRect.zero)
        self.rightLabel.textColor = UIColor.colorWithHexString(hex: BMTitleColor)
        self.rightLabel.textAlignment = .right
        self.rightLabel.font = UIFont.systemFont(ofSize: BMSubTitleFontSize)
        self.addSubview(self.rightLabel)
        self.rightLabel.snp.makeConstraints { (make) in
            make.right.equalTo(self.arrowImageView.snp.left).offset(-10)
            make.top.bottom.equalTo(self.leftTitleLabel)
            make.width.equalTo(200)
        }
        
        self.addClickListener(target: self, action: #selector(click)) //给view添加点击事件
    
    }
    
    //点击事件
    func click(){
        if let clickClosure = self.clickClosure{
            clickClosure()
        }
    }
    

}
