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
    var payBtn:UIButton!  //付款按钮

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
        self.cancelBtn.setTitleColor(UIColor.colorWithHexString(hex: BMSmallTitleColor), for: .normal)
        self.cancelBtn.titleLabel?.font = UIFont.systemFont(ofSize: BMSubTitleFontSize)
        self.cancelBtn.addTarget(self, action: #selector(cancelClick), for: .touchUpInside)
        self.addSubview(self.cancelBtn)
        
        
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
     */
    func updateWithShowPay(showPay:Bool,showCancel:Bool){
        
        
        for view in self.subviews{
            view.removeFromSuperview()
        }
        
        self.loadConfig()
    
        if showCancel == true{
            
            self.cancelBtn.snp.makeConstraints { (make) in
                make.width.equalTo(65)
                make.height.equalTo(26)
                make.top.equalTo(8)
                make.bottom.equalTo(-8)
                make.right.equalTo(self.snp.right).offset(-10)
            }
            
            if showPay == true{
                
                self.payBtn.snp.makeConstraints { (make) in
                    make.width.equalTo(65)
                    make.height.equalTo(26)
                    make.top.equalTo(8)
                    make.bottom.equalTo(-8)
                    make.right.equalTo(cancelBtn.snp.left).offset(-10)
                }
            }
            
        }else{
            if showPay == true{
                self.payBtn.snp.makeConstraints { (make) in
                    make.width.equalTo(65)
                    make.height.equalTo(26)
                    make.top.equalTo(8)
                    make.bottom.equalTo(-8)
                    make.right.equalTo(self.snp.right).offset(-10)
                }
            }
        }
        
        
        
        
    }
    
    
    //付款点击事件
    func payClick(sender:UIButton){
        
    }
    
    //申请取消点击事件
    func cancelClick(sender:UIButton){
        
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.addBorderLayer(color: UIColor.colorWithHexString(hex: BMBorderColor), size: BMBorderSize, boderType: BorderType.top)
        
        self.cancelBtn.layer.borderColor = UIColor.colorWithHexString(hex: BMBorderColor).cgColor
        self.cancelBtn.layer.borderWidth = BMBorderSize
        
        self.payBtn.layer.borderColor = UIColor.red.cgColor
        self.payBtn.layer.borderWidth = BMBorderSize
    }

}
