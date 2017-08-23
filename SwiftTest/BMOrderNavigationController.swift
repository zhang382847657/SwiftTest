//
//  BMOrderNavigationController.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/8/23.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit

class BMOrderNavigationController: BMBaseNavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let vc:BMOrderListViewController = BMOrderListViewController(nibName: "BMOrderListViewController", bundle: nil)
        self.pushViewController(vc, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
