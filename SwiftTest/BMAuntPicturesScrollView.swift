//
//  BMAuntPicturesScrollView.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/8/5.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit
import SwiftyJSON
import SKPhotoBrowser

class BMAuntPicturesScrollView: UIScrollView {

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
        
        self.backgroundColor = UIColor.white
        self.contentView = UIView(frame: CGRect.zero)
        self.addSubview(self.contentView)
        self.contentView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
            make.height.equalTo(self.snp.height)
            make.width.greaterThanOrEqualTo(0)
        }
        
        
    }
    
    func updateWithImages(images:Array<JSON>?){
        
        let imageArray:Array<JSON>? = images
        
        if let imageArray = imageArray{
            
            for i in 0..<imageArray.count{
                
                let url:String? = imageArray[i]["thumbnailUrl"].string //阿姨图片url
                let enclosureType:Int? = imageArray[i]["enclosureType"].int //阿姨图片类型
                
                ////////////评论图片///////////
                let imageView = UIImageView(frame: CGRect.zero)
                imageView.layer.masksToBounds = true
                imageView.isUserInteractionEnabled = true
                imageView.contentMode = .scaleAspectFill
                imageView.tag = 50 + i
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureAction)) //给图片添加点击事件
                tapGesture.numberOfTapsRequired = 1
                imageView.addGestureRecognizer(tapGesture)
                self.contentView.addSubview(imageView)
                
                
                if let url = url{
                    
                    if let enclosureType = enclosureType{  //如果照片类型存在
                        
                        if enclosureType == 1 {  //如果是视频类型
                            
                            imageView.image = UIImage(named: "video")
                            imageView.backgroundColor = UIColor.gray
                            
                        }else{  //如果是其他类型
                            
                            imageView.af_setImage(withURL: URL(string: "\(url)?x-oss-process=image/resize,p_50")!, placeholderImage: UIImage(named: "pic_load")!)
                            
                            ////图片浏览器数组里塞值
                            let photo = SKPhoto.photoWithImageURL(url)
                            photo.shouldCachePhotoURLImage = true
                            imageViewer.append(photo)
                        }
                        
                    }else{  //如果照片类型不存在  默认都是图片
                        imageView.af_setImage(withURL: URL(string: "\(url)?x-oss-process=image/resize,p_50")!, placeholderImage: UIImage(named: "pic_load")!)
                        
                        ////图片浏览器数组里塞值
                        let photo = SKPhoto.photoWithImageURL(url)
                        photo.shouldCachePhotoURLImage = true
                        imageViewer.append(photo)
                    }
                    
                }else{
                    imageView.image = nil
                }
                
                imageView.snp.makeConstraints({ (make) in
                    
                    make.top.equalTo(self.contentView.snp.top).offset(10)
                    make.bottom.equalTo(self.contentView.snp.bottom).offset(-10)
                    make.width.equalTo(150)
                    if i > 0, let lastView = self.contentView.subviews[i - 1] as? UIImageView {
                        make.left.equalTo(lastView.snp.right).offset(10)
                    } else {
                        make.left.equalTo(self.contentView.snp.left).offset(10)
                    }
                    
                    if i == imageArray.count - 1 {
                        self.contentView.snp.makeConstraints({ (make) in
                            make.right.equalTo(imageView.snp.right).offset(10)
                        })
                    }
                    
                })
            
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
            vc!.present(self.browser, animated: true, completion: nil)
        }
    }


}
