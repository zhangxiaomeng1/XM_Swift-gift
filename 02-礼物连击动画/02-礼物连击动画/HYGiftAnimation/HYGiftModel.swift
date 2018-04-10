//
//  HYGiftModel.swift
//  01-礼物连击
//
//  Created by zhangxiaomeng on 2018/4/3.
//  Copyright © 2018年 zhangxiaomeng. All rights reserved.
//
import UIKit

class HYGiftModel : NSObject {
    var senderName : String = ""
    var senderIcon : String = ""
    var giftIcon : String = ""
    var giftName : String = ""
    
    init(senderName : String, senderIcon : String, giftIcon : String, giftName : String) {
        self.senderName = senderName
        self.senderIcon = senderIcon
        self.giftIcon = giftIcon
        self.giftName = giftName
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        // 1.判断传入的内容是否有值
        guard let object = object as? HYGiftModel else {
            return false
        }
        
        // 2.判断赠送者和赠送的礼物名称是否相同
        return object.senderName == senderName && object.giftName == giftName
    }
}
