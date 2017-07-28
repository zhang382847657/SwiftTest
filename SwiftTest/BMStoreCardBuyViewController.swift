//
//  BMStoreCardBuyViewController.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/7/22.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit
import SwiftyJSON

class BMStoreCardBuyViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    @IBOutlet weak var topImageView: UIImageView! //顶部图片
    @IBOutlet weak var buyBtn: UIButton! //购买储值卡按钮
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var layout:CardSwitchLayout! //collectionView布局
    private var dataList:JSON! //数据源
    private var scrollToIndex:Int! //滚动到第几条
    

    var transition:CATransition!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /////////初始化卡片布局//////////
        layout = CardSwitchLayout()
        layout.itemSize = CGSize(width: kScreenWidth*0.84, height: kScreenWidth*0.744)
        
        
        /////////初始化collectionView////////
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.register(UINib(nibName: "BMStoreCardBuyCell", bundle: nil), forCellWithReuseIdentifier: "BMStoreCardBuyCell")
        
        
        ///////// 设置旋转动画//////////
        self.transition = CATransition()
        self.transition.type = "oglFlip"  // 动画的类型
        self.transition.subtype = kCATransitionFromRight  // 动画的方向
        self.transition.duration = 0.7  // 动画的时间
        
        
        self.loadData() //加载数据
    

    }
    
    /*自定义初始化  自带一个参数
     *@parma scrollToIndex 滚动到第几个item
     */
    init(scrollToIndex:Int) {
        
        super.init(nibName: "BMStoreCardBuyViewController", bundle: nil)
        self.scrollToIndex = scrollToIndex
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
     *  请求网络数据
     */
    func loadData() {
        
        let params = ["":""]
        let url = "\(BMHOST)/cuserPcardKind/queryKindList?duserCode=\(BMDUSERCODE)&pageSize=10000&validState=0&state=1"
        NetworkRequest.sharedInstance.getRequest(urlString: url , params: params , success: { value in
            
            self.dataList = value["dataList"] //绑定数据源
            self.collectionView.reloadData() //刷新数据源
            self.collectionView.scrollToItem(at: IndexPath(item: self.scrollToIndex, section: 0), at: .centeredHorizontally, animated: false) //滚动到第几个位置
            
            
        }) { error in
            
            
        }
       
    }



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let dataList = self.dataList{
            return (dataList.array?.count)!
        }else{
            return 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BMStoreCardBuyCell", for: indexPath) as! BMStoreCardBuyCell
        cell.contentView.backgroundColor = UIColor.white
        cell.backgroundColor = UIColor.clear
        cell.uploadUIWithStoreCard(storeCard: (dataList.array?[indexPath.item])!)
        
        
        cell.giftEquityClickClosure = { //赠送权益点击回调
            () -> Void in
            
            
            for view in cell.contentView.subviews {  //循环遍历把卡片背面的视图删除
                if view is BMGiftEquityView {
                    view.removeFromSuperview()
                    break
                }
            }
            
            let giftEquityView:BMGiftEquityView! = UIView.loadViewFromNib(nibName: "BMGiftEquityView") as! BMGiftEquityView //初始化卡片背面的视图
            giftEquityView.updatUIWithCoupons(coupons: (self.dataList.array?[indexPath.item]["cardCouponBoList"])!)
            
            
            self.transition.subtype = kCATransitionFromRight //设置动画旋转方向
            cell.layer.add(self.transition, forKey: nil) //设置旋转动画
            cell.contentView.addSubview(giftEquityView) //把卡片背面视图添加到cell上
            
            giftEquityView.giftEquityBackClickClosure = {  //赠送权益返回按钮点击事件
                ()->Void in
                
                for view in cell.contentView.subviews {  //循环遍历把卡片背面视图删除掉
                    if view == giftEquityView{
                        
                        self.transition.subtype = kCATransitionFromLeft  //设置动画旋转方向
                        cell.layer.removeAllAnimations() //移动cell.layer上的所有动画
                        cell.layer.add(self.transition, forKey: nil) //再次添加旋转动画
                        view.removeFromSuperview() //把卡片背面视图移除掉
                        break
                    }
                }
                
                
            }
        }

        
        return cell
    }
    
    
    //返回点击事件
    @IBAction func backClick(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //购买点击事件
    @IBAction func buyClick(_ sender: UIButton) {
    }

    

}

