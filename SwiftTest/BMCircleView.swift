//
//  BMCircleView.swift
//  SwiftTest
//
//  Created by 张琳 on 2017/7/21.
//  Copyright © 2017年 张琳. All rights reserved.
//

import UIKit

class BMCircleView: UIView {

    struct Constant {
        //进度条宽度
        static let lineWidth: CGFloat = 20
        //进度槽颜色
        static let trackColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0,
                                        alpha: 1)
        //进度条颜色
        static let progressColor = UIColor.colorWithHexString(hex: BMThemeColor)
        
        //圆点颜色
        static let dotColor = UIColor.white
    }
    
    //进度槽
    let trackLayer = CAShapeLayer()
    //进度条
    let progressLayer = CAShapeLayer()
    //进度条路径（整个圆圈）
    let path = UIBezierPath()
    //头部圆点
    let dotLayer = CAShapeLayer()
    //原点拖拽手势
    var panGesture: UIPanGestureRecognizer!
    
    
    //进度条圆环中点
    var progressCenter:CGPoint {
        
        get{
            return CGPoint(x: bounds.midX, y: bounds.midY)
        }
    }
    
    //进度条圆环中点
    var radius:CGFloat{
        get{
            return bounds.size.width/2 - Constant.lineWidth
        }
    }
    
    
    //当前进度
    @IBInspectable var progress: Int = 0 {
        didSet {
            if progress > 100 {
                progress = 100
            }else if progress < 0 {
                progress = 0
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func draw(_ rect: CGRect) {
        
        
        //获取整个进度条圆圈路径
        path.addArc(withCenter: progressCenter, radius: radius,
                    startAngle: angleToRadian(-90), endAngle: angleToRadian(270), clockwise: true)
        
        //绘制进度槽
        trackLayer.frame = bounds
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.strokeColor = Constant.trackColor.cgColor
        trackLayer.lineWidth = Constant.lineWidth
        trackLayer.path = path.cgPath
        layer.addSublayer(trackLayer)
        
        //绘制进度条
        progressLayer.frame = bounds
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = Constant.progressColor.cgColor
        progressLayer.lineWidth = Constant.lineWidth
        progressLayer.path = path.cgPath
        progressLayer.strokeStart = 0
        progressLayer.strokeEnd = CGFloat(progress)/100.0
        layer.addSublayer(progressLayer)
        
        //绘制进度条头部圆点
        let dotPath = UIBezierPath(ovalIn:
            CGRect(x: 0,y: 0, width: Constant.lineWidth, height: Constant.lineWidth)).cgPath
        dotLayer.frame = CGRect(x: 0, y: 0, width: Constant.lineWidth,height: Constant.lineWidth)
        dotLayer.position = calcCircleCoordinateWithCenter(progressCenter,radius: radius, angle: CGFloat(-progress)/100*360+90)
        dotLayer.lineWidth = 0
        dotLayer.path = dotPath
        dotLayer.strokeStart = 0
        dotLayer.strokeEnd = 1
        dotLayer.strokeColor = Constant.progressColor.cgColor
        dotLayer.fillColor = Constant.dotColor.cgColor
        dotLayer.shadowColor = UIColor.black.cgColor
        dotLayer.shadowRadius = 5.0
        dotLayer.shadowOpacity = 0.5
        dotLayer.shadowOffset = CGSize.zero
        layer.addSublayer(dotLayer)
        
        
        
        //初始化拖拽手势
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(pan))
        self.addGestureRecognizer(panGesture)

        
        
        

    }
    
    //设置进度（可以设置是否播放动画）
    func setProgress(_ pro: Int,animated anim: Bool) {
        setProgress(pro, animated: anim, withDuration: 0.55)
    }
    
    //设置进度（可以设置是否播放动画，以及动画时间）
    func setProgress(_ pro: Int,animated anim: Bool, withDuration duration: Double) {
    
        progress = pro
        
        //进度条+圆点动画
        CATransaction.begin()
        CATransaction.setDisableActions(!anim)
        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name:
            kCAMediaTimingFunctionEaseInEaseOut))
        CATransaction.setAnimationDuration(duration)
        progressLayer.strokeEnd = CGFloat(progress)/100.0
        dotLayer.position = calcCircleCoordinateWithCenter(progressCenter,radius: radius, angle: CGFloat(-progress)/100*360+90)
        CATransaction.commit()
        

    }
    
    //将角度转为弧度
    fileprivate func angleToRadian(_ angle: Double)->CGFloat {
        return CGFloat(angle/Double(180.0) * Double.pi)
    }
    
    //计算圆弧上点的坐标
    func calcCircleCoordinateWithCenter(_ center:CGPoint, radius:CGFloat, angle:CGFloat)
        -> CGPoint {
            let x2 = radius*CGFloat(cosf(Float(angle)*Float(Double.pi)/Float(180)))
            let y2 = radius*CGFloat(sinf(Float(angle)*Float(Double.pi)/Float(180)))
            return CGPoint(x: center.x+x2, y: center.y-y2);
    }
    
    
    /**
     *计算两点之间的角度,再换算成百分比
     *@param  fist  开始坐标
     *@param  second  结束坐标
     *return  Int  百分比
     */
    func  angleBetweenPoints(first:CGPoint,second:CGPoint) -> Int {
        
        let height:CGFloat = second.y - first.y;
        let width:CGFloat = second.x - first.x;
        let rads:CGFloat = atan(height/width);
        
        let percent = (rads / CGFloat(Double.pi)) * 100
        
        if(percent<0){
            return Int(100+percent)
        }else{
            return Int(percent)
        }
        
    }
    
    
    
    //拖动手势
    func pan() {
        
        //得到拖的过程中的xy坐标
        let translation : CGPoint = panGesture.location(in: self)
        
        dPrint(item: translation)
    
        let startPoint = calcCircleCoordinateWithCenter(progressCenter,radius: radius, angle: CGFloat(0)/100*360+90)
        
        
        let pro = angleBetweenPoints(first: startPoint, second: translation)
        setProgress(pro , animated: false)
      
        dPrint(item: pro)
    }

}
