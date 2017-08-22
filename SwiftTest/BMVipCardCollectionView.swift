//
//  BMVipCardCollectionView.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/8/21.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit
import SwiftyJSON


//会员卡滚动结束的闭包  返回当前滚动的下标位置
typealias VipCardScrollEndClosure = (_ indexPath:IndexPath) -> Void

class BMVipCardCollectionView: UICollectionView,UICollectionViewDelegate,UICollectionViewDataSource {
    
    var dataList:Array<JSON>? = nil //数据源
    
    var vipCardScrollEndClosure: VipCardScrollEndClosure? //会员卡滚动结束的的闭包块
    
    /**
     *  页面初始化
     */
    
    init() {
        
        /////////初始化卡片布局//////////
        let cardLayout = CardSwitchLayout()
        cardLayout.itemSize = CGSize(width: kScreenWidth*0.84, height: kScreenWidth*0.48)
        
        super.init(frame: CGRect.zero, collectionViewLayout: cardLayout)
        
        self.backgroundColor = UIColor.clear
        self.dataSource = self
        self.delegate = self
        self.register(UINib(nibName: "BMVipCardCell", bundle: nil), forCellWithReuseIdentifier: "BMVipCardCell")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     *  更新数据源
     */
    func updateWithVIPCards(cards:JSON){
        self.dataList = cards.array
        self.reloadData()
    }
    
    
    // MARK: UICollectionView-DataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let dataList = self.dataList{
            return dataList.count
        }else{
            return 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:BMVipCardCell = collectionView.dequeueReusableCell(withReuseIdentifier: "BMVipCardCell", for: indexPath) as! BMVipCardCell
        cell.updateWithVip(vip: self.dataList![indexPath.item])
        
        return cell
    }
    
    
    // MARK: UICollectionView-Delegate
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        
        let pointInView = self.superview!.convert(self.center, to: self)
        let indexPath:IndexPath = self.indexPathForItem(at: pointInView)!
        
        if let vipCardScrollEndClosure = self.vipCardScrollEndClosure{
            vipCardScrollEndClosure(indexPath)  //把当前滚动到的某一个会员卡下标回调过去
        }
        
    }

}
