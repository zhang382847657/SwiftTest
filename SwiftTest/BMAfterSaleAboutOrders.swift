//
//  BMAfterSaleAboutOrders.swift
//  SwiftTest
//  售后单——相关订单
//  Created by 张琳 on 2017/8/24.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit
import SwiftyJSON

class BMAfterSaleAboutOrders: UIView {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    func updateWithAboutOrders(aboutOrders:JSON?){
        
//        let array:Array<JSON> = aboutOrders.arrayValue
        
        for i in 0..<10 {
            
            let cellView:BMAfterSaleAboutOrdersCellView = UIView.loadViewFromNib(nibName: "BMAfterSaleAboutOrdersCellView") as! BMAfterSaleAboutOrdersCellView!
            self.bottomView.addSubview(cellView)
            
            cellView.snp.makeConstraints({ (make) in
                make.left.right.equalTo(self.bottomView)
                
                if i == 0 {
                    make.top.equalTo(self.bottomView).offset(15)
                }else{
                    let view:BMAfterSaleAboutOrdersCellView = self.bottomView.subviews[i-1] as! BMAfterSaleAboutOrdersCellView
                    make.top.equalTo(view.snp.bottom)
                }
                
                if i == 9{
                    make.bottom.equalTo(self.bottomView.snp.bottom)
                }
            })
        }
        
        
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.topView.addBorderLayer(color: UIColor.colorWithHexString(hex: BMBorderColor), size: BMBorderSize, boderType: BorderType.bottom)
    }

}
