//
//  BMOrderCancelHeaderView.swift
//  SwiftTest
//  订单详情——已取消头部视图
//  Created by 张琳 on 2017/8/25.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit

class BMOrderCancelHeaderView: UIView {

    @IBOutlet weak var titleLabel: UILabel!

    func updateWithTitle(title:String) {
        self.titleLabel.text = title
    }
}
