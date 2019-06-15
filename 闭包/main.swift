//
//  main.swift
//  闭包
//
//  Created by LiLe on 15/3/17.
//  Copyright (c) 2015年 LiLe. All rights reserved.
//

import Foundation

/*
闭包:
函数是闭包的一种
类似于OC语言的block
闭包表达式(匿名函数) -- 能够捕获上下文中的值

语法: in关键字的目的是便于区分返回值和执行语句
闭包表达式的类型和函数的类型一样, 是参数加上返回值, 也就是in之前的部分
{
    (参数) -> 返回值类型 in
    执行语句
}
*/

// MARK: - 方式1：利用typealias最完整的创建
typealias Add = (_ num1: Int, _ num2: Int) -> (Int)
let addClosure1: Add
addClosure1 = { (_ num1: Int, _ num2: Int) -> (Int) in
    return num1 + num2
}
let result1 = addClosure1(1, 2)

// MARK: - 方式2：闭包类型声明和变量的创建合并在一起
let addClosure2: (_ num1: Int, _ num2: Int) -> (Int)
addClosure2 = { (_ num1: Int, _ num2: Int) -> (Int) in
    return num1 + num2
}
let result2 = addClosure2(1, 2)

// MARK: - 方式3：省略闭包接收的形参类型和闭包体中返回值的类型
// 创建一个 (Int, Int) -> (Int) 类型的闭包常量：addClosure3
let addClosure3: (Int, Int) -> (Int)
addClosure3 = { (num1, num2) in
    return num1 + num2
}
let result3 = addClosure3(20, 10)

// MARK: - 方式4：闭包的定义和实现合并在一起
// 创建一个 (Int, Int) -> (Int) 类型的闭包常量：addClosure4 并赋值
let addClosure4: (Int, Int) -> (Int) = { (num1, num2) in
    return num1 + num2
}
// 调用闭包并接受返回值
let result4 = addClosure4(20, 10)

// MARK: - 方式5：如果闭包没有接收参数则可以省略in
let addClosure5: () -> (String) = {
    return "这个闭包没有参数，但是有返回值"
}
let result5 = addClosure5()

// MARK: - 方式6：$0的使用
// 创建一个 (String, String) -> (String) 类型的闭包常量：addCloser1 并赋值
// 这得益于Swift的类型推断机制，使我们可以通过$0 $1等名字来引用闭包中的实际参数值，简写的实际参数名的数字和类型将会从期望的函数类型中推断处理
let addClosure6: (String, String) -> (String) = {_,_ in
    return "闭包的返回值是:($0),($1)"
} // 调用闭包并接受返回值
let result = addClosure6("Hello", "Swift!")

// MARK: - ========================================

// MARK: - 闭包的使用场景

// MARK:- 场景1：闭包传值

// MARK:- 场景2：闭包作为函数的参数
// 为接受一个Int类型的参数并且返回一个Int类型的值的闭包类型定义一个别名：Number
typealias Number = (_ num1: Int) -> (Int) //定义一个接收Number类型的参数没有返回值的方法
func text(num: Number) {
    // code
}

// MARK: - 尾随闭包
// 方法的定义，闭包作为函数的第一个参数
func combine(handle: (String, String) -> (Void), num: Int) {
    handle("hello", "world \(num)")
}

// 方法的调用
combine(handle: { (text1, text2) -> (Void) in
    print("\(text1) \(text2)")
}, num: 2017)

// 上面的combine方法在主动调用的时候依旧是按照func(形参: 实参)这样的格式。当我们把闭包作为函数的最后一个参数的时候就引出了尾随闭包的概念。

// 尾随闭包：当需要将一个很长的闭包表达式作为函数最后一个实际参数传递给函数时，一个写在函数形参括号后面的闭包表达式
func combine1(num: Int, handle: (String, String) -> (Void)) {
    handle("hello", "world \(num)")
}
combine1(num: 2018) { (text1, text2) -> (Void) in
    print("\(text1) \(text2)")
}

// 如果闭包表达式被用作函数唯一的实参并把闭包表达式用作尾随闭包，那么调用这个函数的时候函数名字后的()也可以省略
func combine2(handle: (String, String) -> (Void)) {
    handle("hello", "world!!!")
}
combine2 { (text1, text2) -> (Void) in
    print("\(text1) \(text2)")
}

// MARK: - 逃逸闭包
// 如果一个闭包作为一个参数传递给一个函数，并且在函数return之后才能被唤起执行，那么我们称这个闭包的参数是“逃出”这个函数体外，这个闭包就是逃逸闭包。此时可以在形参前写@escaping来明确闭包是允许逃逸的。

// 闭包可以逃逸的一种方法是被储存在定义于函数外的变量里。比如说，很多函数接收闭包实际参数来作为启动异步任务的回调。函数在启动任务后返回，但是闭包要直到任务完成——闭包需要逃逸，以便于稍后调用。用我们最常用的网络请求举例来说：
enum RequestMethodType {
    case GET
    case POST
}
// 这里的completed闭包被作为一个参数传递给request函数，并且在函数调用get或post后才会被调用。
func request(methodType: RequestMethodType, urlString: String, parameters: [String : AnyObject], completed: @escaping (AnyObject?, NSError?)-> ()) {
    let successCallBack = { (task : URLSessionDataTask?, result : Any?) -> Void in
        completed(result as AnyObject?, nil)
    }
    let failureCallBack = { (task : URLSessionDataTask?, error : Error?) -> Void in
        completed(nil, error as NSError?)
    }
    if methodType == .GET {
        // to do network request
        //get(urlString, parameters: parameters, success: successCallBack, failure: failureCallBack)
    } else {
        // to do network request
        //post(urlString, parameters: parameters, success: successCallBack, failure: failureCallBack)
    }
}


// 完整写法
let say:(String) -> Void = {
    (name: String) -> Void in
    print("hi \(name)")
}
say("lnj")


// 没有返回值写法
let say2:(String) ->Void = {
    (name: String) in
    print("hi \(name)")
}
say2("lnj")


// 没有参数没有返回值写法
let say3:() ->Void = {
    print("hi lnj")
}
say3()


/*
闭包表达式作为回调函数
*/
func showArray(array:[Int])
{
    for number in array
    {
        print("\(number), ")
    }
}
/*
// 缺点, 不一定是小到大, 不一定是全部比较, 有可能只比较个位数
// 所以, 如何比较可以交给调用者决定
func bubbleSort(inout array:[Int])
{
    let count = array.count;
    for var i = 1; i < count; i++
    {
        for var j = 0; j < (count - i); j++
        {
            if array[j] > array[j + 1]
            {
                let temp = array[j]
                array[j] = array[j + 1]
                array[j + 1] = temp
            }
        }
    }
}
*/

let cmp = {
    (a: Int, b: Int) -> Int in
    if a > b{
        return 1;
    }else if a < b
    {
        return -1;
    }else
    {
        return 0;
    }
}

func bubbleSort( array:inout [Int], cmp: (Int, Int) -> Int)
{
    let count = array.count;
//    for var i = 1; i < count; i = i+ 1
//    {
//        for var j = 0; j < (count - i); j = j + 1
//        {
//            if cmp(array[j], array[j + 1]) == -1
//            {
//                let temp = array[j]
//                array[j] = array[j + 1]
//                array[j + 1] = temp
//            }
//        }
//    }
}

var arr:Array<Int> = [31, 13, 52, 84, 5]
bubbleSort(array: &arr, cmp: cmp)
showArray(array: arr)


// 闭包作为参数传递
bubbleSort(array: &arr, cmp: {
    (a: Int, b: Int) -> Int in
    if a > b{
        return 1;
    }else if a < b
    {
        return -1;
    }else
    {
        return 0;
    }
})
print("---------------")
showArray(array: arr)


// 如果闭包是最后一个参数, 可以直接将闭包写到参数列表后面, 这样可以提高阅读性. 称之为尾随闭包
bubbleSort(array: &arr) {
    (a: Int, b: Int) -> Int in
    if a > b{
        return 1;
    } else if a < b {
        return -1;
    } else {
        return 0;
    }
}


// 闭包表达式优化,
// 1.类型优化, 由于函数中已经声明了闭包参数的类型, 所以传入的实参可以不用写类型
// 2.返回值优化, 同理由于函数中已经声明了闭包的返回值类型,所以传入的实参可以不用写类型
// 3.参数优化, swift可以使用$索引的方式来访问闭包的参数, 默认从0开始
bubbleSort(array: &arr){
//    (a , b) -> Int in
//    (a , b) in
    if $0 > $1{
        return 1;
    }else if $0 < $1
    {
        return -1;
    }else
    {
        return 0;
    }
}


// 如果只有一条语句可以省略return
let hehe = {
    "我是lnj"
}
print(hehe())
