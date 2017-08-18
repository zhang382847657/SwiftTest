//
//  BMCardsStoreEmptyCell.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/8/18.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit

class BMCardsStoreEmptyCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.bgView.layer.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
