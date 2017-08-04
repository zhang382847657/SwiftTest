//
//  BMProductsView.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/7/19.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit
import SwiftyJSON

//返回闭包
typealias BackClickClosure = () -> Void

//查看详情闭包
typealias LookDetailClickClosure = () -> Void

//购物车闭包
typealias OrderCarClickClosure = () -> Void

class BMProductsView: UIView {

    @IBOutlet weak var orderCarBtn: UIButton!
    @IBOutlet weak var abstractLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var bgImageView: UIImageView!
    
    var backClickClosure: BackClickClosure? //返回点击回调
    var lookDetailClickClosure: LookDetailClickClosure? //返回点击回调
    var orderCarClickClosure: OrderCarClickClosure? //购物车点击回调
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.orderCarBtn.layer.cornerRadius = 30
    }
    
    
    
    
    func updateUIWithProduct(product:JSON) {
        
        let name:String? = product["name"].string
        let abstract:String? = product["detail"].string
        let bgUrl:String? = product["bgPicUrl"].string
        
        if let name = name{
            self.productNameLabel.text = name
        }else{
            self.productNameLabel.text = "暂无商品名称"
        }
        
        if let abstract = abstract{
            
            
            let resultJSON:JSON = JSON(parseJSON: abstract)
            dPrint(item: resultJSON)
            
            
            let array:Array = resultJSON.array!
            let string:String? = array[2]["word"].string
            if let string = string{
                self.abstractLabel.attributedText = getAttributeStringWithString(string, lineSpace: 5)
            }else{
                self.abstractLabel.text = "暂无商品描述"
            }
            
            
        }else{
            self.abstractLabel.text = "暂无商品描述"
        }
        
        if let bgUrl = bgUrl , bgUrl != ""{
            self.bgImageView.af_setImage(withURL: URL(string: bgUrl)!, placeholderImage: UIImage(named: "common_clean")!)
        }
        
        
    }
    
    
    /**
     * 返回点击
     */
    @IBAction func backClick(_ sender: UIButton) {
        if let _ = self.backClickClosure {
            self.backClickClosure!()
        }
    }
  
    
    /**
     * 购物车点击
     */
    @IBAction func orderClick(_ sender: UIButton) {
        if let _ = self.orderCarClickClosure {
            self.orderCarClickClosure!()
        }
    }
    
    /**
     * 查看详情点击
     */
    @IBAction func lookDetailClick(_ sender: UIButton) {
        if let _ = self.lookDetailClickClosure {
            self.lookDetailClickClosure!()
        }
    }
    
    

}
