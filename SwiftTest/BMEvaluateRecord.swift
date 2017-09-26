//
//  BMEvaluateRecord.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/9/22.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit
import SwiftyJSON

class BMEvaluateRecord: UITableViewCell {

    @IBOutlet weak var topLineView: UIView!  //最上方细线
    @IBOutlet weak var circleView: UIView! //小圆点视图
    @IBOutlet weak var dotView: UIView!  //小圆点里的小圆点视图
    @IBOutlet weak var bottomView: UIView!  //最下方细线
    @IBOutlet weak var timeLabel: UILabel!  //评论时间
    @IBOutlet weak var contentLabel: UILabel!  //评论内容
    @IBOutlet weak var scrollView: UIScrollView!  //滚动视图
    @IBOutlet weak var gradeView: BMGradeView!  //评分视图
    @IBOutlet weak var scrollContentView: UIView!  //内容视图
    @IBOutlet weak var scrollViewHeight: NSLayoutConstraint!
    @IBOutlet weak var scrollViewTopMargin: NSLayoutConstraint!

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.circleView.layer.cornerRadius = self.circleView.bounds.size.width / 2.0
        self.dotView.layer.cornerRadius = self.dotView.bounds.size.width / 2.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func updateWithRecord(record:JSON){
        
        for imageView in self.scrollContentView.subviews{  //先删除内容视图上的所有子视图
            imageView.removeFromSuperview()
        }
        
        let score:Int = record["score"].intValue
        let remark:String = record["remark"].stringValue
        let addTime:Int = record["addTime"].intValue
        let pictureList:Array<JSON>? = record["pictureList"].array
        
        self.gradeView.setScore(score: score)
        self.contentLabel.text = remark
        self.timeLabel.text = timeFormattingWithStamp(timeStamp: addTime, format: "YYYY-MM-DD")
        
        if let pictureList = pictureList{
            
            
            var lastView:UIImageView? = nil
            for value in pictureList{
                
                let url:String = value["url"].stringValue
                
                let imageView:UIImageView = UIImageView(frame: CGRect.zero)
                imageView.af_setImage(withURL: URL(string: url)!, placeholderImage: UIImage(named:""),  completion: nil)
                self.scrollContentView.addSubview(imageView)
                imageView.snp.makeConstraints({ (make) in
                    make.top.bottom.equalTo(self.scrollContentView)
                    make.height.width.equalTo(self.scrollContentView.snp.height)
                    
                    if let lastView = lastView{
                        make.left.equalTo(lastView.snp.right).offset(5)
                    }else{
                        make.left.equalTo(self.scrollContentView)
                    }
                    
                })
                
                lastView = imageView
            }
            
            
        }else{
            self.scrollViewHeight.constant = 0
            self.scrollViewTopMargin.constant = 0
        }
        
        
    }
}
