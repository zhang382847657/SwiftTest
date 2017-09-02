//
//  BMEditCommonAddressViewController.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/9/2.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit
import SwiftyJSON

class BMEditCommonAddressViewController: UIViewController {

    @IBOutlet weak var nameView: InputView!  //姓名
    @IBOutlet weak var phoneView: InputView! //手机号
    @IBOutlet weak var addressView: InforPickerView! //地址
    @IBOutlet weak var houseNumberView: InputView! //门牌号
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nameView.titile = "姓名"
        self.phoneView.titile = "手机号"
        self.addressView.titile = "地址"
        self.houseNumberView.titile = "门牌号"
        
    }
    
    
    //MARK: 编辑常用地址初始化
    //parmas: commonAddress 地址信息
    init(withCommonAddress commonAddress:JSON) {
        super.init(nibName: nil, bundle: nil)
        self.title = "编辑常用地址"
        
    }
    
    //MARK: 新增常用地址初始化
    init(){
        super.init(nibName: nil, bundle: nil)
        self.title = "添加常用地址"
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //保存点击事件
    @IBAction func saveClick(_ sender: UIButton) {
    }
}
