//
//  BMVipCardDetailViewController.swift
//  SwiftTest
//  会员卡详情
//  Created by 张琳 on 2017/8/21.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit
import SwiftyJSON

class BMVipCardDetailViewController: UIViewController {
    
    var scrollView:UIScrollView!
    var contentView:UIView!
    var collectionView:BMVipCardCollectionView! //所有会员卡视图
    var consumeView:BMVipCardConsumeView! //会员卡消费视图
    var equityView:BMVipCardEquityView! //会员权益视图
    var elaborate:BMCardElaborate! //详细描述
    
    var card:JSON! //当前用户的会员卡对象
    var cardList:Array<JSON>? = nil //所有会员卡
    var payCash:Float! //总消费金额
    var storeCash:Float! //总储值卡金额

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "会员卡"
        
        self.loadUI()
        self.loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: 页面初始化
    /**
     *  页面初始化
     *  @param cardNo  卡Id
     *  @param cardType 卡包类型  1套餐卡  2储值卡
     *  @param expireDescription  有效期
     *  @param cardName 卡名字
     */
    init(card:JSON) {
        
        self.card = card
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /**
     *  加载界面
     */
    private func loadUI(){
        self.view.backgroundColor = UIColor.colorWithHexString(hex: BMBacgroundColor)
        
        
        //////////滚动视图//////////////
        self.scrollView = UIScrollView(frame: CGRect.zero)
        self.view.addSubview(self.scrollView)
        self.scrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        
        ///////////内容视图////////////
        self.contentView = UIView(frame: CGRect.zero)
        self.scrollView.addSubview(self.contentView)
        self.contentView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.scrollView)
            make.width.equalTo(self.scrollView.snp.width)
            make.height.greaterThanOrEqualTo(0)
        }
        
        
        ///////////所有会员卡视图/////////
        self.collectionView = BMVipCardCollectionView()
        self.collectionView.vipCardScrollEndClosure = {  //会员卡滚动的回调
            (indexPath:IndexPath) -> Void in
            
            self.updateContentViews(index: indexPath.item) //更新相关视图
        }

        self.contentView.addSubview(self.collectionView)
        
        self.collectionView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.contentView)
            make.top.equalTo(self.contentView).offset(30)
            make.height.equalTo(kScreenWidth*0.48)
            
        }
        
        ///////////会员卡消费视图////////////
        self.consumeView = UIView.loadViewFromNib(nibName: "BMVipCardConsumeView") as! BMVipCardConsumeView
        self.contentView.addSubview(self.consumeView)
        self.consumeView.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView).offset(15)
            make.right.equalTo(self.contentView).offset(-15)
            make.top.equalTo(self.collectionView.snp.bottom).offset(25)
            
        }
        
        
        ////////////会员权益视图///////////
        self.equityView = BMVipCardEquityView(frame: CGRect.zero)
        self.contentView.addSubview(self.equityView)
        self.equityView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.consumeView)
            make.top.equalTo(self.consumeView.snp.bottom).offset(10)
        }
        
        
        ///////////详细描述//////////////
        self.elaborate = UIView.loadViewFromNib(nibName: "BMCardElaborate") as! BMCardElaborate
        self.contentView.addSubview(self.elaborate)
        self.elaborate.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.contentView)
            make.top.equalTo(self.equityView.snp.bottom).offset(20)
            make.bottom.equalTo(self.contentView).offset(-30)
        }
        
        
    }
    
    
    /**
     *  加载数据
     */
    private func loadData(){
        
        /////////查询当前用户消费情况/////////
        let consumptionUrl = "\(BMHOST)/cuserCard/queryCuserConsumption"
        let params = ["":""]
        NetworkRequest.sharedInstance.postRequest(urlString: consumptionUrl, params: params, isLogin: true, success: { (value) in
            
            self.payCash = value["payCash"].floatValue
            self.storeCash = value["storeCash"].floatValue
            
            
            
            /////////查询会员卡列表////////////
            let vipCardsUrl = "\(BMHOST)/c/cuserCard/queryTypeList"
            NetworkRequest.sharedInstance.postRequest(urlString: vipCardsUrl, params: params, isLogin: true, success: { (value2) in
                
                self.cardList = value2.arrayValue
                self.collectionView.updateWithVIPCards(cards: value2)
                
                var currentIndex:Int = 0  //当前用户的会员卡所在下标
                
                for value in self.cardList!{
                    
                    let id:String = value["id"].stringValue
                    
                    if id == self.card["typeId"].stringValue {
                        
                        currentIndex = self.cardList!.index(of: value)!
                        break
                    }
                }
                
                self.updateContentViews(index: currentIndex)
                
                
            }) { (error) in
                
                
            }
            
           
            
        }) { (error) in
            
            
        }
        
       
        
        
       
        
    }
    
    
    /**
     *  更新有关内容视图  顶部会员卡当前要显示哪一个、中间消费视图、底部详细描述
     * @params index 当前会员卡所在所有会员卡中的下标
     */
    private func updateContentViews(index:Int){
        
        
        ////让顶部会员卡滚动到第几个////
        self.collectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .centeredHorizontally, animated: false)
        
        
        /////更新消费信息//////
        self.consumeView.updateWithCard(card: self.cardList![index], myCard: self.card, payCash: self.payCash, storeCash: self.storeCash)
        
        /////详细信息/////
        let currentDetail:String? = self.cardList![index]["description"].string
        
        if let currentDetail = currentDetail{
            self.elaborate.contentLabel.text = currentDetail
        }else{
            self.elaborate.contentLabel.text = "暂无信息"
        }
        
        /////更新会员卡权益//////
        self.getCardEquity(index: index) { (value) -> (Void) in
            
            let priceOffList:Array<JSON>? = value["priceOffList"].array //打折商品
            let cardCouponBOList:Array<JSON>? = value["cardCouponBOList"].array  //优惠商品
            
            self.equityView.updateWithPriceOffList(priceOffList: priceOffList, cardCouponBOList: cardCouponBOList)
//            if let priceOffList = priceOffList, priceOffList.count > 0{
//                
//            }else{
//                
//            }
//            
//            if let cardCouponBOList = cardCouponBOList, cardCouponBOList.count > 0{
//                
//            }else{
//                
//            }
            
            
            
        }
        
        
        
    }
    
    
    /**
     * 查询会员卡权益
     * @params index 当前会员卡所在所有会员卡中的下标
     * @params callBack 回调函数  返回会员卡权益信息
     */
    private func getCardEquity(index:Int, callBack:((_ value:JSON)->(Void))?){
       
        
        let vipCardsUrl = "\(BMHOST)/cuserCard/queryType"
        let params = ["typeId":self.cardList![index]["id"].stringValue]
        NetworkRequest.sharedInstance.postRequest(urlString: vipCardsUrl, params: params, isLogin: true, success: { (result) in
            
            if let callBack = callBack{
                callBack(result)
            }
            
        }) { (error) in
            
            
        }
    }
    

}
