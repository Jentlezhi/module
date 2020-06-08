//
//  CYTToast.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/4/25.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYTToastConfig.h"

@interface CYTToast : UIView

+ (instancetype)sharedToast;
/**
 * 文字提示
 */
+ (void)messageToastWithMessage:(NSString *)message;
+ (void)messageToastWithMessage:(NSString *)message completion:(void(^)())completionBlock;
/**
 *  成功操作提示
 */
+ (void)successToastWithMessage:(NSString *)message;
+ (void)successToastWithMessage:(NSString *)message completion:(void(^)())completionBlock;
/**
 * 错误操作提示
 */
+ (void)errorToastWithMessage:(NSString *)message;
+ (void)errorToastWithMessage:(NSString *)message completion:(void(^)())completionBlock;
/**
 * 警告操作提示
 */
+ (void)warningToastWithMessage:(NSString *)message;
+ (void)warningToastWithMessage:(NSString *)message completion:(void(^)())completionBlock;
/**
 * 自定义提示
 */
+ (void)toastWithType:(CYTToastType)toastType message:(NSString *)message;
+ (void)toastWithType:(CYTToastType)toastType message:(NSString *)message completion:(void(^)())dismissBlock;
/**
 * 自定义提示（自定义键盘的情况）
 */
+ (void)customKeyboardToastWithType:(CYTToastType)toastType message:(NSString *)message;
/**
 * 自定义提示（自定义键盘的情况）
 */
+ (void)toastWithType:(CYTToastType)toastType message:(NSString *)message handelCustonKayboard:(BOOL)handelKayboard;


@end
