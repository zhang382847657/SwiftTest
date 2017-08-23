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
    
    var serviceDay:Array<JSON>!  //服务计划数组
    var currentIndex:Int = 0 //记录当前滚动的下标
    
    
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
            
            let serviceDayString:String? = task["serviceDay"].string
            if let serviceDayString = serviceDayString{ //如果有服务计划
                
                self.serviceDay = JSON(parseJSON: serviceDayString).arrayValue //把stirng的json字符串转成json对象并再转成数组
                
                if self.serviceDay.count == 1{  //如果只有一个服务计划,两个箭头按钮都隐藏
                    self.leftBtn.isHidden = true
                    self.rightBtn.isHidden = true
                }else{ //先隐藏左侧的按钮
                    self.leftBtn.isHidden = true
                }
                
                for  i in 0..<self.serviceDay.count{
                    
                    let cellView:BMCardServicePlanCellView = UIView.loadViewFromNib(nibName: "BMCardServicePlanCellView") as! BMCardServicePlanCellView
                    cellView.updateWithServicePlan(servicePlan: self.serviceDay[i], task: task)
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
                
                self.leftBtn.isHidden = true  //隐藏左侧箭头按钮
                self.rightBtn.isHidden = true //隐藏右侧箭头按钮
                self.bottomBtn.setTitle("联系门店设置时间", for: .normal)
                self.headerTitleLabel.text = "未设置服务计划"
                
                
                ////////加载暂无服务计划的图片//////
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

    //左侧箭头点击事件
    @IBAction func leftClick(_ sender: UIButton) {
        
        self.currentIndex = self.currentIndex - 1
        
        self.rightBtn.isHidden = false
        
        if self.currentIndex == 0 {
            self.leftBtn.isHidden = true
        }
        
        
        self.scrollView.setContentOffset(CGPoint(x: self.scrollView.bounds.size.width * CGFloat(self.currentIndex), y: 0), animated: true)
        
    }
    
    //右侧箭头点击事件
    @IBAction func rightClick(_ sender: UIButton) {
        
        self.currentIndex = self.currentIndex + 1
        
        self.leftBtn.isHidden = false
        
        if self.currentIndex == self.serviceDay.count - 1 {
            self.rightBtn.isHidden = true
        }
        
        
        self.scrollView.setContentOffset(CGPoint(x: self.scrollView.bounds.size.width * CGFloat(self.currentIndex), y: 0), animated: true)
    }

    //联系门店点击事件
    @IBAction func callShopClick(_ sender: UIButton) {
    }
    
    //问号点击事件
    @IBAction func questionClick(_ sender: UITapGestureRecognizer) {
    }
}
