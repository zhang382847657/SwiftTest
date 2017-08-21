//
//  CatchCrash.swift
//  SwiftTest
//  异常捕捉
//  Created by 张琳 on 2017/8/21.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit

private let catchCrash = CatchCrash()
private var UncaughtExceptionCount: Int32 = 0
private var UncaughtExceptionMaximum: Int32 = 10

private let CrashLogName = "error1.log" //异常日志的文件名


class CatchCrash: NSObject {
    private let UncaughtExceptionMaximum: Int32 = 10
    
    private let SignalHandler: Darwin.sig_t? = { (signal) in
        let exceptionInfo = HandleCrash.crash(signal)
        try! exceptionInfo?.write(toFile: NSHomeDirectory() + "/Documents/\(CrashLogName)", atomically: true, encoding: .utf8)
    }
    
    class func share() -> CatchCrash {
        return catchCrash
    }
    
    func installUncaughtExceptionHandler() {
        
        NSSetUncaughtExceptionHandler { (exception) in
            // 异常的堆栈信息
            let stackArray = exception.callStackSymbols
            
            // 出现异常的原因
            let reason = exception.reason
            
            // 异常名称
            let name = exception.name
            
            let exceptionInfo = "异常原因：\(String(describing: reason))\n"
                + "异常名字：\(name)\n"
                + "异常堆栈信息：\(stackArray.description)"
            
            print(exceptionInfo)
            
            var tmpArr = stackArray
            tmpArr.insert(reason!, at: 0)
            
            //保存到本地
            try! exceptionInfo.write(toFile: NSHomeDirectory() + "/Documents/\(CrashLogName)", atomically: true, encoding: .utf8)
            abort()
        }
        
        signal(SIGABRT, SignalHandler)
        signal(SIGILL, SignalHandler)
        signal(SIGSEGV, SignalHandler)
        signal(SIGFPE, SignalHandler)
        signal(SIGBUS, SignalHandler)
        signal(SIGPIPE, SignalHandler)
    }
}
