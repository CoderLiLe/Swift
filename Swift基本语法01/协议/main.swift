//
//  main.swift
//  协议
//
//  Created by LiLe on 2017/9/12.
//  Copyright © 2017年 itcast. All rights reserved.
//

import Foundation

// MARK: - 1.定义协议

// 格式:协议的定义方式与类, 结构体, 枚举的定义非常相似
protocol SomePortocol {
    // 协议方法
}

// 协议可以继承一个或者多个协议
protocol SomePortocol2: SomePortocol {
    // 协议方法
}

// 结构体实现协议
struct SomeStrure: SomePortocol, SomePortocol2 {
    // 结构体定义
}

// 类实现协议和继承父类
class SomeSuperClass {
    // 父类定义
}

// 协议一般写在父类后面
class SomeClass: SomeSuperClass, SomePortocol {
    // 子类定义
}

// MARK: - 2.协议的属性




