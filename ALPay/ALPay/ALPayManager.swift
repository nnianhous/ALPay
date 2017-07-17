//
//  ALBmobPayManager.swift
//  ALBmobPay
//
//  Created by N年後 on 2017/7/17.
//  Copyright © 2017年 lifp. All rights reserved.
//

import UIKit


/**
 支付类型选择
 
 - alWechat: 微信付款
 - alAlipay: 支付宝付款
 */

public enum ALPayType : Int {
    case alWechat = 5
    case alAlipay = 3
}

public typealias ALPayBooleanResultBlock = (Bool, Error?) -> Swift.Void
public typealias ALDictionaryResultBlock = ([AnyHashable : Any]?, Error?) -> Swift.Void

public class ALPayManager: NSObject {
    static let manager = ALPayManager()
    
    //  注册key
    public func registerWithAppKey(appKey:String) {
        Bmob.register(withAppKey: appKey)
    }
    
    /**
     调用支付接口
     
     @param payType 支付类型选择
     @param price 订单价格，限额 0-5000
     @param orderName 订单名称
     @param describe 订单描述
     @param result 支付结果回调
     */
    public func payWithPayType(payType:ALPayType,price:Float,orderName:String,describe:String,callback: @escaping ALPayBooleanResultBlock) {
        let payType = BmobPayType(rawValue: payType.rawValue)
        BmobPay.pay(with: payType!, price: price as NSNumber, orderName: orderName, describe: describe, result: callback)
    }
    
    
    /**
     订单信息回调
     
     @param orderInfoCallback 回调block
     */
    public func orderInfoCallback(callback: @escaping ALDictionaryResultBlock) {
        BmobPay.orderInfoCallback { (dic) in
            callback(dic, nil)
        }
    }
    
    
    /**
     支付结果自助查询
     
     @param orderNumber 订单号
     @param result 回调block
     */
    public func queryWithOrderNumber(orderNumber:String,callback: @escaping ALDictionaryResultBlock) {
        BmobPay.query(withOrderNumber: orderNumber, result: callback)
    }
    


}
