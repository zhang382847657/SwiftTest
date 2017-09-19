//
//  InputTextView.swift
//  SwiftTest
//  文本输入框  可显示剩余可输入数量
//  Created by 张琳 on 2017/8/9.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit

class InputTextView: UIView, UITextViewDelegate {
    
    private var textView:UITextView!
    private var label:UILabel!
    private var _totalNum:Int = 140  //总字数  默认140
    
    var isEdit:Bool = true { //是否可以编辑
        didSet {
            self.textView.isEditable = isEdit
        }
    }
    
    var totalNum:Int  { //总字数  对外暴露的属性
        get {
            return self._totalNum
        }
        set {
            self._totalNum = newValue
            self.label.text = "0/\(newValue)"
        }
    }
    var placeholder:String = "请输入" {
        didSet{
            self.textView.placeholderText = placeholder
        }
    }
    
    var valueText:String? = nil{
        didSet{
            self.textView.text = valueText
            self.countRemainWords() //计算剩余可用字数并更新底部文案
        }
    }
    
    //MARK: 得到最终的文本框的值
    func getValueText() -> String?{
        return self.textView.text
    }
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadConfig()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadConfig()
    }
    
    
    private func loadConfig(){
        
        self.textView = UITextView(frame: CGRect.zero)
        self.textView.textColor = UIColor.colorWithHexString(hex: BMSubTitleColor)
        self.textView.font = UIFont.systemFont(ofSize: BMSubTitleFontSize)
        self.textView.placeholderText = self.placeholder
        self.textView.shouldHidePlaceholderText = false
        self.textView.delegate = self
        self.addSubview(self.textView)
        
        self.textView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(10)
            make.left.equalTo(self).offset(10)
            make.right.equalTo(self).offset(-10)
        }
        
        
        self.label = UILabel(frame: CGRect.zero)
        self.label.textColor = UIColor.colorWithHexString(hex: "#CCCCCC")
        self.label.font = UIFont.systemFont(ofSize: BMSmallTitleFontSize)
        self.label.textAlignment = .right
        self.label.text = "0/\(self._totalNum)"
        self.addSubview(self.label)
        
        self.label.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.textView)
            make.top.equalTo(self.textView.snp.bottom).offset(5)
            make.bottom.equalTo(self).offset(-10)
            make.height.equalTo(20)
        }
        
    }
    
    
    //MARK: -UITextViewDelegate
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if (text == "\n") {  // textView点击完成隐藏键盘
            textView.resignFirstResponder()
            return false
        }
        
        //字数限制
        if range.location >= self._totalNum{
            return false
        }
        
        return true
        
    }
    
    func textViewDidChange(_ textView: UITextView){
        self.countRemainWords() //计算剩余可用字数
    }
    
    
    //MARK: 计算剩余可用字数并更新底部文案
    private func countRemainWords(){
        self.label.text = "\(self.textView.text.characters.count)/\(self._totalNum)"
    }

}
