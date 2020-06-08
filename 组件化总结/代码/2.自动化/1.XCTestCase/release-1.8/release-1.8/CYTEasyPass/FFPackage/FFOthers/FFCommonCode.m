//
//  FFCommonCode.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/4/21.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFCommonCode.h"

@implementation FFCommonCode

+ (NSComparisonResult)compareDecimalValue1:(float)value1 andValue2:(float)value2 {
    NSString *str1 = [NSString stringWithFormat:@"%f",value1];
    NSString *str2 = [NSString stringWithFormat:@"%f",value2];
    NSDecimalNumber *decimal1 = [NSDecimalNumber decimalNumberWithString:str1];
    NSDecimalNumber *decimal2 = [NSDecimalNumber decimalNumberWithString:str2];
    return [decimal1 compare:decimal2];
}

#pragma mark- NSUserDefaults
+ (void)setValue:(id)value forKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (id)valueForKey:(NSString *)key {
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

+ (UIViewController*)topViewController {
    return [self topViewControllerWithRootViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}

+ (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController {
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        
        UITabBarController* tabBarController = (UITabBarController*)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        
        UINavigationController* navigationController = (UINavigationController*)rootViewController;
        return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
    } else if (rootViewController.presentedViewController) {
        
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
    } else {

        return rootViewController;
    }
}

+ (NSString *)stringFromValue:(double)value pointNumber:(NSInteger)number{
    NSString *valueString;
    if(number==2){
        //保留小数点后x位有效数字
        valueString = [NSString stringWithFormat:@"%.2lf", value];
    }else if(number==4){
        //保留小数点后x位有效数字
        valueString = [NSString stringWithFormat:@"%.4lf", value];
    }else {
        //不做处理
        valueString = [NSString stringWithFormat:@"%lf", value];
    }
    NSDecimalNumber *num1 = [NSDecimalNumber decimalNumberWithString:valueString];
    return [num1 stringValue];
}

#pragma mark- pop
+ (void)navigation:(UINavigationController *)navigation popControllerWithLevel:(NSInteger)level {
    NSInteger index = navigation.viewControllers.count-1;
    index = index-level;
    index = (index>0)?index:0;
    UIViewController *theController = navigation.viewControllers[index];
    [navigation popToViewController:theController animated:YES];
}

+ (void)navigation:(UINavigationController *)navigation popControllerWithClassName:(NSString *)className {
    NSUInteger index = 0;
    for (UIViewController *subViewController in navigation.viewControllers) {
        if ([subViewController isKindOfClass:NSClassFromString(className)]) {
            index = [navigation.viewControllers indexOfObject:subViewController];
        }
    }
    UIViewController *theController = navigation.viewControllers[index];
    [navigation popToViewController:theController animated:YES];
}

@end
