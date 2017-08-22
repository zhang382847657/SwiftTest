//
//  BMAuntCerListView.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/8/8.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit
import SwiftyJSON

class BMAuntCerListView: UIView,UICollectionViewDelegate,UICollectionViewDataSource {
    
    var topView:UIView!
    var headerView:BMAuntCerHeaderView!
    var collectionView:UICollectionView!
    var bottomView:UIButton!
    var dataSource:Array<JSON>!
    
    let headerViewHeight = 53 //头部标题视图的高度
    let collectionViewHeight = 196  //collectionView的高度
    

    /*
     *  初始化
     * @param cerList JSON  阿姨证书数组
     */
    init(cerList:JSON) {
        
        super.init(frame: CGRect.zero)
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        self.dataSource = cerList.array
        
        //////////////顶部视图///////////
        self.topView = UIView(frame: CGRect.zero)
        self.addSubview(self.topView)
        
        self.topView.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(-(headerViewHeight+collectionViewHeight))
            make.left.right.equalTo(self)
            make.height.equalTo(headerViewHeight+collectionViewHeight)
        }
        
        ////头部视图///
        self.headerView = UIView.loadViewFromNib(nibName: "BMAuntCerHeaderView") as! BMAuntCerHeaderView
        self.headerView.updateNumber(currentNum: 1, totalNum: self.dataSource.count)
        self.topView.addSubview(self.headerView)
        self.headerView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self.topView)
            make.height.equalTo(headerViewHeight)
        }
        
        ///证书视图////
        let layout:CardSwitchLayout = CardSwitchLayout()
        layout.itemSize = CGSize(width: 197, height: 124)
        self.collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        self.collectionView.backgroundColor = UIColor.white
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "BMAuntCerCell", bundle: nil), forCellWithReuseIdentifier: "BMAuntCerCell")
        self.topView.addSubview(self.collectionView)
        
        self.collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(self.headerView.snp.bottom)
            make.left.right.equalTo(self.topView)
            make.height.equalTo(collectionViewHeight)
        }
        
        
        
        //////////////底部按钮用来关闭当前视图//////////////
        self.bottomView = UIButton(type: .system)
        self.bottomView.addTarget(self, action: #selector(bottomClick), for: .touchUpInside)
        self.bottomView.backgroundColor = UIColor.clear
        self.addSubview(self.bottomView)
        
        self.bottomView.snp.makeConstraints { (make) in
            make.top.equalTo(self.topView.snp.bottom)
            make.left.right.equalTo(self)
            make.bottom.equalTo(self.snp.bottom)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return dataSource.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BMAuntCerCell", for: indexPath) as! BMAuntCerCell
        cell.updateWithCer(cer: self.dataSource[indexPath.item])
        return cell
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let pointInView = self.convert(self.collectionView.center, to: self.collectionView)
        let indexPath:IndexPath = self.collectionView.indexPathForItem(at: pointInView)!
        self.headerView.updateNumber(currentNum: indexPath.item+1, totalNum: self.dataSource.count)
    }
    
    
    
    //显示当前视图
    func show(){
        self.isHidden = false
        
        self.topView.snp.updateConstraints({ (make) in
            make.top.equalTo(self.snp.top)
        })
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 5, options: .curveEaseOut , animations: { () -> Void in
        
            self.layoutIfNeeded()
        
        }) { (Bool) -> Void in
            
        }
    }
    
    
    //关闭当前视图
    func close(){
        
        self.topView.snp.updateConstraints({ (make) in
            make.top.equalTo(self.snp.top).offset(-(headerViewHeight+collectionViewHeight))
        })
        
        UIView.animate(withDuration: 0.2, animations: {
            self.layoutIfNeeded()
            
        }) { (Bool) in
            
            self.isHidden = true
        }
    }
    
    
    //底部关闭按钮点击事件
    func bottomClick(){
        self.close()
    }

}
