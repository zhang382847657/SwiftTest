//
//  InputView.swift
//  SwiftTest
//  输入框   cell样式   
//  _______________________
// | 文字             输入框 |
//  -----------------------
//  Created by 张琳 on 2017/8/28.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit

class InputView: UIView {
    
    var leftTitleLabel:UILabel!  //左侧标题label
    var rightTextField:UITextField!  //右侧输入框
    
    
    var titile:String = ""{  //左侧标题
        didSet{
            self.leftTitleLabel.text = titile
        }
    }
    var placeholder:String? = "请输入" {  //提示词
        didSet{
            self.rightTextField.placeholder = placeholder
        }
    }
    var valueText:String? = nil {  //输入框的值
        didSet{
            self.rightTextField.text = valueText
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
    
    init(title:String, placeholder:String?, valueText:String?) {
        self.titile = title
        self.placeholder = placeholder
        self.valueText = valueText
        
        super.init(frame: CGRect.zero)
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
        
        /////////////右侧输入框///////////
        self.rightTextField = UITextField(frame: CGRect.zero)
        self.rightTextField.textColor = UIColor.colorWithHexString(hex: BMTitleColor)
        self.rightTextField.textAlignment = .right
        self.rightTextField.font = UIFont.systemFont(ofSize: BMSubTitleFontSize)
        self.rightTextField.borderStyle = .none
        self.addSubview(self.rightTextField)
        self.rightTextField.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-10)
            make.top.bottom.equalTo(self.leftTitleLabel)
            make.width.equalTo(200)
        }
        
    }


}
