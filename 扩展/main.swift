//
//  main.swift
//  扩展
//
//  Created by LiLe on 2017/9/28.
//  Copyright © 2017年 itcast. All rights reserved.
//

import Foundation

/*
 扩展: 就是给一个现存类, 结构体, 枚举或者协议添加新的属性或着方法的语法, 无需目标源码, 就可以把想要的代码加到目标上面
 但有一些限制条件需要说明:
     1.不能添加一个已经存在的方法或者属性;
     2.添加的属性不能是存储属性, 只能是计算属性;
 
 格式:
 extension 某个先有类型 {
     // 增加新的功能
 }
 */

// 1.扩展计算属性
class Transport {
    var scope: String
    init(scope: String) {
        self.scope = scope
    }
}

extension Transport {
    var extProperty: String {
        get {
            return scope
        }
    }
    
}
var myTran = Transport(scope: "✈️")
print(myTran.extProperty)

// 2.扩展构造器
class ChinaTransport {
    var price = 30
    var scope: String
    init(scope: String) {
        self.scope = scope
    }
}

extension ChinaTransport {
    convenience init(price: Int, scope: String) {
        self.init(scope: scope)
        self.price = price
    }
}
var myTran1 = ChinaTransport(scope: "歼9")
var myTran2 = ChinaTransport(price: 5000000, scope: "歼10")

// 3.扩展方法

// 扩展整数类型
extension Int {
    func calculateDouble() -> Int {
        return self * 2
    }
}

var i = 3
print(i.calculateDouble())

// 扩展下标
// 我们还可以通过扩展下标的方法来增强类的功能，比如扩展整数类型，使整数类型可以通过下标返回整数的倍数
extension Int {
    subscript(num: Int) -> Int {
        return self * num;
    }
 }
print(10[3])
