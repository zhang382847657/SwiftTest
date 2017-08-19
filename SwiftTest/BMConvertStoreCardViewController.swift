//
//  BMConvertStoreCardViewController.swift
//  SwiftTest
//  兑换储值卡页面
//  Created by 张琳 on 2017/8/18.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit
import SwiftyJSON
import PKHUD

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
    
    var card:JSON? = nil //储值卡对象
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "兑换储值卡"
        self.inputBgView.layer.cornerRadius = self.inputBgView.bounds.size.height/2.0
        self.storeCardView.layer.cornerRadius = 5
        self.emptyBtn.set(image: UIImage(named: "add_stored_card_default"), title: "请输入卡密兑换储值卡", titlePosition: .bottom, additionalSpacing: 6, state: .normal)
        self.inputLeftLabel.addBorderLayer(color: UIColor.colorWithHexString(hex: BMSmallTitleColor), size: BMBorderSize, boderType: BorderType.right)
        self.storeCardView.isHidden = true //先让储值卡卡片视图隐藏
        self.emptyBtn.isHidden = false //让空视图先显示
        self.convertBtn.isEnabled = false //兑换按钮不可点击
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    //MARK: 兑换按钮点击事件
    @IBAction func convertClick(_ sender: UIButton) {
        
        if let card = self.card{
            let cardNo:String? = card["cardNo"].string
            let cardPwd:String? = card["cardPwd"].string
            
            if let cardNo = cardNo , let cardPwd = cardPwd{
                
                let url = "\(BMHOST)/cuserPcardSale/queryByPwd"
                let params:Dictionary<String,Any> = ["cardNo":cardNo,"cardPwd":cardPwd]
                
                NetworkRequest.sharedInstance.postRequest(urlString: url, params: params, isLogin: true, success: { (value) in
                    
                    HUD.flash(.label("兑换成功"), delay: 2.0)
                    
                }) { (error) in
                    
                    
                }
                
            }else{
                dPrint(item: "没有cardNo或者cardPwd")
            }
            
        }else{
            dPrint(item: "储值卡对象为nil")
        }
        
    }
    
    //MARK: UITextField - Delegate
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        
        let text:String? = textField.text
        if let text = text , text.trimmingCharacters(in: .whitespaces) != "" {
            
            let finalText:String = text.trimmingCharacters(in: .whitespaces)
           
            if finalText.characters.count >= 15{
                self.getStroeCard(cardPwd: finalText)
            }
        }
        
        
        return true
    }
    

    
    //MARK: 通过卡密查找对应储值卡
    
    /**
     * 通过卡密查找对应储值卡
     * - Parameter cardPwd:卡密
     * - Returns: 无
     */

    private func getStroeCard(cardPwd:String){
    

        let url = "\(BMHOST)/cuserPcardSale/queryByPwd"
        let params = ["cardPwd":cardPwd]
        
        NetworkRequest.sharedInstance.postRequest(urlString: url, params: params, isLogin: true, success: { (value) in
            
            self.convertBtn.isEnabled = true //兑换按钮可以使用了
            let card:JSON = value["card"]
            self.card = card
            let kindName:String? = card["kindName"].string
            let parvalue:Float? = card["parvalue"].float
            let termState:Int? = card["termState"].int
            
            if let kindName = kindName {
                self.storeCardNameLabel.text = kindName
            }else{
                self.storeCardNameLabel.text = "暂无储值卡名字"
            }
            
            if let parvalue = parvalue{
                self.storeCardPriceLabel.text = "面值￥\(parvalue)"
            }else{
                self.storeCardPriceLabel.text = "面值￥--"
            }
            
            if let termState = termState{
                if termState == 1{
                    
                }
            }
            
           

        }) { (error) in
            
            self.convertBtn.isEnabled = false //兑换按钮不可以使用
        }
    }
    

}
