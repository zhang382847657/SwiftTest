//
//  BMOrderBottomView.swift
//  SwiftTest
//  订单列表底部视图  用来显示 申请取消、付款按钮
//  Created by 张琳 on 2017/8/23.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit

class BMOrderBottomView: UIView {
    
    
    var cancelBtn:UIButton! //申请取消按钮
    var showAuntBtn:UIButton! //查看阿姨按钮
    var showContractBtn:UIButton! //查看合同按钮
    var evaluateBtn:UIButton! //评价、查看评价按钮
    var payBtn:UIButton!  //付款按钮
    var tradeNo:String = ""  //订单编号
    var flowStatus:String = "" //订单状态

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadConfig()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadConfig()
    }
    
    
    /**
     *  布局基本信息
     */
    private func loadConfig(){
        
        //////////申请取消按钮////////////
        self.cancelBtn = UIButton(type: .custom)
        self.cancelBtn.frame = CGRect.zero
        self.cancelBtn.setTitle("申请取消", for: .normal)
        self.cancelBtn.setTitleColor(UIColor(hex: BMSmallTitleColor), for: .normal)
        self.cancelBtn.titleLabel?.font = UIFont.systemFont(ofSize: BMSubTitleFontSize)
        self.cancelBtn.addTarget(self, action: #selector(cancelClick), for: .touchUpInside)
        self.addSubview(self.cancelBtn)
        
        
        ///////////查看阿姨按钮///////////
        self.showAuntBtn = UIButton(type: .custom)
        self.showAuntBtn.frame = CGRect.zero
        self.showAuntBtn.setTitle("查看阿姨", for: .normal)
        self.showAuntBtn.setTitleColor(UIColor(hex: BMSmallTitleColor), for: .normal)
        self.showAuntBtn.titleLabel?.font = UIFont.systemFont(ofSize: BMSubTitleFontSize)
        self.showAuntBtn.addTarget(self, action: #selector(auntClick), for: .touchUpInside)
        self.addSubview(self.showAuntBtn)
        
        //////////查看合同按钮/////////////
        self.showContractBtn = UIButton(type: .custom)
        self.showContractBtn.frame = CGRect.zero
        self.showContractBtn.setTitle("查看合同", for: .normal)
        self.showContractBtn.setTitleColor(UIColor(hex: BMSmallTitleColor), for: .normal)
        self.showContractBtn.titleLabel?.font = UIFont.systemFont(ofSize: BMSubTitleFontSize)
        self.showContractBtn.addTarget(self, action: #selector(contractClick), for: .touchUpInside)
        self.addSubview(self.showContractBtn)
        
        
        ///////////评价按钮//////////////
        self.evaluateBtn = UIButton(type: .custom)
        self.evaluateBtn.frame = CGRect.zero
        self.evaluateBtn.setTitle("评价", for: .normal)
        self.evaluateBtn.setTitleColor(UIColor(hex: "#FFB912"), for: .normal)
        self.evaluateBtn.titleLabel?.font = UIFont.systemFont(ofSize: BMSubTitleFontSize)
        self.evaluateBtn.addTarget(self, action: #selector(evaluateClick), for: .touchUpInside)
        self.addSubview(self.evaluateBtn)
        
        //////////付款按钮////////////
        self.payBtn = UIButton(type: .custom)
        self.payBtn.frame = CGRect.zero
        self.payBtn.setTitle("付款", for: .normal)
        self.payBtn.setTitleColor(UIColor.red, for: .normal)
        self.payBtn.titleLabel?.font = UIFont.systemFont(ofSize: BMSubTitleFontSize)
        self.payBtn.addTarget(self, action: #selector(payClick), for: .touchUpInside)
        self.addSubview(self.payBtn)
    }
    
    /**
     *  更新底部视图
     * @params showPay 是否显示付款
     * @params showCancel 是否显示申请取消
     * @params showAunt 是否显示阿姨
     * @params showContract 是否显示合同
     * @params showEvaluate 是否显示评价
     * @params evaluateState 评价状态  1已评价  0未评价
     * @params tradeNo 订单编号
     * @params flowStatus 订单状态
     */
    func updateWithShowPay(showCancel:Bool,showAunt:Bool,showContract:Bool,
                           showEvaluate:Bool,showPay:Bool,evaluateState:Int?,tradeNo:String, flowStatus:String){
        
        self.tradeNo = tradeNo
        
        for view in self.subviews{
            view.removeFromSuperview()
        }
        
        self.loadConfig()
        
        var btnArray:Array<UIButton> = []
        if showPay == true{
            btnArray.append(self.payBtn)
        }
        if showEvaluate == true{
            btnArray.append(self.evaluateBtn)
        }
        if showContract == true{
            btnArray.append(self.showContractBtn)
        }
        if showAunt == true{
            btnArray.append(self.showAuntBtn)
        }
        if showCancel == true{
            btnArray.append(self.cancelBtn)
        }
        
        for i in 0..<btnArray.count{
            
            let btn:UIButton = btnArray[i]
            btn.snp.makeConstraints({ (make) in
                make.width.equalTo(65)
                make.height.equalTo(26)
                make.top.equalTo(8)
                make.bottom.equalTo(-8)
                
                if i == 0{
                    make.right.equalTo(self.snp.right).offset(-10)
                }else{
                    let lastBtn:UIButton = btnArray[i-1]
                    make.right.equalTo(lastBtn.snp.left).offset(-10)
                }
                
            })
        }
        
        
        if let evaluateState = evaluateState{
            if evaluateState == 0{
                self.evaluateBtn.setTitle("评价", for: .normal)
            }else if evaluateState == 1{
                self.evaluateBtn.setTitle("查看评价", for: .normal)
            }
        }
    }
    
    
    //付款点击事件
    func payClick(sender:UIButton){
        
    }
    
    //申请取消点击事件
    func cancelClick(sender:UIButton){
        
    }
    
    //查看阿姨点击事件
    func auntClick(sender:UIButton){
        
        let vc:BMOrderListViewController = self.getViewController() as! BMOrderListViewController
       
        let auntListVC:BMOrderServicesAuntListViewController = BMOrderServicesAuntListViewController(tradeNo: self.tradeNo, flowStatus: self.flowStatus)
        auntListVC.hidesBottomBarWhenPushed = true
        vc.navigationController?.pushViewController(auntListVC, animated: true)
    }
    
    //评价、查看评价点击事件
    func evaluateClick(sender:UIButton){
        let vc:BMOrderListViewController = self.getViewController() as! BMOrderListViewController
        let evaluateVC:BMEvaluateViewController = BMEvaluateViewController(tradeNo: "")
        evaluateVC.hidesBottomBarWhenPushed = true
        vc.navigationController?.pushViewController(evaluateVC, animated: true)
    }
    
    //查看合同点击事件
    func contractClick(sender:UIButton){
        
        let vc:BMOrderListViewController = self.getViewController() as! BMOrderListViewController
        let url:String = "\(BMHOST)/contract/createContract?tradeNo=\(self.tradeNo)"
        let webViewController:BMWebViewController = BMWebViewController(url:url )
        webViewController.title = "合同信息"
        webViewController.hidesBottomBarWhenPushed = true
        vc.navigationController?.pushViewController(webViewController, animated: true)
    
    }

    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.addBorderLayer(color: UIColor(hex: BMBorderColor), size: BMBorderSize, boderType: BorderType.top)
        
        self.cancelBtn.layer.borderColor = UIColor(hex: BMBorderColor).cgColor
        self.cancelBtn.layer.borderWidth = BMBorderSize
        
        self.showAuntBtn.layer.borderColor = UIColor(hex: BMBorderColor).cgColor
        self.showAuntBtn.layer.borderWidth = BMBorderSize
        
        self.showContractBtn.layer.borderColor = UIColor(hex: BMBorderColor).cgColor
        self.showContractBtn.layer.borderWidth = BMBorderSize
        
        self.evaluateBtn.layer.borderColor = UIColor(hex: "#FFB912").cgColor
        self.evaluateBtn.layer.borderWidth = BMBorderSize
        
        self.payBtn.layer.borderColor = UIColor.red.cgColor
        self.payBtn.layer.borderWidth = BMBorderSize
    }

}
