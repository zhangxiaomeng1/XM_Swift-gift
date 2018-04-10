//
//  HYDigitLabel.swift
//  02-礼物连击动画
//
//  Created by zhangxiaomeng on 2018/4/3.
//  Copyright © 2018年 zhangxiaomeng. All rights reserved.
//
import UIKit

class HYDigitLabel: UILabel {
    override func drawText(in rect: CGRect) {
        // 0.记录之前的颜色
        let oldColor = textColor
        
        // 1.获取上下文
        let cxt = UIGraphicsGetCurrentContext()
        
        // 2.设置画边框的属性
        textColor = UIColor.orange
        cxt?.setLineWidth(5)
        // cxt?.setLineCap(.round)
        cxt?.setLineJoin(.round)
        cxt?.setTextDrawingMode(.stroke)
        super.drawText(in: rect)
        
        // 3.画出里面的内容
        textColor = oldColor
        cxt?.setTextDrawingMode(.fill)
        super.drawText(in: rect)
    }
    
    func startScaleAnimating(_ complection : (() -> Void)? = nil) {
        UIView.animateKeyframes(withDuration: 1, delay: 0, options: [], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.4, animations: {
                self.transform = CGAffineTransform(scaleX: 3.0, y: 3.0)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.4, relativeDuration: 0.8, animations: {
                self.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.8, relativeDuration: 1, animations: {
                self.transform = CGAffineTransform.identity
            })
        }) { (_) in
            complection?()
        }
    }
}
