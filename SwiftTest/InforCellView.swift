//
//  InforCellView.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/7/28.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit

class InforCellView: UIView {

    @IBOutlet weak var titleLabel: UILabel!
    var contentView:UIView!
    var singleTap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapClick))  //点击手势

    /*** 下面的几个方法都是为了让这个自定义类能将xib里的view加载进来。这个是通用的，我们不需修改。 ****/
    //初始化时将xib中的view添加进来
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView = loadViewFromNib()
        addSubview(contentView)
        self.initialSetup()
    }
    
    //初始化时将xib中的view添加进来
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        contentView = loadViewFromNib()
        addSubview(contentView)
        self.initialSetup()
    }
    //加载xib
    func loadViewFromNib() -> UIView {
        
        let className = type(of: self)
        let bundle = Bundle(for: className)
        let name = NSStringFromClass(className).components(separatedBy: ".").last
        let nib = UINib(nibName: name!, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return view
    }
    
    //初始化默认属性配置
    func initialSetup(){
       self.addGestureRecognizer(self.singleTap) //给每一个视图添加一个点击的事件
    }
    
    
    
    func tapClick(sender:UITapGestureRecognizer){
        self.backgroundColor = UIColor.groupTableViewBackground
        
    }


}
