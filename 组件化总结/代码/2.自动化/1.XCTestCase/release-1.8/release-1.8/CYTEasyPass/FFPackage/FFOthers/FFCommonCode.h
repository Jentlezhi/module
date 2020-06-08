//
//  FFCommonCode.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/4/21.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FFCommonCode : NSObject
///比较两个数的大小
+ (NSComparisonResult)compareDecimalValue1:(float)value1 andValue2:(float)value2;

///加入NSUserDefault
+ (void)setValue:(id)value forKey:(NSString *)key;
///从NSUserDefault中读取
+ (id)valueForKey:(NSString *)key;
///获取最顶部控制器
+ (UIViewController*)topViewController;
///把数值转换成字符串（不使用科学计数法）
+ (NSString *)stringFromValue:(double)value pointNumber:(NSInteger)number;
///导航控制器跳转，levle：返回的层级数量，上一级level=1，以此类推
+ (void)navigation:(UINavigationController *)navigation popControllerWithLevel:(NSInteger)level;
///导航控制器跳转，className：将要转入的控制器类名
+ (void)navigation:(UINavigationController *)navigation popControllerWithClassName:(NSString *)className;

@end
