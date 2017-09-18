//
//  SelectView.swift
//  SwiftTest
//  单多选视图
//  Created by 张琳 on 2017/9/2.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit

enum SelectType {
    case radio,  //单选
    checkbox  //多选
}

class SelectView: UIView {

    private var titileLabel:UILabel! //标题label
    private var selectButtonView:SelectButtonView! //单多选视图
    
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
    
    var title:String = ""{
        didSet {
            self.titileLabel.text = title
        }
    }
    
    var radioDefaultValue:String? = nil{ //单选默认值
        didSet{
            self.selectButtonView.radioDefaultValue = radioDefaultValue
            self.selectType = .radio
        }
    }
    var checboxDefaultValue:Array<String>? = nil{ //多选默认值
        didSet{
            self.selectButtonView.checkboxDefaultValue = checboxDefaultValue
            self.selectType = .checkbox
        }
    }
    var selectType:SelectType = .radio //选择类型  单选、多选
    
    
    
    //MARK: 初始化单选视图
    // params title 标题
    // params dataSource 数据源
    // params defaultValue 默认值
    init(withTitle title:String,radioDataSource dataSource:Array<String>, defaultValue:String?) {
        self.title = title
        self.dataSource = dataSource
        self.radioDefaultValue = defaultValue
        self.selectType = .radio
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
    
    
    //MARK: 初始化多选视图
    // params title 标题
    // params dataSource 数据源
    // params defaultValue 默认值
    init(withTitle title:String,checkboxDataSource dataSource:Array<String>, defaultValue:Array<String>?) {
        self.title = title
        self.dataSource = dataSource
        self.checboxDefaultValue = defaultValue
        self.selectType = .checkbox
        super.init(frame: CGRect.zero)
        
        self.loadUI()
        
        
        /////////单多选视图////////////
        self.selectButtonView = SelectButtonView(withCheckboxDataSource: dataSource, defaultValue: defaultValue)
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
    var radioDefaultValue:String? = nil{ //单选默认值
        didSet{
            self.selectType = .radio
            self.setDefauleValue() //设置默认值的显示
        }
    }
    var checkboxDefaultValue:Array<String>? = nil{ //多选默认值
        didSet{
            self.selectType = .checkbox
            self.setDefauleValue() //设置默认值的显示
        }
    }
    var selectType:SelectType = .radio //选择类型  单选、多选
    
    
    //MARK: 初始化单选视图
    // params dataSource 数据源
    // params defaultValue 默认值
    init(withRadioDataSource dataSource:Array<String>, defaultValue:String?) {
        self.dataSource = dataSource
        self.radioDefaultValue = defaultValue
        self.selectType = .radio
        
        super.init(frame: CGRect.zero)
        self.loadUI() //加载界面布局
        self.setDefauleValue() //设置默认值的显示
    }
    
    //MARK: 初始化多选视图
    // params dataSource 数据源
    // params defaultValue 默认值
    init(withCheckboxDataSource dataSource:Array<String>, defaultValue:Array<String>?) {
        self.dataSource = dataSource
        self.checkboxDefaultValue = defaultValue
        self.selectType = .checkbox
        
        super.init(frame: CGRect.zero)
        self.loadUI() //加载界面布局
        self.setDefauleValue() //设置默认值的显示
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //界面布局
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
                        make.width.equalTo(80)
                    }
                }
                
                
                if i == self.dataSource.count - 1{
                    make.bottom.equalTo(self)
                }
            })
            
            lastBtn = button
        }
        
    }
    
    //设置默认值
    private func setDefauleValue(){
        if let radioDefaultValue = self.radioDefaultValue{
            
            for view in self.subviews{  //单选默认值
                if view is UIButton {
                    let btn:UIButton = view as! UIButton
                    if btn.titleLabel?.text == radioDefaultValue{
                        btn.isSelected = true
                    }else{
                        btn.isSelected = false
                    }
                }
            }

        }
        
        if let checkboxDefaultValue = self.checkboxDefaultValue{
            for view in self.subviews{  //多选默认值
                for value in checkboxDefaultValue{
                    if view is UIButton {
                        let btn:UIButton = view as! UIButton
                        if btn.titleLabel?.text == value{
                            btn.isSelected = true
                        }
                    }
                }
            }
        }
    }
    
    
    //按钮点击事件
    func buttonClick(sender:UIButton){
        
        
        switch self.selectType {
        case SelectType.radio:
            for view in self.subviews{  //做一个单选的效果
                if view is UIButton {
                    let btn:UIButton = view as! UIButton
                    if btn == sender{
                        btn.isSelected = true
                    }else{
                        btn.isSelected = false
                    }
                }
            }
        case SelectType.checkbox:
            sender.isSelected = !sender.isSelected
        }
    }
    
}
