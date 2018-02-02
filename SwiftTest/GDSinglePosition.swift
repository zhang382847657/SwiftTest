//
//  GDSinglePosition.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/9/27.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit

class GDSinglePosition {
    
    var locationManager:AMapLocationManager!  //高德定位管理类

    //单例模式
    static let shared = GDSinglePosition.init()
    
    typealias successAction = (_ location: CLLocation) -> Void //定位成功回调
    typealias errorAction = (_ error:Error) -> Void //定位失败回调
    
    
    private init(){
    
        /////////设置高德地图定位的精准度(推荐写法)//////////
        self.locationManager = AMapLocationManager()
        self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        self.locationManager.locationTimeout = 2
        self.locationManager.reGeocodeTimeout = 2
    }
    
    
    //MARK: 单次定位
    func getPosition(success:successAction?, error:errorAction?){
        
        self.locationManager.requestLocation(withReGeocode: false, completionBlock: { [weak self] (location: CLLocation?, reGeocode: AMapLocationReGeocode?, error: Error?) in
            
            if let error = error {
                let error = error as NSError
                
                if error.code == AMapLocationErrorCode.locateFailed.rawValue {
                    //定位错误：此时location和regeocode没有返回值，不进行annotation的添加
                    NSLog("定位错误:{\(error.code) - \(error.localizedDescription)};")
                    return
                }
                else if error.code == AMapLocationErrorCode.reGeocodeFailed.rawValue
                    || error.code == AMapLocationErrorCode.timeOut.rawValue
                    || error.code == AMapLocationErrorCode.cannotFindHost.rawValue
                    || error.code == AMapLocationErrorCode.badURL.rawValue
                    || error.code == AMapLocationErrorCode.notConnectedToInternet.rawValue
                    || error.code == AMapLocationErrorCode.cannotConnectToHost.rawValue {
                    
                    //逆地理错误：在带逆地理的单次定位中，逆地理过程可能发生错误，此时location有返回值，regeocode无返回值，进行annotation的添加
                    
                    
                    dPrint(item: "逆地理错误:{\(error.code) - \(error.localizedDescription)};")
                   
                }
                else {
                    //没有错误：location有返回值，regeocode是否有返回值取决于是否进行逆地理操作，进行annotation的添加
                }
            }
            
            if let location = location{
                dPrint(item: "单次定位结果:\(location)")
                
                if let success = success{
                    success(location)
                }
            }
            
            if let reGeocode = reGeocode {
                
                dPrint(item:"reGeocode:\(reGeocode)")
            }
        })
    }

}

