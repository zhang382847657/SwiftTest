//
//  SelectView.swift
//  SwiftTest
//  单多选视图
//  Created by 张琳 on 2017/9/2.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit

class SelectView: UIView {

    var titileLabel:UILabel! //标题label
    var selectButtonView:SelectButtonView! //单多选视图
    
    var dataSource:Array<String> = []{ //数据源
        didSet{
            self.selectButtonView = SelectButtonView(frame: CGRect.zero)
            self.selectButtonView.dataSource = dataSource
            self.addSubview(self.selectButtonView)
            self.selectButtonView.snp.makeConstraints { (make) in
                make.top.equalTo(self.titileLabel.snp.bottom).offset(10)
                make.left.right.equalTo(self.titileLabel)
                make.bottom.equalTo(self).offset(-10)
            }
            
        }
    }
    var radioDefaultValue:String? //单选默认值
    
    var title:String = ""{
     
        didSet {
            self.titileLabel.text = title
        }
    }
    
    
    init(withTitle title:String,radioDataSource dataSource:Array<String>, defaultValue:String?) {
        self.title = title
        self.dataSource = dataSource
        self.radioDefaultValue = defaultValue
        super.init(frame: CGRect.zero)
        
        self.loadUI()
        
        
        /////////单多选视图////////////
        self.selectButtonView = SelectButtonView(withRadioDataSource: dataSource, defaultValue: defaultValue)
        self.addSubview(self.selectButtonView)
        self.selectButtonView.snp.makeConstraints { (make) in
            make.top.equalTo(self.titileLabel.snp.bottom).offset(10)
            make.left.right.equalTo(self.titileLabel)
            make.bottom.equalTo(self).offset(-10)
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
    
    
    private func loadUI(){
        
        //////////标题Label//////////
        self.titileLabel = UILabel(frame: CGRect.zero)
        self.titileLabel.text = self.title
        self.titileLabel.textColor = UIColor(hex: BMTitleColor)
        self.titileLabel.font = UIFont.systemFont(ofSize: BMSubTitleFontSize)
        self.addSubview(self.titileLabel)
        self.titileLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(10)
            make.top.equalTo(self)
            make.right.equalTo(self).offset(-10)
            make.height.equalTo(45)
        }
        
    }
    

}


class SelectButtonView: UIView {

    
    var dataSource:Array<String> = []{ //数据源
        didSet{
            self.loadUI()
        }
    }
    var radioDefaultValue:String? //单选默认值
    
    
    init(withRadioDataSource dataSource:Array<String>, defaultValue:String?) {
        self.dataSource = dataSource
        self.radioDefaultValue = defaultValue
        
        super.init(frame: CGRect.zero)
        self.loadUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func loadUI(){
        
        
        var lastBtn:UIButton? = nil
        
        for i in 0..<self.dataSource.count{
            
            let value:String = self.dataSource[i]
            
            let button:UIButton = UIButton(type: .custom)
            button.setTitle(value, for: .normal)
            button.setTitleColor(UIColor(hex:BMTitleColor), for: .normal)
            button.setTitleColor(UIColor.white, for: .selected)
            button.setBackgroundImage(createImageWithColor(color: UIColor.clear), for: .normal)
            button.setBackgroundImage(createImageWithColor(color: UIColor(hex:BMThemeColor)), for: .selected)
            button.titleLabel?.font = UIFont.systemFont(ofSize: BMSmallTitleFontSize)
            button.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
            button.layer.borderColor = UIColor(hex: BMBorderColor).cgColor
            button.layer.borderWidth = BMBorderSize
            self.addSubview(button)
            
            button.snp.makeConstraints({ (make) in
                make.height.equalTo(35)
               
                
                if let lastBtn = lastBtn{
                    
                    make.width.equalTo(lastBtn.snp.width)
                    
                    if i % 4 == 0{
                        make.top.equalTo(lastBtn.snp.bottom).offset(5)
                        make.left.equalTo(self)
                        
                    }else{
                        if i % 4 == 3{
                            make.right.equalTo(self)
                        }
                        
                        make.top.equalTo(lastBtn.snp.top)
                        make.left.equalTo(lastBtn.snp.right).offset(5)
                        
                    }
                    
                }else{
                    make.top.left.equalTo(self)
                    
                    if self.dataSource.count < 4{
                        make.width.equalTo(60)
                    }
                }
                
                
                if i == self.dataSource.count - 1{
                    make.bottom.equalTo(self)
                }
            })
            
            lastBtn = button
        }
        
    }
    
    
    //按钮点击事件
    func buttonClick(sender:UIButton){
        sender.isSelected = !sender.isSelected
    }
    
}
