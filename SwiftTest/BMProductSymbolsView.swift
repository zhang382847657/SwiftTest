//
//  BMProductSymbolsView.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/7/21.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit

class BMProductSymbolsView: UIView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var centerView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.centerView.layer.cornerRadius = 35
    }
    
    
    
    //减号点击事件
    @IBAction func minusClick(_ sender: UIButton) {
    }
    
    
    //加号点击事件
    @IBOutlet weak var addClick: UIButton!
    

}
