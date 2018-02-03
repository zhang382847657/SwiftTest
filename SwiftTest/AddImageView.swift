//
//  AddImageView.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/9/19.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit
import Gallery

class AddImageView: UIView, GalleryControllerDelegate {
    
    //FIXME: 这个第三方升级到了swift4.0，里面逻辑变动，请重新尝试
    func galleryController(_ controller: GalleryController, didSelectImages images: [Image]) {

    }
    
    func galleryController(_ controller: GalleryController, requestLightbox images: [Image]) {
    
    }
    
    
    
    
    var addImageBtn:UIButton! //添加图片的按钮
    var cellWidth:CGFloat! //按钮宽度
    
    var imageArray:Array<String>? = nil //显示的图片数组
    
    var maxCount:Int = 20  //允许添加图片的上限
    
    var rowCount:Int = 4 { //一行显示几个图标
        didSet{
            
        }
    }
    
    var marginOffset:CGFloat = 10 { //外边距
        didSet{
            
        }
    }
    
    var paddingOffset:CGFloat = 5 { //图片之间的边距
        didSet{
            
        }
    }
    
    //MARK: 初始化视图
    /**
     *  param: maxCount 允许添加图片的上限
     *  param: rowCount 一行显示几个图标
     *  param: marginOffset 外边距
     *  param: paddingOffset 图片之间的边距
     *  param: imageArray 显示的图片数组
     *
     */
    init(maxCount:Int?, rowCount:Int?, marginOffset:CGFloat?, paddingOffset:CGFloat?, imageArray:Array<String>?) {
        
        super.init(frame: CGRect.zero)
        
        if let maxCount = maxCount{
            self.maxCount = maxCount
        }
        if let rowCount = rowCount{
            self.rowCount = rowCount
        }
        if let marginOffset = marginOffset{
            self.marginOffset = marginOffset
        }
        if let paddingOffset = paddingOffset{
            self.paddingOffset = paddingOffset
        }
        self.imageArray = imageArray
        
        self.loadConfig()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadConfig()
    }
    
    
    //MARK: 加载基本配置
    private func loadConfig(){
        
        self.backgroundColor = UIColor.white //设置背景色
        self.calculateCellWidth() //计算每个图片的宽度
        self.updateUI() //更新布局
    }
    
    //MARK: 计算每个图片的宽度
    private func calculateCellWidth(){
        self.cellWidth = (kScreenWidth - 10 * 2 - self.marginOffset * 2 - CGFloat((self.rowCount - 1)) * self.paddingOffset) / CGFloat(self.rowCount) //计算每一个图片方块的宽度
    }
    
    //MARK: 更新布局
    private func updateUI(){
        
        for view in self.subviews{ //先删除所有的子视图
            view.removeFromSuperview()
        }
        
        //////////////添加图片按钮/////////////
        self.addImageBtn = UIButton(type: .custom)
        self.addImageBtn.frame = CGRect.zero
        self.addImageBtn.setImage(UIImage(named:"tianjiatupian"), for: .normal)
        self.addImageBtn.addTarget(self, action: #selector(addImageClick), for: .touchUpInside)
        self.addSubview(self.addImageBtn)
        
        
        if let imageArray = self.imageArray, imageArray.count > 0 {
            
            var lastBtn:UIButton? = nil
            for i in 0..<imageArray.count {
                let imageBtn:UIButton = UIButton(type: .custom)
                imageBtn.backgroundColor = UIColor.gray
                let image = self.base64StringToUIImage(base64String: imageArray[i])
                imageBtn.setBackgroundImage(image, for: .normal)
                imageBtn.frame = CGRect.zero
                self.addSubview(imageBtn)
                
                imageBtn.snp.makeConstraints({ (make) in
                
                    make.height.width.equalTo(self.cellWidth)
                    
                    if let lastBtn = lastBtn{
                        
                        if i % self.rowCount == 0{
                            make.top.equalTo(lastBtn.snp.bottom).offset(self.paddingOffset)
                            make.left.equalTo(self).offset(self.marginOffset)
                            
                        }else{
                            make.top.equalTo(lastBtn.snp.top)
                            make.left.equalTo(lastBtn.snp.right).offset(self.paddingOffset)
                        }
                        
                    }else{
                        make.top.left.equalTo(self).offset(self.marginOffset)
                    }
                    
                    
                    if imageArray.count >= self.maxCount{ //如果图片达到上限，则直接不显示添加图片的按钮
                        make.bottom.equalTo(self).offset(-self.marginOffset)
                    }
                    
                })
                
                lastBtn = imageBtn
            }
            
            if imageArray.count < self.maxCount {
                self.addImageBtn.snp.makeConstraints({ (make) in
                    
                    make.width.height.equalTo(self.cellWidth)
                    
                    if imageArray.count % self.rowCount == 0 {
                        make.top.equalTo(lastBtn!.snp.bottom).offset(self.paddingOffset)
                        make.left.equalTo(self).offset(self.marginOffset)
                    }else{
                        make.top.equalTo(lastBtn!.snp.top)
                        make.left.equalTo(lastBtn!.snp.right).offset(self.paddingOffset)
                    }
                    
                    make.bottom.equalTo(self).offset(-self.marginOffset)
                })
            }
            
        }else{
            self.addImageBtn.snp.makeConstraints { (make) in
                make.top.equalTo(self).offset(self.marginOffset)
                make.left.equalTo(self).offset(self.marginOffset)
                make.bottom.equalTo(self).offset(-self.marginOffset)
                make.width.height.equalTo(self.cellWidth)
            }
        }
    }
    
    
    //MARK: 添加图片按钮点击事件
    func addImageClick(sender:UIButton){
        
        let gallery = GalleryController() //调用相机选择器
        gallery.delegate = self
        let vc = self.getViewController()
        vc?.present(gallery, animated: true, completion: nil)
        
    }
    
    //MARK: GalleryController-Delegate
    
    func galleryController(_ controller: GalleryController, didSelectImages images: [UIImage]){
        
        if self.imageArray == nil{
            self.imageArray = Array()
        }
        
        for image in images{
            
            let str = self.imageToBase64String(image:image , headerSign: false)
            if let str = str{
                self.imageArray!.append(str)
            }
            
        }
        
        self.updateUI() //更新布局
        
        controller.dismiss(animated: true, completion: nil)
        
    }
    func galleryController(_ controller: GalleryController, didSelectVideo video: Video){
        
        dPrint(item: video)
        
    }
    func galleryController(_ controller: GalleryController, requestLightbox images: [UIImage]){
        
        dPrint(item: images)
        
    }
    func galleryControllerDidCancel(_ controller: GalleryController){
        controller.dismiss(animated: true, completion: nil)
    }

    ///传入图片image回传对应的base64字符串,默认不带有data标识,
    func imageToBase64String(image:UIImage,headerSign:Bool = false)->String?{
        
        ///根据图片得到对应的二进制编码
        guard let imageData = UIImagePNGRepresentation(image) else {
            return nil
        }
        ///根据二进制编码得到对应的base64字符串
        var base64String = imageData.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue:0))
        ///判断是否带有头部base64标识信息
        if headerSign {
            ///根据格式拼接数据头 添加header信息，扩展名信息
            base64String = "data:image/png;base64," + base64String
        }
        return base64String
    }
    
    ///传入base64的字符串，可以是没有经过修改的转换成的以data开头的，也可以是base64的内容字符串，然后转换成UIImage
    func base64StringToUIImage(base64String:String)->UIImage? {
        var str = base64String
        
        // 1、判断用户传过来的base64的字符串是否是以data开口的，如果是以data开头的，那么就获取字符串中的base代码，然后在转换，如果不是以data开头的，那么就直接转换
        if str.hasPrefix("data:image") {
            guard let newBase64String = str.components(separatedBy: ",").last else {
                return nil
            }
            str = newBase64String
        }
        // 2、将处理好的base64String代码转换成NSData
        guard let imgNSData = NSData(base64Encoded: str, options: NSData.Base64DecodingOptions()) else {
            return nil
        }
        // 3、将NSData的图片，转换成UIImage
        guard let codeImage = UIImage(data: imgNSData as Data) else {
            return nil
        }
        return codeImage
    }

}
