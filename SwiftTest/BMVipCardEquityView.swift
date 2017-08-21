//
//  BMVipCardEquityView.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/8/21.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit

class BMVipCardEquityView: UIView {
    
    var titleLabel:UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        ////////////标题/////////////////
        self.titleLabel = UILabel(frame: CGRect.zero)
        self.titleLabel.text = "您可以享受以下权益"
        self.titleLabel.textAlignment = .center
        self.titleLabel.textColor = UIColor.colorWithHexString(hex: BMSmallTitleColor)
        self.titleLabel.font = UIFont.systemFont(ofSize: BMSubTitleFontSize)
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self)
            make.height.equalTo(46)
        }
        
        let one:BMVipCardEquityCellView = BMVipCardEquityCellView(title: "部分商品5.5折优惠", content: "1分钱、深度保洁、育儿嫂、接我人、沃日uwioeu、为瑞文euroIE无肉无恶日文UR、未入围如")
        self.addSubview(one)
        one.snp.makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(self.titleLabel.snp.bottom)
        }
        
        let two:BMVipCardEquityCellView = BMVipCardEquityCellView(title: "部分商品6.5折优惠", content: "1分钱、深度保洁、育儿嫂、接我人、沃日uwioeu、为瑞文euroIE无肉无恶日文UR、未入围如")
        self.addSubview(two)
        two.snp.makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(one.snp.bottom)
        }
        
        let three:BMVipCardEquityCellView = BMVipCardEquityCellView(title: "赠送优惠券", content: "100元优惠券 1张、保洁类优惠券3张")
        self.addSubview(three)
        three.snp.makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(two.snp.bottom)
            make.bottom.equalTo(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
