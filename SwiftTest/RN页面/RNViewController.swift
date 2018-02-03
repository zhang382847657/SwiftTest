//
//  RNViewController.swift
//  SwiftTest
//
//  Created by 张琳 on 2018/2/2.
//  Copyright © 2018年 张琳. All rights reserved.
//

import UIKit
import React


class RNViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let jsCodeLocation = RCTBundleURLProvider.sharedSettings().jsBundleURL(forBundleRoot: "index", fallbackResource: nil)
        let rootView = RCTRootView(bundleURL: jsCodeLocation, moduleName: "SwiftTest", initialProperties: nil, launchOptions: nil)
        view = rootView

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
