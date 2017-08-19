//
//  BMConvertStoreCardViewController.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/8/18.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit

class BMConvertStoreCardViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var inputBgView: UIView! //输入卡密视图
    @IBOutlet weak var inputLeftLabel: UILabel! //输入卡密左侧文案
    @IBOutlet weak var inputTextField: UITextField!  //卡密输入框
    @IBOutlet weak var emptyBtn: UIButton! //空视图
    @IBOutlet weak var convertBtn: UIButton!  //兑换按钮
    @IBOutlet weak var storeCardView: UIView! //储值卡卡片视图
    
    @IBOutlet weak var storeCardNameLabel: UILabel! //储值卡名字
    @IBOutlet weak var storeCardPriceLabel: UILabel! //储值卡价格
    @IBOutlet weak var storeCardTimeLabel: UILabel!  //储值卡有效期
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "兑换储值卡"
        self.inputBgView.layer.cornerRadius = self.inputBgView.bounds.size.height/2.0
        self.storeCardView.layer.cornerRadius = 5
        self.emptyBtn.set(image: UIImage(named: "add_stored_card_default"), title: "请输入卡密兑换储值卡", titlePosition: .bottom, additionalSpacing: 6, state: .normal)
        self.inputLeftLabel.addBorderLayer(color: UIColor.colorWithHexString(hex: BMSmallTitleColor), size: BMBorderSize, boderType: BorderType.right)
        self.storeCardView.isHidden = true //先让储值卡卡片视图隐藏
        self.emptyBtn.isHidden = false //让空视图先显示
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //兑换按钮点击事件
    @IBAction func convertClick(_ sender: UIButton) {
    }
    
    //UITextField - Delegate
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        
        
        return true
    }
    



}
