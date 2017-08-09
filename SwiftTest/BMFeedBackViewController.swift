//
//  BMFeedBackViewController.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/8/9.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit
import PKHUD

class BMFeedBackViewController: UIViewController {

    @IBOutlet weak var inputTextView: InputTextView!
    @IBOutlet weak var button: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "意见反馈"
        self.button.layer.cornerRadius = 5
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //提交点击事件
    @IBAction func submitClick(_ sender: UIButton) {
        
        
        HUD.show(.progress)
        
        let content:String = self.inputTextView.textView.text//输入内容
        
        let url = "\(BMHOST)/common/feedback"
        let params:Dictionary<String,Any> = ["appType":1,"duserCode":BMDUSERCODE,"content":content]
        NetworkRequest.sharedInstance.getRequest(urlString: url , params: params , success: { value in
            
            HUD.flash(.success, delay: 1.0) { finished in
                self.navigationController?.popViewController(animated: true)
            }
            
            
        }) { error in
         
            HUD.hide()
        }
        
    }


}
