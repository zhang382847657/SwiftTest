//
//  BMShopViewController.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/8/1.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit

class BMShopViewController: UIViewController {
    
    var scrollView:UIScrollView! = nil
    var contentView:UIView! = nil
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false //这样可以防止scrollview没有置顶
        
        
        //////////////UIScrollView//////////
        self.scrollView = UIScrollView(frame: CGRect.zero)
        self.view.addSubview(self.scrollView)
        self.scrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        //////////////内容视图//////////
        self.contentView = UIView(frame: CGRect.zero)
        self.scrollView.addSubview(self.contentView)
        self.contentView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.scrollView)
            make.width.equalTo(self.scrollView.snp.width)
            make.height.greaterThanOrEqualTo(0)
        }
        
        
        /////////////头部视图///////////
        let headerView:BMShopHeaderView = UIView.loadViewFromNib(nibName: "BMShopHeaderView") as! BMShopHeaderView
        self.contentView.addSubview(headerView)
        headerView.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(self.contentView)
            make.height.equalTo(215)
        }
        
        
        /////////////地址+网站+手机////////
        let toolsView:BMShopToolsView = UIView.loadViewFromNib(nibName: "BMShopToolsView") as! BMShopToolsView
        self.contentView.addSubview(toolsView)
        toolsView.snp.makeConstraints { (make) in
            make.top.equalTo(headerView.snp.bottom).offset(-8)
            make.left.equalTo(self.contentView).offset(10)
            make.right.equalTo(self.contentView).offset(-10)
            make.height.equalTo(40)
        }
        
        
        /////////////店铺推荐阿姨/////////
        let recommentAuntView:BMShopRecommendAuntView = UIView.loadViewFromNib(nibName: "BMShopRecommendAuntView") as! BMShopRecommendAuntView
        self.contentView.addSubview(recommentAuntView)
        recommentAuntView.snp.makeConstraints { (make) in
            make.top.equalTo(toolsView.snp.bottom).offset(5)
            make.left.right.equalTo(toolsView)
        }
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)  //隐藏导航栏
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true) //显示导航栏
    }

}
