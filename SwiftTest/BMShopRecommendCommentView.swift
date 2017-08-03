//
//  BMShopRecommendCommentView.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/8/3.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit
import SwiftyJSON

class BMShopRecommendCommentView: UIView {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var contentView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        headerView.addBorderLayer(color: UIColor.colorWithHexString(hex: BMBorderColor), size: BMBorderSize, boderType: BorderType.bottom)
        
        
        
        
    }
    
    func updateWithRecommendComments(comments:JSON){
        
        let commentArray:Array? = comments.array
        
        if let commentArray = commentArray{
            
            var lastView:UIView? = nil
            
            
            for comment in commentArray{
                
                let commentView:BMShopCommentView = UIView.loadViewFromNib(nibName: "BMShopCommentView") as! BMShopCommentView
                commentView.updateWithComment(comment: comment)
                self.contentView.addSubview(commentView)
                
                if let lastView = lastView{
                    
                    commentView.snp.makeConstraints({ (make) in
                        make.top.equalTo(lastView.snp.bottom)
                        make.left.right.equalTo(lastView)
                    })
                    
                }else{
                    commentView.snp.makeConstraints({ (make) in
                        make.left.right.equalTo(self.contentView)
                        make.top.equalTo(self.contentView)
                    })
                }
                
                lastView = commentView
                
                
            }
            
            if self.contentView.subviews.count > 0 {
                
                if self.contentView.subviews.count == 1 {
                    
                    lastView?.snp.remakeConstraints({ (make) in
                        make.top.equalTo(self.contentView.snp.top)
                        make.left.right.equalTo(self.contentView)
                        make.bottom.equalTo(self.contentView.snp.bottom)
                    })
                    
                }else {
                    let view:BMShopCommentView = self.contentView.subviews[self.contentView.subviews.count-2] as! BMShopCommentView
                    
                    lastView?.snp.remakeConstraints({ (make) in
                        make.top.equalTo(view.snp.bottom)
                        make.left.right.equalTo(self.contentView)
                        make.bottom.equalTo(self.contentView.snp.bottom)
                        
                    })
                }
            }
            
        }
        
    }
    
    

}
