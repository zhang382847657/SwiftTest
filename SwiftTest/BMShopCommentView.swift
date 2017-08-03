//
//  BMShopCommentView.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/8/3.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit
import SwiftyJSON

class BMShopCommentView: UIView {

    @IBOutlet weak var imageView: UIImageView!  //用户头像
    @IBOutlet weak var nameLabel: UILabel!  //用户昵称
    @IBOutlet weak var timeLabel: UILabel!  //评论时间
    @IBOutlet weak var gradeView: BMGradeView!  //评价等级
    @IBOutlet weak var contentLabel: UILabel!  //评论内容

    
    
    
    override func awakeFromNib() {
        
        self.imageView.layer.masksToBounds = true
        self.imageView.layer.cornerRadius = self.imageView.bounds.size.height/2.0
        self.gradeView.isEdit(edit: false)
        
//        self.gradeView.gradeClickClosure = { //点击星星的回调
//            (score:Int) -> Void in
//            dPrint(item: score) //得到评分
//        }
       
    }
    
    override func layoutSubviews() {
        
        self.addBorderLayer(color: UIColor.colorWithHexString(hex: BMBorderColor), size: BMBorderSize, boderType: BorderType.bottom)
    }
    
    func updateWithComment(comment:JSON){
        
        let cuserPortraitUrl:String? = comment["cuserPortraitUrl"].string
        let cuserName:String? = comment["cuserName"].string
        let addTime:Int? = comment["addTime"].int
        let score:Int? = comment["score"].int
        let remark:String? = comment["remark"].string
        
        
        if let cuserPortraitUrl = cuserPortraitUrl , cuserPortraitUrl != ""{
            
            self.imageView.af_setImage(withURL: URL(string: cuserPortraitUrl)!, placeholderImage: UIImage(named: "pic_load")!)
            
        }else{
            self.imageView.image = UIImage(named: "user_default")
        }
        
        if let cuserName = cuserName{
            self.nameLabel.text = cuserName
        }else{
            self.nameLabel.text = "暂无名字"
        }
        
        if let addTime = addTime{
            
            self.timeLabel.text = timeFormattingWithStamp(timeStamp: addTime, format: "YYYY-MM-DD")
        }else{
            self.timeLabel.text = "暂无时间"
        }
        
        if let score = score{
            self.gradeView.setScore(score: score)
        }else{
            self.gradeView.setScore(score: 0)
        }
        
        if let remark = remark{
            self.contentLabel.text = remark
        }else{
            self.contentLabel.text = "暂无评论"
        }
        
    
    }

}
