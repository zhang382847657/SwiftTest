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
    
    var card:JSON!

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
        
        
        self.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: false) //滚动到第几个位置
        
    }
    

}
