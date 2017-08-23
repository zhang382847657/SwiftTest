//
//  BMCardServicePlanCellView.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/8/14.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit
import SwiftyJSON

class BMCardServicePlanCellView: UIView {

    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var amOrpmLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    func updateWithServicePlan(servicePlan:JSON,task:JSON){
        
        let time:String? = servicePlan["time"].string
        let frequency:Int? = task["frequency"].int
        let week:Int? = servicePlan["week"].int
        
        if let time = time{
            
            let timeArray = time.components(separatedBy: ":")
            self.timeLabel.text = "\(timeArray[0]) : \(timeArray[1])"
            
            let prefix2 = time.substring(to: time.index(time.startIndex, offsetBy: 2))
            
            if Int(prefix2)! <= 12 {
                self.amOrpmLabel.text = "上午"
            }else{
                self.amOrpmLabel.text = "下午"
            }
            
            
        }else{
            self.timeLabel.text = "--"
            self.amOrpmLabel.text = "--"
        }
    
        if let frequency = frequency{
            self.topLabel.text = frequency == 1 ? " 每周 " : " 每两周 "
        }else{
            self.topLabel.text = "--"
        }
        
        if let week = week{
            
            switch week {
            case 1:
                self.dataLabel.text = "周一"
            case 2:
                self.dataLabel.text = "周二"
            case 3:
                self.dataLabel.text = "周三"
            case 4:
                self.dataLabel.text = "周四"
            case 5:
                self.dataLabel.text = "周五"
            case 6:
                self.dataLabel.text = "周六"
            case 7:
                self.dataLabel.text = "周日"
            default:
                self.dataLabel.text = "--"
            }
            
        }else{
            self.dataLabel.text = "--"
        }
    }
    

}
