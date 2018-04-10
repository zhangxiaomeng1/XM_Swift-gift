//
//  ViewController.swift
//  02-礼物连击动画
//
//  Created by zhangxiaomeng on 2018/4/3.
//  Copyright © 2018年 zhangxiaomeng. All rights reserved.
//
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var demoLabel: HYDigitLabel!
    fileprivate var containerView : HYGiftContainerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let containerFrame = CGRect(x: 0, y: 100, width: 320, height: 90)
        let containerView = HYGiftContainerView(frame: containerFrame)
        view.addSubview(containerView)
        self.containerView = containerView
    }
    
    @IBAction func gift1() {
        let giftModel = HYGiftModel(senderName: "coderwhy", senderIcon: "icon4", giftIcon: "prop_g", giftName: "蘑菇")
        containerView.insertGiftModel(giftModel)
    }
    
    @IBAction func gift2() {
        let giftModel = HYGiftModel(senderName: "zhangsan", senderIcon: "icon3", giftIcon: "prop_f", giftName: "啤酒")
        containerView.insertGiftModel(giftModel)
    }
    
    @IBAction func gift3() {
        let giftModel = HYGiftModel(senderName: "coderwhy", senderIcon: "icon4", giftIcon: "prop_b", giftName: "跑车")
        containerView.insertGiftModel(giftModel)
    }
    
    @IBAction func gift4() {
        let giftModel = HYGiftModel(senderName: "李四", senderIcon: "icon1", giftIcon: "prop_h", giftName: "红包")
        containerView.insertGiftModel(giftModel)
    }
    
}

