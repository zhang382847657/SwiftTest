//
//  BMMyOtherInfoView.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/9/1.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit

class BMMyOtherInfoView: UIView {

    @IBOutlet weak var nativePlaceView: InforPickerView! //籍贯
    @IBOutlet weak var familyMembersView: InputView! //家庭成员
    @IBOutlet weak var houseAreaView: InputView! //房屋面积
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.nativePlaceView.titile = "籍贯"
        
        self.familyMembersView.titile = "家庭成员"
        self.familyMembersView.unitText = "人"
        
        self.houseAreaView.titile = "房屋面积"
        self.houseAreaView.unitText = "㎡"
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.nativePlaceView.addBorderLayer(color: UIColor(hex:BMBorderColor), size: BMBorderSize, boderType: BorderType.bottom)
        self.familyMembersView.addBorderLayer(color: UIColor(hex:BMBorderColor), size: BMBorderSize, boderType: BorderType.bottom)
        
        
    }
}
