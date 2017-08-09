//
//  BMAuntCerHeaderView.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/8/8.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit

class BMAuntCerHeaderView: UIView {
    
    @IBOutlet weak var numberLabel: UILabel!


    func updateNumber(currentNum:Int , totalNum:Int) {
        self.numberLabel.text = "(\(currentNum)/\(totalNum))"
    }

}
