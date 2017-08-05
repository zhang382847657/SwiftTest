//
//  BMAuntServicesTypeScrollView.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/8/4.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit
import SwiftyJSON

class BMAuntServicesTypeScrollView: UIScrollView {
    
    var contentView:UIView!
    var pageControl: UIPageControl!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadConfig()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadConfig()
    }
    
    private func loadConfig(){
        
        self.backgroundColor = UIColor.white
        self.isPagingEnabled = true
        
        self.contentView = UIView(frame: CGRect.zero)
        self.contentView.backgroundColor = UIColor.green
        self.addSubview(self.contentView)
        self.contentView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
            make.height.equalTo(self.snp.height)
            make.width.greaterThanOrEqualTo(0)
        }
        
        self.pageControl = UIPageControl(frame: CGRect.zero)
        self.pageControl.numberOfPages = 5
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.purple
        self.pageControl.backgroundColor = UIColor.black
        self.addSubview(self.pageControl)
        self.pageControl.snp.makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.bottom.equalTo(self.snp.bottom).offset(-5)
            make.height.equalTo(15)
        }
        
    }
    
    
    func updateWithServiceType(serviceType:JSON) {
        
        
        let array:Array? = serviceType.array
        
        if let array = array{
        

            for i in 0..<array.count{
                let serviceTypeView:BMAuntServiceTypeView = UIView.loadViewFromNib(nibName: "BMAuntServiceTypeView") as! BMAuntServiceTypeView
                self.contentView.addSubview(serviceTypeView)
                
                
                serviceTypeView.snp.makeConstraints({ (make) in
                    
                    make.top.bottom.equalTo(self.contentView)
                    make.width.equalTo(self.snp.width)
                    if i > 0, let lastView = self.contentView.subviews[i - 1] as? BMAuntServiceTypeView {
                        make.left.equalTo(lastView.snp.right)
                    } else {
                        make.left.equalTo(self.contentView)   //labelGapX为固定值
                    }
                    
                    if i == array.count-1 {
                        self.contentView.snp.makeConstraints({ (make) in
                            make.right.equalTo(serviceTypeView.snp.right)
                        })
                    }
                
                })
                
                
            }
        }

    }

        
    
}
