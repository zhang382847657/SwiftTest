//
//  BMCardUsageLogView.swift
//  SwiftTest
//  使用记录
//  Created by 张琳 on 2017/8/11.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit
import SwiftyJSON

class BMCardUsageLogView: UIView {

    @IBOutlet weak var contentView: UIView!
    
    
    
    func updateWithUsageLogs(usageLogs:Array<JSON>?){
        
        if let usageLogs = usageLogs{
            
            if usageLogs.count > 0{
                for  i in 0..<usageLogs.count{
                    
                    let cellView:BMCardUsageLogCellView = UIView.loadViewFromNib(nibName: "BMCardUsageLogCellView") as! BMCardUsageLogCellView
                    cellView.updateWithLog(log: usageLogs[i])
                    self.contentView.addSubview(cellView)
                    cellView.snp.makeConstraints({ (make) in
                        make.left.right.equalTo(self.contentView)
                        make.height.equalTo(21)
                        if i > 0, let lastView = self.contentView.subviews[i - 1] as? BMCardUsageLogCellView {
                            make.top.equalTo(lastView.snp.bottom)
                        } else {
                            make.top.equalTo(self.contentView)
                        }
                        
                        if i == usageLogs.count-1 {
                            self.contentView.snp.makeConstraints({ (make) in
                                make.bottom.equalTo(cellView.snp.bottom)
                            })
                        }
                    })
                }
            }else{
                let emptyLabel = UILabel(frame: CGRect.zero)
                emptyLabel.text = "暂无使用记录"
                emptyLabel.textAlignment = .center
                emptyLabel.font = UIFont.systemFont(ofSize: BMSmallTitleFontSize)
                emptyLabel.textColor = UIColor.colorWithHexString(hex: BMSmallTitleColor)
                self.contentView.addSubview(emptyLabel)
                emptyLabel.snp.makeConstraints({ (make) in
                    make.top.equalTo(self.contentView).offset(20)
                    make.bottom.equalTo(self.contentView).offset(-20)
                    make.left.right.equalTo(self.contentView)
                })
            }
            
        }else{
            dPrint(item: "使用记录为nil")
        }
    }
    
    

}
