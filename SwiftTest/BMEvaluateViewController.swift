//
//  BMEvaluateViewController.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/9/18.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit

class BMEvaluateViewController: UIViewController {
    
    var tradeNo:String? //订单编号
    
    var scrollView:UIScrollView! //滚动视图
    var contentView:UIView! //内容视图
    var titleLabel:UILabel! //标题
    var starView:BMGradeView! //打分视图
    var evaluateContentView:InputTextView! //评论内容视图
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "评价"
        self.view.backgroundColor = UIColor(hex: BMBacgroundColor)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发表", style: .plain, target: self, action: #selector(sendClick))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: 初始化页面
    /**
     * params tradeNo 订单编号
     */
    init(tradeNo:String) {
        self.tradeNo = tradeNo
        super.init(nibName: nil, bundle: nil)
        
        self.loadUI() //初始化页面布局
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //初始化页面布局
    private func loadUI(){
        
        ////////////滚动视图///////////
        self.scrollView = UIScrollView(frame: CGRect.zero)
        self.view.addSubview(self.scrollView)
        
        self.scrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        ////////////内容视图////////////
        self.contentView = UIView(frame: CGRect.zero)
        self.scrollView.addSubview(self.contentView)
        
        self.contentView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.scrollView)
            make.width.equalTo(self.scrollView.snp.width)
            make.height.greaterThanOrEqualTo(0)
        }
        
        ////////////标题///////////////
        self.titleLabel = UILabel(frame: CGRect.zero)
        self.titleLabel.text = "请对本次服务做出评价"
        self.titleLabel.font = UIFont.systemFont(ofSize: BMSmallTitleFontSize)
        self.titleLabel.textColor = UIColor(hex: BMSmallTitleColor)
        self.contentView.addSubview(self.titleLabel)
        
        self.titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentView).offset(22)
            make.left.equalTo(self.contentView).offset(10)
            make.right.equalTo(self.contentView).offset(-10)
        }
        
        ////////////中间承载打分+评论内容的视图////////
        let centerView:UIView = UIView(frame: CGRect.zero)
        centerView.backgroundColor = UIColor.white
        self.contentView.addSubview(centerView)
        
        centerView.snp.makeConstraints { (make) in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(10)
            make.left.right.equalTo(self.titleLabel)
            make.bottom.equalTo(self.contentView)
        }
        
        ////////////打分星星视图/////////////////
        self.starView = BMGradeView(frame: CGRect.zero)
        self.starView.isEdit = true
        centerView.addSubview(self.starView)
        
        self.starView.snp.makeConstraints { (make) in
            make.top.equalTo(centerView).offset(10)
            make.left.equalTo(centerView).offset(10)
            make.right.equalTo(centerView).offset(-10)
        }
        
        
        ///////////评论内容视图///////////////////
        self.evaluateContentView = InputTextView(frame: CGRect.zero)
        centerView.addSubview(self.evaluateContentView)
        
        self.evaluateContentView.snp.makeConstraints { (make) in
            make.top.equalTo(self.starView.snp.bottom).offset(10)
            make.left.right.equalTo(self.starView)
            make.height.equalTo(150)
            make.bottom.equalTo(centerView).offset(-10)
        }
        
        
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.evaluateContentView.layer.borderWidth = BMBorderSize
        self.evaluateContentView.layer.borderColor = UIColor(hex: BMBorderColor).cgColor
    }
    

    //MARK: 加载网络数据
    private func loadData(){
        
    }
    
    
    //MARK: 发表评论点击事件
    func sendClick(){
        
    }

}
