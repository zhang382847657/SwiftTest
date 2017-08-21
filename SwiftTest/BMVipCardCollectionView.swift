//
//  BMVipCardCollectionView.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/8/21.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit
import SwiftyJSON

class BMVipCardCollectionView: UICollectionView,UICollectionViewDelegate,UICollectionViewDataSource {
    
    var dataList:Array<JSON>? = nil
    
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
    
    func updateWithVIPCards(cards:JSON){
        self.dataList = cards.array
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let dataList = self.dataList{
            return dataList.count
        }else{
            return 10
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:BMVipCardCell = collectionView.dequeueReusableCell(withReuseIdentifier: "BMVipCardCell", for: indexPath) as! BMVipCardCell
        
        
        return cell
    }

}
