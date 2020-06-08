//
//  CYTEasyPassUITests.m
//  CYTEasyPassUITests
//
//  Created by Jentle on 2017/12/23.
//  Copyright © 2017年 EasyPass. All rights reserved.
//
/*
 查找元素 - XCUIElementQuery
 这是一个非常重要的类用于查找元素。也是在UI测试中用的最多的一个。通过它可以来找到界面中的所有元素，这个和html里面的DOM很相似。查找的方式有很多，可以通过顺序来查找，也可以通过特征来查找。甚至可以通过NSPredicate。所以查找的功能非常强大。
 元素 - XCUIElement
 从文档中可以看出这个是包装UI中的组件用于动态的定位界面中的元素。
 通过XCUIElementQuery我们可以精确的定位到每一个组件，拿到了元素以后我们就可以对它进行一些操作，比如在iOS下我们可以进行tap,pressForDuration:, swipeUp, twoFingerTap等操作，另外在OS X上还可以有click操作。


 */

#import <XCTest/XCTest.h>

@interface CYTEasyPassUITests : XCTestCase

/** 当前app */
@property(strong, nonatomic) XCUIApplication *app;

@end



@implementation CYTEasyPassUITests

- (XCUIApplication *)app{
    if (!_app) {
        _app = [[XCUIApplication alloc] init];
    }
    return _app;
}

//在每个单元测试方法执行之前，XCTest会先执行setUp方法
- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    XCUIApplication *app = [[XCUIApplication alloc] init];
//    //关闭应用
//    [app terminate];
//    //重新启动引用
    [app launch];
}

//规范：必须以test开头
- (void)testAdd{
    NSInteger result = [self addNum1:1 andNum2:1];
    XCTAssertEqual(result, 2);
}


- (NSInteger)addNum1:(NSInteger)num1 andNum2:(NSInteger)num2{
    return num1 + num2;
}


#pragma mark - 退出登录

- (void)testLogOut{
    //update_cancel
    XCUIElementQuery *tabBarsQuery = self.app.tabBars;
    XCUIElement *tableBarButton = tabBarsQuery.buttons[@"我"];
    !tableBarButton?:[tableBarButton tap];
    XCUIElement *settingBtn = self.app.buttons[@"设置"];
    !settingBtn?:[settingBtn tap];
    XCUIElementQuery *tablesQuery = self.app.tables;
    XCUIElement *logOutBtn = tablesQuery.staticTexts[@"退出登录"];
    !logOutBtn?:[logOutBtn tap];
    [self alertViewTap];
    sleep(3);
    !tableBarButton?:[tableBarButton tap];
}


#pragma mark - 登录

- (void)testLogin{
    XCUIElementQuery *tabBarsQuery = self.app.tabBars;
    XCUIElement *tableBarButton = tabBarsQuery.buttons[@"我"];
    !tableBarButton?:[tableBarButton tap];

    XCUIElement *accountTextField = self.app.textFields[@"请输入手机号"];
    !accountTextField.exists?:[accountTextField tap];
    [accountTextField typeText:@"13121782105"];

    [self hindKeyBoard];

    XCUIElement *pwdTextField = self.app.secureTextFields[@"请输入密码"];
    !pwdTextField.exists?:[pwdTextField tap];
    //输入密码
    !pwdTextField.exists?:[pwdTextField typeText:@"zjt123"];

    [self hindKeyBoard];

    XCUIElement *loginButton = self.app.buttons[@"登录"];
    !loginButton.exists?:[loginButton tap];

    sleep(3);

    !tableBarButton?:[tableBarButton tap];


}

- (void)alertViewTap{
    sleep(0.5);
    XCUIElement *alertView = [self.app.alerts elementBoundByIndex:0];
    XCUIElement *alertButton = alertView.buttons[@"确定"];
    !alertButton.exists?:[alertButton tap];
}

- (void)hindKeyBoard{
    XCUIElement *element = [[self.app childrenMatchingType:XCUIElementTypeWindow] elementBoundByIndex:0];
    [element tap];
}
//在每个单元测试方法执行完毕后，XCTest会执行tearDown方法
- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}
//性能测试
- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}


@end
