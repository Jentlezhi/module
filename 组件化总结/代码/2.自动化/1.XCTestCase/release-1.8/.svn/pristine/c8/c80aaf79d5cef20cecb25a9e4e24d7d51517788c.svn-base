//
//  CYTAlertView.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/4/24.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYTAlertView.h"

@interface CYTAlertView : UIView

+ (void)alertViewWithMessage:(NSString *)msg confirmAction:(void(^)())confirmAction;

+ (void)alertViewWithTitle:(NSString *)title message:(NSString *)msg confirmAction:(void(^)())confirmAction;

+ (instancetype)alertViewWithTitle:(NSString *)title message:(NSString *)msg confirmTitle:(NSString *)confirmTitle confirmAction:(void (^)())confirmAction signalButton:(BOOL)showSignalBtn autoDismiss:(BOOL)autoDismiss;
+ (instancetype)alertViewWithTitle:(NSString *)title message:(NSString *)msg confirmTitle:(NSString *)confirmTitle confirmAction:(void (^)())confirmAction cancelAction:(void (^)())cancelAction signalButton:(BOOL)showSignalBtn autoDismiss:(BOOL)autoDismiss;
/**
 * 单个按钮
 */
+ (void)singleButtonWithMessage:(NSString *)msg buttonTitle:(NSString *)title confirmAction:(void(^)())confirmAction autoDismiss:(BOOL)autoDismiss;
/**
 * 自定义view
 */
+ (instancetype)alertViewWithTitle:(NSString *)title confirmTitle:(NSString *)confirmTitle customView:(UIView *)customView confirmAction:(void(^)(UIView *))confirmAction;

/**
 *  系统Alert 提示
 */
+ (void)alertTipWithTitle:(NSString *)title message:(NSString *)message confiemAction:(void(^_Nullable)(UIAlertAction *action))confiemAction;
/**
 *  系统Alert
 */
+ (void)alertViewWithTitle:(NSString *_Nullable)title message:(NSString *_Nullable)msg confirmAction:(void (^_Nullable)())confirmAction cancelAction:(void (^_Nullable)())cancelAction;
/**
 *  系统ActionSheet
 */
+ (void)actionSheetWithTitle:(NSString *_Nullable)title confirmAction:(void (^_Nullable)())confirmAction cancelAction:(void (^_Nullable)())cancelAction;
/**
 *  系统图片选择
 */
+ (void)selectPhotoAlertWithTakePhoto:(void(^_Nullable)(UIAlertAction * _Nullable action))takePhotoAction album:(void(^_Nullable)(UIAlertAction * _Nullable action))albumAction;

@end
