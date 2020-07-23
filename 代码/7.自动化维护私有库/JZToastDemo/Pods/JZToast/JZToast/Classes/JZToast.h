//
//  JZToast.h
//  JZToast
//
//  Created by Jentle on 2017/4/25.
//  Copyright © 2017年 EasyPass. All rights reserved.
//    

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    JZToastTypeDefault = 0,  //普通文字提示
    JZToastTypeSuccess,      //成功操作提示
    JZToastTypeError,        //错误操作提示
    JZToastTypeWarning       //警告操作提示
} JZToastType;

@interface JZTipLabel : UILabel

- (instancetype)initWithText:(NSString *)text;

- (instancetype)initWithText:(NSString *)text textEdgeInsets:(UIEdgeInsets)textInsets maxWidth:(CGFloat)maxWidth minWidth:(CGFloat)minWidth minHeight:(CGFloat)minHeight;

@end

@interface JZToast : UIView
/**
 * 文字提示
 */
+ (void)messageToastWithMessage:(NSString *)message;
+ (void)messageToastWithMessage:(NSString *)message
                     completion:(void(^)(void))completionBlock;
/**
 *  成功操作提示
 */
+ (void)successToastWithMessage:(NSString *)message;
+ (void)successToastWithMessage:(NSString *)message
                     completion:(void(^)(void))completionBlock;
/**
 * 错误操作提示
 */
+ (void)errorToastWithMessage:(NSString *)message;
+ (void)errorToastWithMessage:(NSString *)message
                   completion:(void(^)(void))completionBlock;
/**
 * 警告操作提示
 */
+ (void)warningToastWithMessage:(NSString *)message;
+ (void)warningToastWithMessage:(NSString *)message
                     completion:(void(^)(void))completionBlock;
/**
 * 自定义提示
 */
+ (void)toastWithType:(JZToastType)toastType
              message:(NSString *)message;
+ (void)toastWithType:(JZToastType)toastType
              message:(NSString *)message completion:(void(^)(void))dismissBlock;

///增加一个提示（需要保留文本输入框的第一响应者）
+ (void)errorToastKeepResponderWithMessage:(NSString *)message;

@end
