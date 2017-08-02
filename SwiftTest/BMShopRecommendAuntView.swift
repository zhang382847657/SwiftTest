//
//  BMShopRecommendAuntView.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/8/2.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit

class BMShopRecommendAuntView: UIView {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var headerView: UIView!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        headerView.addBorderLayer(color: UIColor.colorWithHexString(hex: BMBorderColor), size: BMBorderSize, boderType: BorderType.bottom)
        
        var lastView:UIView? = nil
        
        
        for _ in 0..<3{
            
            let view = UIView(frame: CGRect.zero)
            self.contentView.addSubview(view)
            
            let auntView:BMShopAuntView = UIView.loadViewFromNib(nibName: "BMShopAuntView") as! BMShopAuntView
            view.addSubview(auntView)
            auntView.snp.makeConstraints({ (make) in
                make.center.equalTo(view.snp.center)
            })
            
            if let lastView = lastView{
                
                view.snp.makeConstraints({ (make) in
                    make.top.bottom.equalTo(lastView)
                    make.left.equalTo(lastView.snp.right)
                    make.width.equalTo(lastView.snp.width)
                })
                
            }else{
                view.snp.makeConstraints({ (make) in
                    make.left.equalTo(self.contentView)
                    make.top.equalTo(self.contentView).offset(10)
                    make.bottom.equalTo(self.contentView).offset(-10)
                    make.width.equalTo(self.contentView.bounds.size.width/3.0)
                })
            }
            
            lastView = view
            
        }
    }

}
