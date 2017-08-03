//
//  BMShopRecommendAuntView.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/8/2.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit
import SwiftyJSON

class BMShopRecommendAuntView: UIView {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var headerView: UIView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        headerView.addBorderLayer(color: UIColor.colorWithHexString(hex: BMBorderColor), size: BMBorderSize, boderType: BorderType.bottom)
        
    
    }
    
    func updateWithRecommendAunts(aunts:JSON){
    
        let auntArray:Array? = aunts.array
        
        if let auntArray = auntArray{
            
            var lastView:UIView? = nil
            
            for aunt in auntArray{
                
                let view = UIView(frame: CGRect.zero)
                self.contentView.addSubview(view)
                
                let auntView:BMShopAuntView = UIView.loadViewFromNib(nibName: "BMShopAuntView") as! BMShopAuntView
                auntView.updateWithAunt(aunt: aunt)
                view.addSubview(auntView)
                
                auntView.snp.makeConstraints({ (make) in
                    make.center.equalTo(view.snp.center)
                    make.left.equalTo(view).offset(10)
                    make.right.equalTo(view).offset(-10)
                    make.height.equalTo(auntView.snp.width)
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
                        
                        make.width.equalTo(self.contentView.bounds.size.width/CGFloat(auntArray.count))
                    })
                }
                
                lastView = view
                
            }
        }
    
    }

}
