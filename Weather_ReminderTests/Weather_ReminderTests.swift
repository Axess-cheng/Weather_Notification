//
//  Weather_ReminderTests.swift
//  Weather_ReminderTests
//
//  Created by macbook on 2019/5/6.
//  Copyright © 2019 comp208.team4. All rights reserved.
//
//这里是单元测试可以测试你们的方法已经关联了我们的程序
//在需要被调用的class 加一个static的声明 以mapVC举例 static let share = mapVC()
//然后有静态声明的方法都可以直接调用，格式是class.share.func
//

import XCTest
@testable import Weather_Reminder

class Weather_ReminderTests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() {
        
        //        XCTFail(format…) 生成一个失败的测试；
        //
        //        XCTAssertNil(a1, format...)为空判断，a1为空时通过，反之不通过；
        //
        //        XCTAssertNotNil(a1, format…)不为空判断，a1不为空时通过，反之不通过；
        //
        //        XCTAssert(expression, format...)当expression求值为TRUE时通过；
        //
        //        XCTAssertTrue(expression, format...)当expression求值为TRUE时通过；
        //
        //        XCTAssertFalse(expression, format...)当expression求值为False时通过；
        //
        //        XCTAssertEqualObjects(a1, a2, format...)判断相等，[a1 isEqual:a2]值为TRUE时通过，其中一个不为空时，不通过；
        //
        //        XCTAssertNotEqualObjects(a1, a2, format...)判断不等，[a1 isEqual:a2]值为False时通过；
        //
        //        XCTAssertEqual(a1, a2, format...)判断相等（当a1和a2是 C语言标量、结构体或联合体时使用, 判断的是变量的地址，如果地址相同则返回TRUE，否则返回NO）；
        //
        //        XCTAssertNotEqual(a1, a2, format...)判断不等（当a1和a2是 C语言标量、结构体或联合体时使用）；
        //
        //        XCTAssertEqualWithAccuracy(a1, a2, accuracy, format...)判断相等，（double或float类型）提供一个误差范围，当在误差范围（+/-accuracy）以内相等时通过测试；
        //
        //        XCTAssertNotEqualWithAccuracy(a1, a2, accuracy, format...) 判断不等，（double或float类型）提供一个误差范围，当在误差范围以内不等时通过测试；
        //
        //        XCTAssertThrows(expression, format...)异常测试，当expression发生异常时通过；反之不通过；（很变态） XCTAssertThrowsSpecific(expression, specificException, format...) 异常测试，当expression发生specificException异常时通过；反之发生其他异常或不发生异常均不通过；
        //
        //        XCTAssertThrowsSpecificNamed(expression, specificException, exception_name, format...)异常测试，当expression发生具体异常、具体异常名称的异常时通过测试，反之不通过；
        //
        //        XCTAssertNoThrow(expression, format…)异常测试，当expression没有发生异常时通过测试；
        //
        //        XCTAssertNoThrowSpecific(expression, specificException, format...)异常测试，当expression没有发生具体异常、具体异常名称的异常时通过测试，反之不通过；
        //
        //        XCTAssertNoThrowSpecificNamed(expression, specificException, exception_name, format...)异常测试，当expression没有发生具体异常、具体异常名称的异常时通过测试，反之不通过
        
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        
    }
    
    func testLogin(){
        
    }
    
    
    func testUpLoad(){
        
    }
    
    
    func testDownload(){
        
    }
    
    func testMap(){
        
//        let email = "testst.com"
//        let password = "123456"
//
//        var resualt = false
//        resualt = LoginVC.shared.checkInput(email: email, passwd: password)
//
//        XCTAssert(resualt, "wrong in login")
        
        // both empty -> failed             "" --- ""
        // right account -> success         "test@test.com" --- "123"
        // wrong password -> failed         "test@test.com" --- "123q"
        // unmatch email -> failed            "axess971230@gmail.com" --- "123"
        // wrong email format -> failed
        // special char in password -> wrong!!!   "test@test.com" --- "!@£$%^&*~"
        // only 0-9, a-z, _
        // longgggg passwd -> failed
        //
        
        
//        let email = "test123@test.com"
//        let password = "!@£$%^&*()~/"
//        let resualt = SignUpVC.shared.checkInput(email: email, passwd: password)
//
//        XCTAssert(resualt, "wrong in login")
        
        // wrong email format -> failed         "test1st.com" --- "123456"
        // wrong pass format -> failed          "test123@test.com" --- "1"
        //                                                              "123456789012345123"
        //                                                              "123!@£$"
        // has signed acc -> failed             "test@test.com" --- "123" // set before add rules
        // special char -> failed               "test123@test.com" --- "!@£$%^&*()~/"
        // empty -> failed                      "" --- ""
        //
        
        
        
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
