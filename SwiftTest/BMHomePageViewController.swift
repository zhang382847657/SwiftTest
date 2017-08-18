//
//  BMHomePageViewController.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/6/22.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit
import LLCycleScrollView
import SwiftyJSON
import SnapKit

class BMHomePageViewController: UIViewController {

    var scrollView: UIScrollView!  //最底层的滚动视图
    var contentView: UIView!    //滚动视图的内容视图  所有内容视图全都被加载此视图上
    var bannerView: LLCycleScrollView!  //轮播图
    var productTypeView: BMProductTypeView!  //商品类目
    var quickOrderView : UIImageView!  //快速下单
    var hotServiceView: BMHotServiceView! //推荐服务
    var webURLs = [String]() //轮播图跳转到webView的路径数组
    var comboCardView:BMComboCardRecommendView! //推荐超值套餐卡
    var storeCardView:BMStoreCardRecommendView! //推荐超值储存卡
    var friendsBargainView:BMFriendsBargainView! //好友砍价
    var nearesStoreView:BMNearesStoreView! //最近门店
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false //这样可以防止scrollview没有置顶
        
        self.loadContentView() //加载内容视图
        self.loadData() //请求网络数据

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)  //隐藏导航栏
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true) //显示导航栏
    }
    
    /**
     *  加载内容视图
     */
    func loadContentView(){
        
        
        /////////最底层的滚动视图/////////
        self.scrollView = UIScrollView(frame: CGRect.zero)
        self.scrollView.autoresizingMask = UIViewAutoresizing.flexibleHeight
        self.view.addSubview(self.scrollView)
        self.scrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        /////////最底层滚动视图的内容视图/////////
        self.contentView = UIView(frame: CGRect.zero)
        self.scrollView.addSubview(self.contentView)
        self.contentView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.scrollView);
            make.width.equalTo(self.scrollView);
            make.height.greaterThanOrEqualTo(0);//此处保证容器View高度的动态变化 大于等于0的高度
        }
        
        
        
        //////////轮播图///////////
        self.bannerView = LLCycleScrollView.llCycleScrollViewWithFrame(CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kScreenWidth*0.56)){ (index) in
            
            let webViewController:BMWebViewController = BMWebViewController(url: self.webURLs[index])
            self.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(webViewController, animated: true)
            self.hidesBottomBarWhenPushed = false
        }
        self.bannerView.imageViewContentMode = .scaleAspectFill
        self.bannerView.pageControlPosition = .center
        self.bannerView.placeHolderImage = UIImage(named: "banner")
        self.bannerView.coverImage = UIImage(named: "banner")
        self.bannerView.customPageControlInActiveTintColor = UIColor.colorWithHexString(hex: BMThemeColor)
        self.bannerView.customPageControlStyle = .snake
        self.bannerView.backgroundColor = UIColor.white
        self.contentView.addSubview(self.bannerView)
        
        

        ///////////商品类目////////////
        self.productTypeView = BMProductTypeView(frame: CGRect.zero)
        self.contentView.addSubview(self.productTypeView)
        self.productTypeView.productClickClosure = {
            (product:JSON) -> Void in
            
            let productID:Int? = product["id"].int
            
            if let productID = productID{
                
                
                self.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(BMProductViewController(productId: productID), animated: true)
                self.hidesBottomBarWhenPushed = false
            }else{
                dPrint(item: "商品ID为空")
            }
            
            
        }
        self.productTypeView.snp.makeConstraints { (make) in
            make.top.equalTo(self.bannerView.snp.bottom).offset(-15)
            make.left.equalTo(self.contentView).offset(15)
            make.right.equalTo(self.contentView).offset(-15)
        }
        
        

        ///////////快速下单/////////
        self.quickOrderView = UIImageView(image: UIImage(named: "kuaisuxiadan"))
        self.quickOrderView.isUserInteractionEnabled = true //开启图片交互
        let quickSingleTap = UITapGestureRecognizer(target: self, action: #selector(quickClick))
    
        self.quickOrderView.addGestureRecognizer(quickSingleTap)
        
        self.contentView.addSubview(self.quickOrderView)
        self.quickOrderView.snp.makeConstraints { (make) -> Void in
        
            make.height.equalTo(self.contentView.snp.width).multipliedBy(0.314)
            make.top.equalTo(self.productTypeView.snp.bottom).offset(10)
            make.left.right.equalTo(self.contentView)
            
        }
        
        ///////////推荐服务////////////
        self.hotServiceView = BMHotServiceView(frame: CGRect.zero)
        self.contentView.addSubview(self.hotServiceView)
        self.hotServiceView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.contentView)
            make.top.equalTo(self.quickOrderView.snp.bottom).offset(10)
        }
        
        //////////超值套餐卡///////
        self.comboCardView = BMComboCardRecommendView(frame: CGRect.zero)
        self.contentView.addSubview(self.comboCardView)
        
        
        comboCardView.snp.makeConstraints { (make) in
            make.top.equalTo(self.hotServiceView.snp.bottom).offset(10)
            make.left.right.equalTo(self.contentView)
        }
        
        //////////超值储值卡///////
        
        self.storeCardView = UIView.loadViewFromNib(nibName: "BMStoreCardRecommendView") as! BMStoreCardRecommendView
        self.storeCardView.storeCardRecommendClickClosure = { //cell点击回调
            (index:Int) -> Void in
            self.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(BMStoreCardBuyViewController(scrollToIndex: index), animated: true)
            self.hidesBottomBarWhenPushed = false
            
        }
        self.contentView.addSubview(self.storeCardView)
        
        
        storeCardView?.snp.makeConstraints { (make) in
            make.top.equalTo(self.comboCardView.snp.bottom).offset(10)
            make.left.right.equalTo(self.contentView)
        }
        
        
        //////////好友砍价///////////
        self.friendsBargainView = BMFriendsBargainView(frame: CGRect.zero)
        self.friendsBargainView.isShow(isShow: false) //默认隐藏好友砍价入口
        self.contentView.addSubview(self.friendsBargainView)
        
        self.friendsBargainView.snp.makeConstraints { (make) in
            make.top.equalTo(self.storeCardView.snp.bottom).offset(10)
            make.left.right.equalTo(self.contentView)
        }
        
        
        //////////最近门店/////////////
        self.nearesStoreView = BMNearesStoreView(frame: CGRect.zero)
        self.nearesStoreView.storeClickClosure = {
            () -> Void in
                self.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(BMStoreListTableViewController(style: .plain), animated: true)
                self.hidesBottomBarWhenPushed = false
            
        }
        self.contentView.addSubview(self.nearesStoreView)
        
        self.nearesStoreView.snp.makeConstraints { (make) in
            make.top.equalTo(self.friendsBargainView.snp.bottom).offset(10)
            make.left.right.equalTo(self.contentView)
            make.bottom.equalTo(self.contentView).offset(-10)
        }
    }
    
    /**
     *  请求网络数据
     */
    func loadData() {
        
        //////////////请求轮播图///////////////////
    
        let bannerURL = "\(BMHOST)/appbanner/queryList?duserCode=\(BMDUSERCODE)"
        let params = ["":""]
        NetworkRequest.sharedInstance.getRequest(urlString: bannerURL , params: params , success: { value in
            
            
            let dataList: JSON = value["dataList"]
            var imagesURLStrings = [String]()
            
            
            for (_,subJson):(String, JSON) in dataList {
                let url:JSON = subJson["bannerUrl"]  //图片路径
                let redirectUrl:JSON = subJson["redirectUrl"]  //跳转到webView的路径
                imagesURLStrings.append(url.rawString()!)
                self.webURLs.append(redirectUrl.rawString()!)
                
            }
            
            self.bannerView.imagePaths = imagesURLStrings //设置轮播图的图片数组
            
        
            
        }) { error in
            
        }
        
        

        //////////////请求商品类目///////////////////
        let productTypeURL = "\(BMHOST)/product/queryProductList?duserCode=\(BMDUSERCODE)&state=1&pageNum=0&pageSize=100"
        NetworkRequest.sharedInstance.getRequest(urlString: productTypeURL , params: params , success: { value in
            
            
            let dataList: JSON = value["dataList"]
            
            if let dataArray = dataList.array {
                
                let array = self.getRandomProductType(arr: dataArray, num: 3)
                dPrint(item: array)
                self.hotServiceView.updateUIWithProduct(products: JSON(array));//更新热门商品视图
                
            }
            
    
            self.productTypeView.updateUIWithProducts(products: dataList) //更新商品类目视图
            
            
        }) { error in
            
            
        }
        
        
        //////////////请求推荐的套餐卡///////////////////
        let comboCardRecommendURL = "\(BMHOST)/c/packagecard/queryList?duserCode=\(BMDUSERCODE)&pageSize=2&pageNum=0&state=1"
        NetworkRequest.sharedInstance.getRequest(urlString: comboCardRecommendURL , params: params , success: { value in
            
            let dataList: JSON = value["dataList"]
            self.comboCardView.updateUIWithComboCards(comboCards: dataList)//更新推荐的超值套餐卡内容
            
        }) { error in
            
            
        }

        
        //////////////请求推荐的储值卡///////////////////
        let storeCardRecommendURL = "\(BMHOST)/cuserPcardKind/queryKindList?duserCode=\(BMDUSERCODE)&pageSize=10000&validState=0&state=1"
        NetworkRequest.sharedInstance.getRequest(urlString: storeCardRecommendURL , params: params , success: { value in
            
            
            let dataList: JSON = value["dataList"]
            
            self.storeCardView.updateUIWithStoreCardRecommend(storeCards:dataList)//更新推荐的超值储值卡内容
            
        }) { error in
            
            
        }
        
        
        //////////////请求好友砍价///////////////////
        let friendsBargainURL = "\(BMHOST)/c/bargain/nowList?duserCode=\(BMDUSERCODE)"
        NetworkRequest.sharedInstance.getRequest(urlString: friendsBargainURL , params: params , success: { value in
            
            
            let dataList: Array = value["dataList"].array!
            
            for (index,_) in dataList.enumerated(){
                let activityEndTime:Int? = value["dataList"][index]["activityEndTime"].int
                if let activityEndTime = activityEndTime{
                    
                    let timeInterval:Int = Int(NSDate.timeIntervalSinceReferenceDate) //当前时间的时间戳
                    if activityEndTime > timeInterval{ //如果当前好友砍价的结束时间大于现在，就代表有活动
                        self.friendsBargainView.isShow(isShow: true) //显示好友砍价入口
                        break
                    }
                }
            }
            
        }) { error in
            
            
        }
        
        
        //////////////请求最近门店///////////////////
        let nearesStoreURL = "\(BMHOST)/custom/queryPUserList?duserCode=\(BMDUSERCODE)&longitude=\(118.7671100000)&latitude=\(31.9755600000)&pageSize=2&pageNum=0"
        NetworkRequest.sharedInstance.getRequest(urlString: nearesStoreURL , params: params , success: { value in

            self.nearesStoreView.updateUIWithNearesStores(nearesStores: value["dataList"])
            
        }) { error in
            
            
        }
        
        
    }
    
    
    /**
     * 快速下单点击事件
    */
    func quickClick(sender:UITapGestureRecognizer){
        
        dPrint(item: "点击了快速下单")
        
        sender.view?.alpha = 0.5
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            sender.view?.alpha = 1.0
        })
        
        
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(BMQuickOrderTableViewController(style: .plain), animated: true)
        self.hidesBottomBarWhenPushed = false
        
        
    }
    
    /**
     * 从商品类目数组里随机挑选几个商品
     */
    func getRandomProductType(arr:Array<Any> , num:Int) -> Array<Any>{
        //新建一个数组,将传入的数组复制过来,用于运算,而不要直接操作传入的数组;
        var temp_array = arr
        
        //取出的数值项,保存在此数组
        var return_array = Array<Any>()
        for _ in 0 ..< num {
            //判断如果数组还有可以取出的元素,以防下标越界
            if temp_array.count > 0 {
                //在数组中产生一个随机索引
                let arrIndex = Int(arc4random_uniform(UInt32(temp_array.count - 1)))
                //将此随机索引的对应的数组元素值复制出来
                return_array.append(temp_array[arrIndex])
                //然后删掉此索引的数组元素,这时候temp_array变为新的数组
                temp_array.remove(at: arrIndex)
            } else {
                //数组中数据项取完后,退出循环,比如数组本来只有10项,但要求取出20项.
                break
            }
        }
        return return_array
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        super.touchesBegan(touches, with: event)
    }
}
