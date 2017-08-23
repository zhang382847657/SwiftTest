//
//  BMOrderBottomView.swift
//  SwiftTest
//  订单列表底部视图  用来显示 申请取消、付款按钮
//  Created by 张琳 on 2017/8/23.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit

class BMOrderBottomView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /**
     *  更新底部视图
     * @params showPay 是否显示付款
     * @params showCancel 是否显示申请取消
     */
    func updateWithShowPay(showPay:Bool,showCancel:Bool){
        
    }

}
