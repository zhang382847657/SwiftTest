//
//  BMOrderCleanHeaderView.swift
//  SwiftTest
//  订单详情——保洁单头部
//  Created by 张琳 on 2017/8/25.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit

class BMOrderCleanHeaderView: UIView {

    @IBOutlet weak var oneTopView: UIView!
    @IBOutlet weak var twoTopView: UIView!
    @IBOutlet weak var threeTopView: UIView!
    @IBOutlet weak var fourTopView: UIView!
    @IBOutlet weak var fiveTopView: UIView!
    
    @IBOutlet weak var oneImageView: UIImageView!
    @IBOutlet weak var oneLabel: UILabel!
    @IBOutlet weak var twoImageView: UIImageView!
    @IBOutlet weak var twoLabel: UILabel!
    @IBOutlet weak var threeImageView: UIImageView!
    @IBOutlet weak var threeLabel: UILabel!
    @IBOutlet weak var fourImageView: UIImageView!
    @IBOutlet weak var fourLabel: UILabel!
    @IBOutlet weak var fiveImageVIew: UIImageView!
    @IBOutlet weak var fiveLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.oneTopView.layer.borderColor = UIColor.white.cgColor
        self.oneTopView.layer.borderWidth = 1.0
        self.oneTopView.layer.cornerRadius = self.oneTopView.bounds.size.width/2.0
        self.oneTopView.layer.masksToBounds = true
        self.oneLabel.isHidden = true
        self.oneImageView.isHidden = false
        
        self.twoTopView.layer.borderColor = UIColor.white.cgColor
        self.twoTopView.layer.borderWidth = 1.0
        self.twoTopView.layer.cornerRadius = self.twoTopView.bounds.size.width/2.0
        self.twoTopView.layer.masksToBounds = true
        self.twoLabel.isHidden = false
        self.twoImageView.isHidden = true
        
        self.threeTopView.layer.borderColor = UIColor.white.cgColor
        self.threeTopView.layer.borderWidth = 1.0
        self.threeTopView.layer.cornerRadius = self.threeTopView.bounds.size.width/2.0
        self.threeTopView.layer.masksToBounds = true
        self.threeLabel.isHidden = false
        self.threeImageView.isHidden = true
        
        self.fourTopView.layer.borderColor = UIColor.white.cgColor
        self.fourTopView.layer.borderWidth = 1.0
        self.fourTopView.layer.cornerRadius = self.fourTopView.bounds.size.width/2.0
        self.fourTopView.layer.masksToBounds = true
        self.fourLabel.isHidden = false
        self.fourImageView.isHidden = true
        
        self.fiveTopView.layer.borderColor = UIColor.white.cgColor
        self.fiveTopView.layer.borderWidth = 1.0
        self.fiveTopView.layer.cornerRadius = self.fiveTopView.bounds.size.width/2.0
        self.fiveTopView.layer.masksToBounds = true
        self.fiveLabel.isHidden = false
        self.fiveImageVIew.isHidden = true
    }

}
