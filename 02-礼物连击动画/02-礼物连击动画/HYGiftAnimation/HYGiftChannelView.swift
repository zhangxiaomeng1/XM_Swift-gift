//
//  HYGiftChannelView.swift
//  02-礼物动画
//
//  Created by zhangxiaomeng on 2018/4/3.
//  Copyright © 2018年 zhangxiaomeng. All rights reserved.
//
import UIKit

enum ChannerlViewState {
    case idle
    case animating
    case endWating
    case ending
}

class HYGiftChannelView: UIView {
    // MARK: 控件属性
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var senderLabel: UILabel!
    @IBOutlet weak var giftDescLabel: UILabel!
    @IBOutlet weak var giftImageView: UIImageView!
    @IBOutlet weak var digitLabel: HYDigitLabel!
    
    // MARK: 定义属性
    var finishedCallback : ((HYGiftChannelView) -> Void)?
    var state : ChannerlViewState = .idle
    var cacheNumber : Int = 0
    fileprivate var currentNumber : Int = 0
    
    var giftModel : HYGiftModel?  {
        didSet {
            // 1.校验模型是否有值
            guard let giftModel = giftModel else {
                return
            }
            
            // 2.将giftModel中属性设置到控件中
            iconImageView.image = UIImage(named: giftModel.senderIcon)
            senderLabel.text = giftModel.senderName
            giftDescLabel.text = "送出礼物【\(giftModel.giftName)】"
            giftImageView.image = UIImage(named: giftModel.giftIcon)
            
            // 3.将channelView展示出来
            performShowAnimating()
        }
    }
}

// MARK:- 设置UI界面
extension HYGiftChannelView {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        bgView.layer.cornerRadius = frame.height * 0.5
        bgView.layer.masksToBounds = true
        iconImageView.layer.cornerRadius = frame.height * 0.5
        iconImageView.layer.masksToBounds = true
        iconImageView.layer.borderWidth = 1
        iconImageView.layer.borderColor = UIColor.green.cgColor
    }
    
    class func loadChannelView() -> HYGiftChannelView {
        return Bundle.main.loadNibNamed("HYGiftChannelView", owner: nil, options: nil)?.first as! HYGiftChannelView
    }
}


// MARK:- 对外提供的函数
extension HYGiftChannelView {
    func addOnceToCache() {
        if state == .endWating {
            NSObject.cancelPreviousPerformRequests(withTarget: self)
            self.state = .animating
            performDigitAnimating()
        } else {
            cacheNumber += 1
        }
    }
}


// MARK:- 执行的动画
extension HYGiftChannelView {
    fileprivate func performShowAnimating() {
        state = .animating
        
        UIView.animate(withDuration: 0.25, animations: { 
            self.frame.origin.x = 0
            self.alpha = 1.0
        }) { (_) in
            self.performDigitAnimating()
        }
    }
    
    fileprivate func performDigitAnimating() {
        // 1.将digitLabel的alpha值设置为1
        digitLabel.alpha = 1
        
        // 2.设置digitLabel上面显示的数字
        currentNumber += 1
        digitLabel.text = " x\(currentNumber)"
        
        // 3.执行动画
        digitLabel.startScaleAnimating {
            if self.cacheNumber > 0 {
                self.cacheNumber -= 1
                self.performDigitAnimating()
            } else {
                self.state = .endWating
                self.perform(#selector(self.performEndAnimating), with: nil, afterDelay: 3.0)
            }
        }
    }
    
    @objc fileprivate func performEndAnimating() {
        self.state = .ending
        
        UIView.animate(withDuration: 1, animations: {
            self.frame.origin.x = UIScreen.main.bounds.width
        }) { (_) in
            self.alpha = 0.0
            self.state = .idle
            self.digitLabel.alpha = 0
            self.currentNumber = 0
            self.cacheNumber = 0
            self.frame.origin.x = -self.frame.width
            self.giftModel = nil
            
            self.finishedCallback?(self)
        }
    }
}

