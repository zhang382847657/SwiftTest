//
//  CodeButton.swift
//  SwiftTest
//  验证码按钮
//  Created by 张琳 on 2017/8/1.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit

class CodeButton: UIButton {
    
    var countdownTimer: Timer? //计时器
    var remainingSeconds: Int = 0 {
        willSet {
            self.setTitle("\(newValue)秒后获取", for: .normal)
            if newValue <= 0 {
                self.setTitle("重新获取", for: .normal)
                isCounting = false
            }
        }
    }
    
    var isCounting = false {
        willSet {
            if newValue {
                countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector:#selector(updateTime), userInfo: nil, repeats: true)
                remainingSeconds = 60
                self.setTitleColor(UIColor.gray, for: .normal)
            } else {
                countdownTimer?.invalidate()
                countdownTimer = nil
                self.setTitleColor(UIColor.white, for: .normal)
            }
            self.isEnabled = !newValue
        }
    }

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setConfig()//设置基本配置
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setConfig()//设置基本配置
    }
    
    
    //设置基本配置
    private func setConfig(){
        self.addTarget(self, action: #selector(sendCode), for: .touchUpInside) //添加点击事件
        self.addBorder(color: UIColor.white, size: BMBorderSize, borderTypes: [BorderType.top.rawValue,BorderType.bottom.rawValue,BorderType.left.rawValue,BorderType.right.rawValue])
    }
    
    
    //倒计时
    func updateTime(timer: Timer) {
        // 计时开始时，逐秒减少remainingSeconds的值
        remainingSeconds -= 1
    }
    
    
    //发送验证码
    func sendCode(sender:UIButton){
         isCounting = true
    }
    

    

}
