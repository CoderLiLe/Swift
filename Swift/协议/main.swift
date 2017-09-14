//
//  main.swift
//  协议
//
//  Created by LiLe on 2017/9/12.
//  Copyright © 2017年 itcast. All rights reserved.
//

import Foundation

// 协议是swift非常重要的一部分,苹果甚至为了它单独出来——–面向协议编程,利用协议的优点和灵活性可以使整个项目结构更加灵活,拥有更加易于延展的架构.

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

// 协议不指定该属性应该是一个存储属性或者计算属性，它只指定所需的名称和读写类型。属性要求总是声明为变量属性，用var关键字做前缀。

protocol ClassProtocol {
    static var present:Bool { get set } // 要求该属性可读可写，并且是静态的
    var subject: String { get } // 要求该属性可读
    var stName: String { get set } // 要求该属性可读写
}

class MyClass: ClassProtocol {
    static var present = false // 如果没有实现协议的属性要求，编译器会直接报错
    
    var subject = "Swift Protocol"
    
    var stName: String = "Class"
    
    func attendance() -> String {
        return "The \(self.stName) has secured 99% attendance"
    }
    
    func markSScured() -> String {
        return "\(self.stName) has \(self.subject)"
    }
}

var c = MyClass()
print(c.attendance()) // The Class has secured 99% attendance
print(c.markSScured()) // Class has Swift Protocol

// MARK: - 3.协议普通方法实现

// 协议可以要求制定实例方法和类方法一致的类型实现。这些方法被写为协议的一部分，跟普通实例和类型方法完全一样，但是没有大括号或方法体。可变参数是允许的，普通方法也遵循同样的规则，不过不允许给协议方法参数指定默认值。

// 定义协议，指定方法要求
protocol RandomNumberGenerator {
    func random() -> Double // 实现该协议，需要实现该方法
}

class LinerCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 45.0
    let m = 14998.0
    let a = 24489.0
    let c = 29879.0
    
    func random() -> Double {
        lastRandom = ((lastRandom * a + c).truncatingRemainder(dividingBy: m)) // truncatingRemainder 替代旧方法 %
        return lastRandom / m
    }
}

let generator = LinerCongruentialGenerator()
print("随机数:\(generator.random())")    // 随机数:0.468995866115482
print("再来随机数:\(generator.random())") // 再来随机数:0.231964261901587

// MARK: - 4.协议中实现构造函数

// 协议SomeProtocol中不仅可以声明方法/属性/下标, 还可以声明构造器, 但在Swift中, 除了某些特殊情况下, 构造器是不被子类继承的, 所以SomeClass中虽然能保证定义了协议要求的构造器, 但不能保证SomeClass的子类中也定义了协议要求的构造器. 所以我们需要在实现协议要求的构造器时, 使用required关键字确保SomeClass的子类也得实现这个构造器。

protocol TcpProtocol {
    init(aprot: Int)
}

class TcpClass: TcpProtocol {
    var aprot: Int
    required init(aprot: Int) {
        self.aprot = aprot
    }
}

var tcp = TcpClass(aprot: 20)
print(tcp.aprot)

// MARK: - 5.使用举例

// 例子: 举个简单的例子，有一只猫和狗，他们都属于宠物，用类去实现就要这样操作，定义一个父类叫做宠物，里面有喂食和玩耍两个方法，猫和狗都继承与宠物这个父类。这样操作自然可以实现，但是要知道，猫和狗不都是宠物，这里把宠物定义成父类就不是很合适，这里应该把宠物定义成协议就相对合适很多啦

// 宠物猫和宠物狗的例子，利用协议可以这样实现，声名个动物的父类，然后让猫和狗class都继承与动物class。在定义一个宠物的协议，里面有玩耍和喂食两个方法，让猫和狗都继承与宠物协议，实现代码如下：

protocol Pet {
    func play()
    func fed(food: String)
}

class Animal {
    var name: String = ""
    var birthPlace: String = ""
    init(name: String, birthPlace: String) {
        self.name = name
        self.birthPlace = birthPlace
    }
}

class Dog: Animal, Pet {
    func play() {
        print("🐶在玩耍")
    }
    
    func fed(food: String) {
        if food == "骨头" {
            print("🐶 Happy")
        } else {
            print("🐶 Sad")
        }
    }
}

class Cat: Animal, Pet {
    func play() {
        print("🐱在玩耍")
    }
    
    func fed(food: String) {
        if food == "🐟" {
            print("🐱 Happy")
        } else {
            print("🐱 Sad")
        }
    }
}

let dog = Dog(name: "狗狗小累累", birthPlace: "河南")
dog.play()
dog.fed(food: "骨头")

let cat = Cat(name: "猫猫小可爱", birthPlace: "北京")
cat.play()
cat.fed(food: "🐟")

// 注意：同时继承父类和协议的时候，父类要写在前面

// MARK: - 6.typealias结合协议使用

//extension Double {
//    var km: Length {
//        return self * 1000.0
//    }
//
//    var m: Length {
//        return self
//    }
//
//    var cm: Length {
//        return self / 100
//    }
//}
//let runDistance:Length = 3.14.km // 3140

protocol WeightCalculble {
    associatedtype WeightType
    var weight: WeightType { get }
}

class iPhone8: WeightCalculble {
    typealias WeightType = Double
    
    var weight: WeightType {
        return 0.1314
    }
}

class ship: WeightCalculble {
    typealias WeightType = Int
    
    let weight: WeightType
    
    init(weight: Int) {
        self.weight = weight
    }
}

extension Int {
    typealias Weight = Int
    // t: 吨
    var t: Weight {
        return 1_000 * self
    }
}

// MARK: - 7.协同协议的使用

// 我们还可以继承于系统协议来定义系统方法，这里简单介绍常用的三种系统协议

// 7.1 Equatable协议用于定义 "==" 来实现操作

class Person: Equatable, Comparable, CustomStringConvertible {
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
    static func <(lhs: Person, rhs: Person) -> Bool {
        return false
    }
    
    var description: String {
        return "name" + ", age: " + String(age)
    }
}
func ==(left: Person, right: Person) -> Bool {
    return left.name == right.name && left.age == right.age
}

let personA = Person(name: "a", age: 10)
let personB = Person(name: "b", age: 20)
let personC = Person(name: "a", age: 10)
let personD = personA
print(personA == personB)
print(personA == personC)
print(personA == personD)

// 注意：func == 方法要紧跟协议下面写，否则编译器会报错

// 7.2 Comparable协议用于自定义比较符号
func <(left: Person, right: Person) -> Bool {
    return left.age < right.age
}
let personE = Person(name: "e", age: 9)
let personF = Person(name: "f", age: 10)
// 注意，在定义比较符号后，很多方法也会同时修改便于我们使用，例如排序方法

let person1 = Person(name:"a",age:9)
let person2 = Person(name:"a",age:12)
let person3 = Person(name:"a",age:11)

var  arrPerson = [person1, person2, person3]
arrPerson.sort()
print(arrPerson)

// 7.3 CustomStringConvertible协议用于自定义打印

