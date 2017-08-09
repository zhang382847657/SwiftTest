//
//  BMAuntDetailViewController.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/8/4.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit
import SwiftyJSON

class BMAuntDetailViewController: UIViewController {
    
    var scrollView:UIScrollView!
    var contentView:UIView!
    
    var headerView:BMAuntDetailHeaderView!
    var servicesTypeView:BMAuntServicesTypeScrollView!
    var basicView:BMAuntBasicView!
    var picturesScrollView:BMAuntPicturesScrollView!
    var cerListView:BMAuntCerListView? = nil
    var aunt:JSON? = nil
    var auntId:String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "阿姨详情"
        self.view.backgroundColor = UIColor.colorWithHexString(hex: BMBacgroundColor)

        self.loadUI()
        self.loadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
     *  页面初始化
     *  @param auntId  阿姨ID
     */
    init(auntId:String) {
        self.auntId = auntId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        self.cerListView?.removeFromSuperview()
    }
    
    
    //加载内容视图
    func loadUI(){
        self.scrollView = UIScrollView(frame: CGRect.zero)
        self.view.addSubview(self.scrollView)
        self.scrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        self.contentView = UIView(frame: CGRect.zero)
        self.scrollView.addSubview(self.contentView)
        self.contentView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.scrollView)
            make.width.equalTo(self.scrollView.snp.width)
            make.height.greaterThanOrEqualTo(0)
        }
        
        
        //////////阿姨头部视图//////////////
        self.headerView = UIView.loadViewFromNib(nibName: "BMAuntDetailHeaderView") as! BMAuntDetailHeaderView
        self.headerView.auntCerClickClosureType = {  //返回按钮的回调
            () -> Void in
            
            if let cerListView = self.cerListView{
                cerListView.show()
                
            }else{
                if let aunt = self.aunt{
                    self.cerListView = BMAuntCerListView(cerList: aunt["auntCertList"])
                    UIApplication.shared.keyWindow?.addSubview(self.cerListView!)
                    self.cerListView?.snp.makeConstraints({ (make) in
                        make.edges.equalTo(UIApplication.shared.keyWindow!)
                    })
                    
                    //延时1秒执行
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
                        self.cerListView?.show()
                    }
                }
            }
            
        }
        self.contentView.addSubview(headerView)
        self.headerView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self.contentView)
            make.height.equalTo(210)
        }
        
        
        //////////阿姨服务类型///////////////
        self.servicesTypeView = BMAuntServicesTypeScrollView(frame: CGRect.zero)
        self.contentView.addSubview(self.servicesTypeView)
        self.servicesTypeView.snp.makeConstraints { (make) in
            make.top.equalTo(self.headerView.snp.bottom).offset(-10)
            make.left.equalTo(self.contentView.snp.left).offset(10)
            make.right.equalTo(self.contentView.snp.right).offset(-10)
            make.height.equalTo(100)
        }
        
        
        ///////////阿姨基本信息//////////////
        self.basicView = BMAuntBasicView(frame: CGRect.zero)
        self.contentView.addSubview(self.basicView)
        self.basicView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.servicesTypeView)
            make.top.equalTo(self.servicesTypeView.snp.bottom).offset(10)
            //make.height.equalTo(200)
        }
        
        
        ////////////阿姨图片////////////////
        self.picturesScrollView = BMAuntPicturesScrollView(frame: CGRect.zero)
        self.contentView.addSubview(self.picturesScrollView)
        self.picturesScrollView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.servicesTypeView)
            make.top.equalTo(self.basicView.snp.bottom).offset(10)
            make.height.equalTo(220)
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-30)
        }
        
        
    }
    
    
    //请求数据
    func loadData(){
        
        //////////////请求轮播图///////////////////
        
        let bannerURL = "\(BMHOST)/c/aunt/queryAuntItem?auntId=\(self.auntId!)"
        let params = ["":""]
        
        NetworkRequest.sharedInstance.postRequest(urlString: bannerURL, params: params, isLogin: true, success: { (value) in
            
            self.aunt = value
            self.headerView.updateWithAunt(aunt: value)
            self.servicesTypeView.updateWithServiceType(aunt: value)
            self.compositeBasics(aunt: value)
            self.picturesScrollView.updateWithImages(images: value["imgUrls"].array)

        }) { (error) in
            
            
        }
        
    }
    
    //阿姨基本信息
    private func compositeBasics(aunt:JSON){
        
        var basicsArray:Array<Dictionary<String,String>> = []
        
        let nativePlace:String? = aunt["nativePlace"].string   //籍贯
        let province:String? = aunt["province"].string  //省
        let city:String? = aunt["city"].string  //城市
        let district:String? = aunt["district"].string  //区域
        let address:String? = aunt["address"].string  //地址
        let language:String? = aunt["language"].string  //语言
        let cuisine:String? = aunt["cuisine"].string //菜系
        let education:Int? = aunt["education"].int //学历
        
        
        if let nativePlace = nativePlace{
            basicsArray.append(["text":"籍贯：","value":nativePlace])
        }
        
        var finalAddress:String = ""
        if let province = province , province.trimmingCharacters(in: .whitespaces) != ""{
            finalAddress = finalAddress + province
        }
        
        if let city = city , city.trimmingCharacters(in: .whitespaces) != ""{
            finalAddress = finalAddress + city
        }
        
        if let district = district , district.trimmingCharacters(in: .whitespaces) != ""{
            finalAddress = finalAddress + district
        }
        
        if let address = address , address.trimmingCharacters(in: .whitespaces) != ""{
            finalAddress = finalAddress + address
        }
        
        if finalAddress != "" {
            basicsArray.append(["text":"现居：","value":finalAddress])
        }
        
        if let language = language , language != "" {
        
            let finalLanguage:String = language.characters.split(separator: ",").map(String.init).map({ (value) -> String in
                return Config.language(id: Int(value)!)
            }).joined(separator: "、")
            
            basicsArray.append(["text":"语言：","value":finalLanguage])
        }
        
        if let cuisine = cuisine, cuisine != "" {
            
            let finalCuisine:String = cuisine.characters.split(separator: ",").map(String.init).map({ (value) -> String in
                return Config.cuisine(id: Int(value)!)
            }).joined(separator: "、")
            
            basicsArray.append(["text":"菜系：","value":finalCuisine])
        }
        
        if let education = education {
            basicsArray.append(["text":"学历","value":Config.education(id: education)])
        }
        
        self.basicView.updateWithBasics(basics: basicsArray)
        
        
        
    }
    


}
