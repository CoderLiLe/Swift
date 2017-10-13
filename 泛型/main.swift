//
//  main.swift
//  泛型
//
//  Created by LiLe on 2017/9/28.
//  Copyright © 2017年 itcast. All rights reserved.
//

import Foundation

/*
 泛型：泛型可以让我们的代码更加灵活，重用函数。
 */

// 1.泛型函数：泛型函数在声明时使用了节点类型命名（通常情况下用大写字母T, U, V来表示）来代替实际类型名（如：Int, String, Double等），节点类型在定义时不表示任何具体类型，泛型函数在调用时会根据传入的实际类型来确定自身类型。
// 注意：如果函数的泛型只有一个，但是参数却有几个，那么每个节点类型的参数必须是相同类型的。
func show<T>(para: T) {
    print("Hello, \(para)")
}
show(para: "哥")
show(para: 12)
show(para: 12.2)

func show1<T, U>(para1: T, para2: U) {
    print("\(para1) -- \(para2)")
}
func show2<T>(para1: T, para2: T) {
    print("\(para1) -- \(para2)")
}
show1(para1: "Hei", para2: 12)
show2(para1: 13.0, para2: 12)

// 2.可以对节点进行一些限制，比如要求泛型遵守某些协议。如：Swift中数组的判等
// public func ==<Element : Equatable>(lhs: [Element], rhs: [Element]) ->Bool
// Element 是节点声明的, 它代表一个泛型, 可以看到这里的泛型名是Element, 相比上面的"T","U","V"长的多. 这是因为此处的 Element不仅仅是一个占位符的作用, 它还声明了这个泛型代表数组中的元素类型, 有具体的意义, 这种 API 的设计指的我们借鉴;

// 3.有时候节点中的泛型需要有更多的限制, 需要使用 where 子句来补充约束条件:
/*
func anyCommonElements<T : SquenceType, U : SequenceType>(lhs : T, _ rhs : U) -> Bool where
    T.Generator.Element: Equatable,
    T.Generator.Element == U.Generator.Element{
        return false
}
 */

// 4.泛型协议
protocol SomeProtocol {
    associatedtype Element
    func elementMethod1(element: Element)
    func elementMethod2(element: Element)
}

struct TestStruct: SomeProtocol {
    func elementMethod1(element: String) {
        print("elementMethod1: \(element)")
    }

    func elementMethod2(element: String) {
        print("elementMethod2: \(element)")
    }
}

// 类似于associatedtype的还有 self 关键字, 代表了协议遵守着本身的类型, 适用于比较这类方法, 其必须传入另一个相同类型的参数才有意义。
protocol CanCompare {
    func isBigger(other: Self) -> Bool
}

struct BoxInt: CanCompare {
    var intValue: Int
    func isBigger(other: BoxInt) -> Bool {
        return self.intValue > other.intValue
    }
}
print(BoxInt(intValue: 3).isBigger(other: BoxInt(intValue: 2)))

// 5.泛型对象
struct TestStruct2<T: Comparable> {
    func elementMethod3(element: Int) {
        print("elementMethod3: \(element)")
    }
    
    func elementMethod4(element: Int) {
        print("elementMethod4: \(element)")
    }
}
let test2 = TestStruct2<Int>()
test2.elementMethod3(element: 1)

// 注意:如果你尝试在实现一个泛型时"嵌套"一个泛型,那么会导致泛型无法被初始化; 比如数组本身是泛型的,在声明数组类型时传入了另一个泛型, 那么你将无法初始化该数组:
struct TestStruct3<T: Comparable >{
    
    var array:[T] = [1, 3, 4, 5] as! [T] // as! [T]  这样貌似就能解决了, 但是这样泛型就没有意义了
}

// 6.泛型方法：方法中的泛型使用节点表示法，使用域只在本方法内
struct TestStruct4 {
    func elementMethod5<T: Comparable >(element: T){
        print("elementMethod5 === \(element)")
    }
    
    func elemetMethod6<T: Comparable >(element: T){
        print("elementMethod6 === \(element)")
    }
}
let test3 = TestStruct4()
test3.elementMethod5(element: 1)
test3.elemetMethod6(element: "abc")


// 7.泛型特化: LLVM 编译将 C 和 OC 的代码放在一个低级的容器中, 然后编译成机器代码; 运行泛型并不是很安全;
// 输出常量和变量, 可以用print(_:separator:terminator:)函数来输出当前常量或变量的值:
// print(_:separator:terminator:)是一个用来输出一个或多个值到适当输出区的全局函数。如果用 Xcode，print(_:separator:terminator:)将会输出内容到“console”面板上。separator和terminator参数具有默认值，因此调用这个函数的时候可以忽略它们。默认情况下，该函数通过添加换行符来结束当前行。如果不想换行，可以传递一个空字符串给terminator参数--例如，print(someValue, terminator:"")。

func and<T>(first: T, _ second: T) {
    print(first, second, separator: "+", terminator: "")
    print()
}
and(first: 3, 5)
and(first: "a", "b")

// 此时 LLVM 在编译时会把 and 函数特化为:
func and(first: Int, _ second: Int){
    print(first, second, separator: "+", terminator: "")
}
// 以及
func and(first: String, _ second: String){
    print(first, second, separator: "+", terminator: "")
}

