//
//  BMPickerView.swift
//  SwiftTest
//  模态视图的选择器 
//  ____________________________
//  |                           |
//  |                           |
//  |                           |
//  |---------------------------|
//  | 取消                  确定  |
//  |---------------------------|
//  |            0              |
//  |            1              |
//  |            2              |
//  -----------------------------
//
//
//  Created by 张琳 on 2017/8/30.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit


class BMPickerView: UIView,UIPickerViewDelegate,UIPickerViewDataSource {

    enum PickerType:NSInteger{
        case Single ,  //单列数据
             Multiple ,  //多列不相关数据
             MultipleAssociated ,  //多列相关数据
             Date  //日期数据
    }
    
    private var contentView:UIView! //底部容器视图
    private var topView:TopView! //头部视图  显示取消确定按钮
    private var pickerView:UIPickerView! //选择器视图
    private var datePicker:UIDatePicker! //日期选择器视图
    private var currenPickerType:PickerType! //当前Picker类型
    
    private var singleDataSource:Array<Dictionary<String,Any>>! //一列数据源
    private var singleSelectValue:Dictionary<String,Any>! //一列数据源选中的值
    
    private var multipleDataSource:Array<Array<Dictionary<String,Any>>>! //多列不相关数据源
    private var multipleSelectValue:Array<Dictionary<String,Any>>! //多列不相关数据源选中的值
    
    private var dateSelectValue:String! //选中的日期
    private var dateFormatter:String! //日期格式化
    
    
    typealias SingleDoneAction = (_ selectedValue: Dictionary<String,Any>) -> Void  //一列数据完成回调
    typealias MultipleDoneAction = (_ selectedValues: Array<Dictionary<String,Any>>) -> Void  //多列不相关数据完成回调
    typealias DateDoneAction = (_ selectedDate: String) -> Void  //日期类型数据完成回调
    typealias MultipleAssociatedDataType = [[[String: [Dictionary<String,Any>]?]]]  //多列相关数据完成回调
    
    
    // MARK:- 一列数据初始化
    // @params singleColData 数据源  格式： [["key":"男","value":0],["key":"女","value":1]]
    // @params defaultSelectedValue 默认选中的值  ["key":"男","value":0]
    // @params doneAction 完成的回调
    
    init(singleColData: Array<Dictionary<String,Any>>, defaultSelectedValue: Dictionary<String,Any>?, doneAction: SingleDoneAction?) {
        
        self.singleDataSource = singleColData
        self.currenPickerType = .Single
        
        super.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        
        /////////加载页面布局///////////
        self.loadUI { //完成按钮点击的回调
            if let doneAction = doneAction{
                doneAction(self.singleSelectValue)
            }
        }
        
        /////////选择器视图/////////////
        self.pickerView = UIPickerView(frame: CGRect.zero)
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        self.contentView.addSubview(self.pickerView)
        self.pickerView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.contentView)
            make.top.equalTo(self.topView.snp.bottom)
            make.bottom.equalTo(self.contentView)
        }
        
        
        /////////默认选中哪一行///////////
        if let defaultSelectedValue = defaultSelectedValue{
            self.singleSelectValue = defaultSelectedValue
            for i in 0 ..< singleColData.count{
                let dic:Dictionary<String,Any> = singleColData[i]
                let dicKeyValue:String = dic["key"] as! String
                let selectKeyValue:String = defaultSelectedValue["key"] as! String
                if dicKeyValue == selectKeyValue{
                    self.pickerView.selectRow(i, inComponent: 0, animated: true)
                    break
                }
            }
        }else{
            self.singleSelectValue = self.singleDataSource[0] //默认选中的值就是第一行
        }
        
    }
    
    
    // MARK:- 多列不相关数据初始化 
    // 注意:  默认值的数组长度要跟数据源的长度保持一致！！！
    // @params singleColData 数据源  格式： [[["key":"男","value":0],["key":"女","value":1]],[["key":"本科","value":0],["key":"大专","value":1],["key":"高中","value":2]]]
    // @params defaultSelectedValue 默认选中的值  [["key":"男","value":0],["key":"高中","value":2]]
    // @params doneAction 完成的回调
    
    init(multipleColData: Array<Array<Dictionary<String,Any>>>, defaultSelectedValue: Array<Dictionary<String,Any>>?, doneAction: MultipleDoneAction?) {
        
        self.multipleDataSource = multipleColData
        self.currenPickerType = .Multiple
        
        super.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        
        /////////加载页面布局///////////
        self.loadUI { //完成按钮点击的回调
            if let doneAction = doneAction{
                doneAction(self.multipleSelectValue)
            }
        }
        
        /////////选择器视图/////////////
        self.pickerView = UIPickerView(frame: CGRect.zero)
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        self.contentView.addSubview(self.pickerView)
        self.pickerView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.contentView)
            make.top.equalTo(self.topView.snp.bottom)
            make.bottom.equalTo(self.contentView)
        }
        
        
        /////////默认选中哪一行///////////
        if let defaultSelectedValue = defaultSelectedValue{
            self.multipleSelectValue = defaultSelectedValue
           
            for i in 0..<self.multipleDataSource.count{
                let array = self.multipleDataSource[i]
                var selectValue:Dictionary<String,Any> = self.multipleSelectValue[i]
                for j in 0..<array.count{
                    let value = array[j]
                    let dicKeyValue:String = value["key"] as! String
                    let selectKeyValue:String = selectValue["key"] as! String
                    if dicKeyValue == selectKeyValue{
                        self.pickerView.selectRow(j, inComponent: i, animated: true)
                    }
                }
            }
            
        }else{
            var selectValue:Array<Dictionary<String,Any>> = []
            for i in 0..<self.multipleDataSource.count{
                let array:Array<Dictionary<String,Any>> = self.multipleDataSource[i]
                if array.count > 0 {
                    selectValue.append(array[0])
                }
            }
            self.multipleSelectValue = selectValue
            dPrint(item: "\(self.multipleSelectValue)")
        }
        
        
    }
    
    
    // MARK:- 日期类型数据初始化
    // @params dateWithMinimumDate 最小时间
    // @params maximumDate 最大时间
    // @params datePickerMode 日期选择显示的类型
    // @params dateFormatter 日期格式化
    // @params defaultSelectedValue 日期默认值
    // @params doneAction 完成的回调
    
    init(dateWithMinimumDate: String?, maximumDate:String?, datePickerMode:UIDatePickerMode,
         dateFormatter:String,defaultSelectedValue: String?, doneAction: DateDoneAction?) {
        
        
        self.currenPickerType = .Date
        self.dateFormatter = dateFormatter
        
        super.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        
        /////////加载页面布局///////////
        self.loadUI { //完成按钮点击的回调
            if let doneAction = doneAction{
                doneAction(self.dateSelectValue)
            }
        }
        
        /////////日期选择器视图/////////////
        self.datePicker = UIDatePicker(frame: CGRect.zero)
        self.datePicker.datePickerMode = datePickerMode
        self.datePicker.locale = Locale(identifier: "zh_CN") //将日期选择器区域设置为中文
       
        
        // 设置日期范围（超过日期范围，会回滚到最近的有效日期）
        let dformatter = DateFormatter()
        dformatter.dateFormat = dateFormatter
        
        if let dateWithMinimumDate = dateWithMinimumDate{
            let minDate = dformatter.date(from: dateWithMinimumDate)
            self.datePicker.minimumDate = minDate
        }
        
        if let maximumDate = maximumDate{
            let maxDate = dformatter.date(from: maximumDate)
            self.datePicker.maximumDate = maxDate
        }
        
        
        // 响应事件（只要滚轮变化就会触发）
        self.datePicker.addTarget(self, action:#selector(datePickerValueChange), for: .valueChanged)
        
       
        
        self.contentView.addSubview(self.datePicker)
        self.datePicker.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.contentView)
            make.top.equalTo(self.topView.snp.bottom)
            make.bottom.equalTo(self.contentView)
        }
        
        
        /////////默认选中哪一行///////////
        if let defaultSelectedValue = defaultSelectedValue{
            let selectData = dformatter.date(from: defaultSelectedValue)
            self.datePicker.date = selectData!
            self.dateSelectValue = defaultSelectedValue
        }else{ //如果没有默认选中的值，则显示当前时间
            self.datePicker.date = Date()
            self.dateSelectValue = dformatter.string(from: Date())
        }
        
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     * 加载页面布局
     * @params sumitClick 完成按钮点击的回调
     */
    private func loadUI(sumitClick:@escaping () -> Void){
        
        self.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        
        
        /////////底部容器视图///////////
        self.contentView = UIView(frame: CGRect.zero)
        self.contentView.backgroundColor = UIColor.white
        self.addSubview(self.contentView)
        self.contentView.snp.makeConstraints { (make) in
            make.bottom.left.right.equalTo(self)
            make.height.equalTo(260)
        }
        
        /////////底部头部视图//////////
        self.topView = TopView(frame: CGRect.zero)
        self.topView.cancelClickClosure = {  //取消按钮点击回调
            () -> Void in
            self.close()  //关闭视图
        }
        self.topView.submitClickClosure = { //完成按钮点击回调
            () -> Void in
            
            sumitClick()  //回调过去
            self.close()  //关闭视图
        }
        self.contentView.addSubview(self.topView)
        self.topView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self.contentView)
        }
        

    }
    
    //MARK: 显示视图
    func show(){
        UIApplication.shared.keyWindow?.addSubview(self)
    }
    
    //MARK: 关闭视图
    private func close(){
        self.removeFromSuperview()
    }
    
    
    
    // MARK: UIPickerView - DataSource
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        if self.currenPickerType == .Single {  //一列数据
            return 1
        }else if self.currenPickerType == .Multiple{  //多列不相关数据
            return self.multipleDataSource.count
        }else if self.currenPickerType == .MultipleAssociated{  //多列相关数据
            return 0
        }else{ //日期
            return 0
        }

    }
    
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if self.currenPickerType == .Single {  //一列数据
            return self.singleDataSource.count
        }else if self.currenPickerType == .Multiple{  //多列不相关数据
            return self.multipleDataSource[component].count
        }else if self.currenPickerType == .MultipleAssociated{  //多列相关数据
            return 0
        }else{ //日期
            return 0
        }
    }
    
    
    
    // MARK: UIPickerView - Delegate
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        
        if self.currenPickerType == .Single {  //一列数据
            self.singleSelectValue = self.singleDataSource[row]
            dPrint(item: "选中的结果是：\(self.singleSelectValue)")
        }else if self.currenPickerType == .Multiple{  //多列不相关数据
//            self.multipleSelectValue = self.singleDataSource[row]
//            dPrint(item: "选中的结果是：\(self.singleSelectValue)")
        }else if self.currenPickerType == .MultipleAssociated{  //多列相关数据
            
        }else{ //日期
            
        }
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        
        if self.currenPickerType == .Single {  //一列数据
            return self.singleDataSource[row]["key"] as? String
        }else if self.currenPickerType == .Multiple{  //多列不相关数据
            return self.multipleDataSource[component][row]["key"] as? String
        }else if self.currenPickerType == .MultipleAssociated{  //多列相关数据
            return nil
        }else{ //日期
            return nil
        }
    }
    
    
    //MARK: 日期选择器改变事件
    func datePickerValueChange(sender: UIDatePicker){
        
        let dformatter = DateFormatter()
        dformatter.dateFormat = self.dateFormatter
        let sourceTimeZone = NSTimeZone.system
        dformatter.timeZone = sourceTimeZone
        self.dateSelectValue = dformatter.string(from: sender.date)
    }

}


//取消按钮闭包定义
typealias TopViewCancelClickClosure = () -> Void
//完成按钮闭包定义
typealias TopViewSubmitClickClosure = () -> Void

class TopView: UIView {
    
    var cancelBtn:UIButton! //取消按钮
    var submitBtn:UIButton! //完成按钮
    
    var cancelClickClosure: TopViewCancelClickClosure? //取消按钮回调
    var submitClickClosure: TopViewSubmitClickClosure? //完成按钮回调
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        /////////取消按钮///////////
        self.cancelBtn = UIButton(type: .system)
        self.cancelBtn.setTitle("取消", for: .normal)
        self.cancelBtn.setTitleColor(UIColor(hex:BMThemeColor), for: .normal)
        self.cancelBtn.titleLabel?.font = UIFont.systemFont(ofSize: BMSubTitleFontSize)
        self.cancelBtn.addTarget(self, action: #selector(cancelClick), for: .touchUpInside)
        self.addSubview(self.cancelBtn)
        self.cancelBtn.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.top.bottom.equalTo(self)
            make.width.equalTo(60)
            make.height.equalTo(44)
        }
        
        
        /////////确认按钮///////////
        self.submitBtn = UIButton(type: .system)
        self.submitBtn.setTitle("完成", for: .normal)
        self.submitBtn.setTitleColor(UIColor(hex:BMThemeColor), for: .normal)
        self.submitBtn.titleLabel?.font = UIFont.systemFont(ofSize: BMSubTitleFontSize)
        self.submitBtn.addTarget(self, action: #selector(submitClick), for: .touchUpInside)
        self.addSubview(self.submitBtn)
        self.submitBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-10)
            make.top.bottom.equalTo(self)
            make.width.equalTo(60)
            make.height.equalTo(44)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //取消按钮点击事件
    func cancelClick(){
        if let cancelClickClosure = self.cancelClickClosure{
            cancelClickClosure()
        }
    }
    
    //完成按钮点击事件
    func submitClick(){
        if let submitClickClosure = self.submitClickClosure{
            submitClickClosure()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.addBorderLayer(color: UIColor(hex:BMBorderColor), size: BMBorderSize, boderType: BorderType.bottom)
    }
}
