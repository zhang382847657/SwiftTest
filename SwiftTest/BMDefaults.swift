//
//  BMDefaults.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/7/28.
//  Copyright © 2017年 张琳. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

extension DefaultsKeys {
    static let username = DefaultsKey<String?>("username")
    static let phone = DefaultsKey<String?>("phone")
    static let token = DefaultsKey<String?>("token")
    //static let launchCount = DefaultsKey<Int>("launchCount")
}
