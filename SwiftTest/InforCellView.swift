//
//  InforCellView.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/7/28.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit

//点击的闭包
typealias InfoCellClickClosure = () -> Void

class InforCellView: UIView {

    var leftTitleLabel:UILabel!
    var rightTitleLabel:UILabel!
    var imageView:UIImageView!
    
    var infoCellClickClosure: InfoCellClickClosure? //点击回调
    

    //初始化时将xib中的view添加进来
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadConfig()
    }
    
    //初始化时将xib中的view添加进来
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadConfig()
    }
    
    //初始化默认属性配置
    private func loadConfig(){
        
        
        ///////////////左侧标题/////////////
        self.leftTitleLabel = UILabel(frame: CGRect.zero)
        self.leftTitleLabel.font = UIFont.systemFont(ofSize: BMTitleFontSize)
        self.leftTitleLabel.textColor = UIColor.colorWithHexString(hex: BMTitleColor)
        self.addSubview(self.leftTitleLabel)
        
        self.leftTitleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(12)
            make.centerY.equalTo(self.snp.centerY)
        }
        
        
        ///////////////右侧箭头/////////////
        self.imageView = UIImageView(frame: CGRect.zero)
        self.imageView.image = UIImage(named: "infor")
        self.addSubview(self.imageView)
        
        self.imageView.snp.makeConstraints { (make) in
            make.right.equalTo(self.snp.right).offset(-12)
            make.width.equalTo(7)
            make.height.equalTo(12)
            make.centerY.equalTo(self.snp.centerY)
        }
        
        
        ///////////////右侧文字//////////////
        self.rightTitleLabel = UILabel(frame: CGRect.zero)
        self.rightTitleLabel.font = UIFont.systemFont(ofSize: BMSmallTitleFontSize)
        self.rightTitleLabel.textColor = UIColor.colorWithHexString(hex: BMSmallTitleColor)

        self.addSubview(self.rightTitleLabel)
        
        self.rightTitleLabel.snp.makeConstraints { (make) in
            make.right.equalTo(self.imageView.snp.left).offset(-5)
            make.centerY.equalTo(self.snp.centerY)
        }
        
        
        ///////////////添加点击手势////////////
        let singleTap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapClick))
        self.addGestureRecognizer(singleTap)
        
    }
    
    
    func tapClick(sender:UITapGestureRecognizer){
        
        dPrint(item: "我被点击了")
        
        if let infoCellClickClosure = self.infoCellClickClosure{
            infoCellClickClosure()
        }
        
    }


}
