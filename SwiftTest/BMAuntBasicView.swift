//
//  BMAuntBasicView.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/8/5.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit
import SwiftyJSON

class BMAuntBasicView: UIView {
    
    var contentView:UIView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadConofig()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadConofig()
    }
    
    

    private func loadConofig(){
        self.backgroundColor = UIColor.white
        self.contentView = UIView(frame: CGRect.zero)
        self.addSubview(self.contentView)
        self.contentView.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(10)
            make.left.equalTo(self.snp.left).offset(10)
            make.right.equalTo(self.snp.right).offset(-10)
            make.bottom.equalTo(self.snp.bottom).offset(-10)
            make.height.greaterThanOrEqualTo(0)
        }
    }
    
    
    func updateWithBasics(basics:Array<Dictionary<String,String>>){
        
        for i in 0..<basics.count{
            let basicCellView:BMAuntBasicCellView = UIView.loadViewFromNib(nibName: "BMAuntBasicCellView") as! BMAuntBasicCellView
            basicCellView.updateWithBasic(basic: basics[i])
            self.contentView.addSubview(basicCellView)
            
            
            basicCellView.snp.makeConstraints({ (make) in
                
                make.left.right.equalTo(self.contentView)

                if i > 0, let lastView = self.contentView.subviews[i - 1] as? BMAuntBasicCellView {
                    make.top.equalTo(lastView.snp.bottom).offset(5)
                } else {
                    make.top.equalTo(self.contentView)
                }
                
                if i == basics.count - 1 {
                    
                    self.contentView.snp.makeConstraints({ (make) in
                        make.bottom.equalTo(basicCellView.snp.bottom)
                    })
                
                }
                
            })
        }
        
        
        
    }


}
