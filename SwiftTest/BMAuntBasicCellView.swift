//
//  BMAuntBasicCellView.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/8/5.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit

class BMAuntBasicCellView: UIView {

    @IBOutlet weak var titleLabel: UILabel!  //左侧标题
    @IBOutlet weak var contentLabel: UILabel!  //右侧内容
    
    func updateWithBasic(basic:Dictionary<String,String>){
        
        titleLabel.text = basic["text"]
        contentLabel.text = basic["value"]
        
    }
    
    
    

}
