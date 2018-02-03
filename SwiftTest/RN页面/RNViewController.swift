//
//  RNViewController.swift
//  SwiftTest
//
//  Created by 张琳 on 2018/2/2.
//  Copyright © 2018年 张琳. All rights reserved.
//

import UIKit


class RNViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let strUrl = "http://localhost:8081/index.ios.bundle?platform=ios&dev=true"
        
        let jsCodeLocation = URL(string: strUrl)
//        let rootView = RCTRootView(bundleURL: jsCodeLocation, moduleName: "arenaModule", initialProperties: nil, launchOptions: nil)
//        
//    
//        view = rootView

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
