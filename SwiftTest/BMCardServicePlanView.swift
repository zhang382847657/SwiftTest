//
//  BMCardServicePlanView.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/8/10.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit
import SwiftyJSON

class BMCardServicePlanView: UIView {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerTitleLabel: UILabel!
   
    @IBOutlet weak var leftBtn: UIButton!
    @IBOutlet weak var rightBtn: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var bottomBtn: UIButton!
    
    
    override func awakeFromNib() {
        
        self.headerView.addBorderLayer(color: UIColor.colorWithHexString(hex: BMBorderColor), size: BMBorderSize, boderType: BorderType.bottom)
    }
    
    
    func updateWithServicePlans(task:JSON?){
        
        let contentView:UIView = UIView(frame: CGRect.zero)
        contentView.backgroundColor = UIColor.white
        self.scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.scrollView)
            make.height.equalTo(self.scrollView.snp.height)
            make.width.greaterThanOrEqualTo(0)
        }
        
        if let task = task{
            
            let serviceDay:Array<JSON>? = task["serviceDay"].array
            
            if let serviceDay = serviceDay {
                
                for  i in 0..<serviceDay.count{
                    
                    let cellView:BMCardServicePlanCellView = UIView.loadViewFromNib(nibName: "BMCardServicePlanCellView") as! BMCardServicePlanCellView
                    cellView.updateWithServicePlan(servicePlan: serviceDay[i], task: task)
                    contentView.addSubview(cellView)
                    cellView.snp.makeConstraints({ (make) in
                        make.top.bottom.equalTo(contentView)
                        make.width.equalTo(self.scrollView.snp.width)
                        if i > 0, let lastView = contentView.subviews[i - 1] as? BMCardServicePlanCellView {
                            make.left.equalTo(lastView.snp.right)
                        } else {
                            make.left.equalTo(contentView)
                        }
                        
                        if i == serviceDay.count-1 {
                            contentView.snp.makeConstraints({ (make) in
                                make.right.equalTo(cellView.snp.right)
                            })
                        }
                    })
                }
            }else{
                contentView.snp.makeConstraints({ (make) in
                    make.width.equalTo(self.scrollView.snp.width)
                })
                
                let imageView = UIImageView(frame: CGRect.zero)
                imageView.image = UIImage(named: "alam_clock")
                contentView.addSubview(imageView)
                imageView.snp.makeConstraints({ (make) in
                    make.width.equalTo(99)
                    make.height.equalTo(80)
                    make.center.equalTo(contentView.snp.center)
                })
            }
            
        }else{
            dPrint(item: "服务计划任务为nil")
        }
        
    }

    
    //问号点击事件
    @IBAction func questionClick(_ sender: UITapGestureRecognizer) {
    }
}
