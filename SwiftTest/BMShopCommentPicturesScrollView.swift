//
//  BMShopCommentPicturesScrollView.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/8/4.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit
import SwiftyJSON
import SKPhotoBrowser


class BMShopCommentPicturesScrollView: UIScrollView {
    
    var contentView:UIView!
    var imageViewer = [SKPhoto]() //浏览图片的数组
    var browser:SKPhotoBrowser! //图片浏览器
    var vc:UIViewController? = nil //当前视图所对应的viewcontroller

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadConfig()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadConfig()
    }
    
    
    //加载内容视图
    private func loadConfig(){
        
        self.contentView = UIView(frame: CGRect.zero)
        self.addSubview(self.contentView)
        self.contentView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
            make.height.equalTo(self.snp.height)
            make.width.greaterThanOrEqualTo(0)
        }
    }
    
    func updateWithImages(images:Array<JSON>){
    
        let imageArray:Array<JSON>? = images
        
        if let imageArray = imageArray{
            
            var lastView:UIView? = nil
            
            for i in 0..<imageArray.count{
                
                let url:String? = imageArray[i]["url"].string //评论图片url
                
                ////////////评论图片///////////
                let imageView = UIImageView(frame: CGRect.zero)
                imageView.isUserInteractionEnabled = true
                imageView.layer.masksToBounds = true
                imageView.contentMode = .scaleAspectFill
                imageView.tag = 50 + i
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureAction)) //给图片添加点击事件
                tapGesture.numberOfTapsRequired = 1
                imageView.addGestureRecognizer(tapGesture)
                self.contentView.addSubview(imageView)
                
                if let url = url{
                    imageView.af_setImage(withURL: URL(string: "\(url)?x-oss-process=image/resize,p_50")!, placeholderImage: UIImage(named: "pic_load")!)
                    
                    ////图片浏览器数组里塞值
                    let photo = SKPhoto.photoWithImageURL(url)
                    photo.shouldCachePhotoURLImage = true
                    imageViewer.append(photo)
                    
                }else{
                    imageView.image = UIImage(named: "pic_error")
                }
                
                if let lastView = lastView{
                    imageView.snp.makeConstraints({ (make) in
                        make.top.bottom.equalTo(lastView)
                        make.left.equalTo(lastView.snp.right).offset(10)
                        make.width.equalTo(lastView.snp.width)
                    })
                    
                }else{
                    imageView.snp.makeConstraints({ (make) in
                        make.top.equalTo(self.contentView.snp.top)
                        make.bottom.equalTo(self.contentView.snp.bottom)
                        make.left.equalTo(self.contentView.snp.left)
                        make.width.equalTo(self.snp.height)
                    })
                }
                
                lastView = imageView
            }
            
            if self.contentView.subviews.count > 0 {
                
                if self.contentView.subviews.count == 1 {
                    
                    lastView!.snp.remakeConstraints({ (make) in
                        make.top.equalTo(self.contentView.snp.top)
                        make.bottom.equalTo(self.contentView.snp.bottom)
                        make.left.equalTo(self.contentView.snp.left)
                        make.right.equalTo(self.contentView.snp.right)
                        make.width.equalTo(self.snp.height)
                    })
                    
                }else {
                    let view:UIImageView = self.contentView.subviews[self.contentView.subviews.count-2] as! UIImageView
                    
                    lastView!.snp.remakeConstraints({ (make) in
                        make.top.equalTo(view.snp.top)
                        make.bottom.equalTo(view.snp.bottom)
                        make.left.equalTo(view.snp.right).offset(10)
                        make.right.equalTo(self.contentView.snp.right)
                        make.width.equalTo(self.snp.height)
                    })
                }
            }
            
        }
        
        self.browser = SKPhotoBrowser(photos: self.imageViewer) //给图片浏览器赋值图片
    }
    
    
    func tapGestureAction(sender:UITapGestureRecognizer){
        
        let imageView = sender.view!
        
        
        if let vc = self.vc{
            self.browser.initializePageIndex(imageView.tag-50) //设置浏览器默认显示的位置
            vc.present(self.browser, animated: true, completion: nil)
        }else{
            self.vc = imageView.getViewController() //得到viewcontroller
            self.browser.initializePageIndex(imageView.tag-50) //设置浏览器默认显示的位置
            self.vc!.present(self.browser, animated: true, completion: nil)
        }
        
        
        
   
    }

}
