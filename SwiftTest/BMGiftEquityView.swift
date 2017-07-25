//
//  BMGiftEquityView.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/7/24.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit

typealias GiftEquityBackClickClosure = () -> Void

class BMGiftEquityView: UIView {

    @IBOutlet weak var scrollView: UIScrollView!
    var contentView: UIView!
    
    var giftEquityBackClickClosure: GiftEquityBackClickClosure? //赠送权益返回点击回调
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView = UIView(frame: CGRect.zero)
        self.scrollView.addSubview(self.contentView)
        
        self.contentView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.scrollView)
            make.width.equalTo(self.scrollView.snp.width)
            make.height.greaterThanOrEqualTo(0);//此处保证容器View高度的动态变化 大于等于0的高度
        }
    }

    //返回点击事件
    @IBAction func backClick(_ sender: UIButton) {
        
        if let _ = self.giftEquityBackClickClosure {
            self.giftEquityBackClickClosure!()
        }
    }
}
