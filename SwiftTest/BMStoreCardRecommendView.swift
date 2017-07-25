//
//  BMStoreCardRecommendView.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/6/24.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit
import SwiftyJSON

typealias StoreCardRecommendClickClosure = (_ index:Int) -> Void

class BMStoreCardRecommendView: UIView,UICollectionViewDataSource,UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView! //UICollectionView
    var storeCards:JSON?
    var storeCardRecommendClickClosure: StoreCardRecommendClickClosure? //返回点击回调
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        self.loadContentUI()  //加载内容视图
        
        
        
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        /////////////加载xib的视图////////////
        let nibView = UIView.loadViewFromNib(nibName: "BMStoreCardRecommendView")
        nibView?.frame = frame
        self.addSubview(nibView!)
        
        self.loadContentUI() //加载内容视图
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /**
     * 加载内容视图 包含自定义cell
     */
    
    func loadContentUI() {
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        let cellNib = UINib(nibName: "BMStoreCardRecommendCell", bundle: nil)
        self.collectionView.register(cellNib, forCellWithReuseIdentifier: "cell")
    }
    
    /**
     * 加载JSON数据
     * parma: storeCards 推荐储值卡的json对象
     */
    func updateUIWithStoreCardRecommend(storeCards:JSON) {
        self.storeCards = storeCards
        self.collectionView.reloadData() //刷新数据源
    }
    
    
    //UICollectionView - DataSource
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let storeCards = self.storeCards {
            return (storeCards.array?.count)!
        }
        return 0
    }
    

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let kindName:String? = self.storeCards?[indexPath.row]["kindName"].string
        let price:Float? = self.storeCards?[indexPath.row]["price"].float
        
        let cell:BMStoreCardRecommendCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! BMStoreCardRecommendCell
        
        
        if let kindName = kindName {
            cell.storeCardName.text = kindName
        }
        
        if let price = price {
            cell.storeCardPrice.text = "¥\(price)"
        }
        
        return cell
        
    }
    
    
    
    //UICollectionView - Delegate
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        
        if let _ = self.storeCardRecommendClickClosure {
            self.storeCardRecommendClickClosure!(indexPath.item)
        }
        
    }
    
    
    

}
