//
//  BMFriendsBargain.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/6/26.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit

class BMFriendsBargainView: UIImageView {
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.contentMode = .scaleAspectFill
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    /**
     * 好友砍价是否显示
     * param: isShow  是否显示
     */
    func isShow(isShow:Bool){
        
        switch isShow {
        case true:
            self.image = UIImage(named: "haoyoukanjia")
        default:
            self.image = nil
        }
    }

}
