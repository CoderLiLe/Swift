//
//  main.swift
//  自动参考计数
//
//  Created by LiLe on 2017/4/17.
//  Copyright © 2017年 itcast. All rights reserved.
//

import Foundation


class Person {
    let name: String
    init(name: String) {
        self.name = name
        print("\(name) is being initialized")
    }
    deinit {
        print("\(name) is being deinit")
    }
}

var reference1: Person?
var reference2: Person?
var reference3: Person?

//reference1 = Person(name: "John Appleseed")
//reference2 = reference1
//reference3 = reference1

reference1 = nil
reference2 = nil

reference3 = nil

/*
 类实例之间的强引用循环
 解决类实例之间强引用循环
 */
class Person1: Person {
    var apartment: Apartment?
}

class Apartment {
    let unit: String
    init(unit: String) {
        print("\(unit) is being initialized")
        self.unit = unit
    }
    weak var tenant: Person?
    deinit {
        print("Apartment \(unit) is being deinit")
    }
}

var john: Person1?
var unit4A: Apartment?

// 创建Person1实例和Apartment实例
john = Person1(name: "John Appleseed")
unit4A = Apartment(unit: "4a")

john!.apartment = unit4A
unit4A!.tenant = john

// print: John Appleseed is being deinit
john = nil
// print: Apartment 4a is being deinit
unit4A = nil

class Customer {
    let name: String
    var card: CreditCard?
    init(name: String) {
        self.name = name
    }
    deinit {
        print("\(name) is being deinitialized")
    }
}

class CreditCard {
    let number: UInt64
    unowned let customer: Customer
    init(number: UInt64, customer: Customer) {
        self.number = number
        self.customer = customer
    }
    deinit {
        print("Card #\(number) is being deinitialized")
    }
}

var lile: Customer?
lile = Customer(name: "lile")
lile!.card = CreditCard(number: 1234_5678_9012_3456, customer: lile!)

lile = nil


// ****************未知引用******************
class Country {
    let name: String
    var capitalCity: City!
    init(name: String, capitalName: String) {
        self.name = name
        self.capitalCity = City(name: capitalName, country: self)
    }
}

class City {
    let name: String
    unowned let country: Country
    init(name: String, country: Country) {
        self.name = name
        self.country = country
    }
}

var country = Country(name: "China", capitalName: "Beijing")
print("\(country.name)'s capital is called \(country.capitalCity.name)")

// ****************强引用周期******************
class HTMLElement {
    let name: String // 指示该元素的名称，例如'h1', 'p'等
    let text: String? // 文本字符串
    
    lazy var asHTML: () -> String = { [unowned self] in
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }
    
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}

let heading = HTMLElement(name: "h1")
let defaultText = "some default text"
heading.asHTML = {
    return "<\(heading.name)>\(heading.text ?? defaultText)</\(heading.name)>"
}
print(heading.asHTML())

var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello, world")
print(paragraph!.asHTML())

paragraph = nil
