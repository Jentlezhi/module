//
//  CYTSetPwdView.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/3.
//  Copyright © 2017年 EasyPass. All rights reserved.
//  设置密码视图

#import <UIKit/UIKit.h>

@class CYTUsersInfoModel;

@interface CYTSetPwdView : UIView
/** 调起键盘 */
@property(assign, nonatomic) BOOL showKeyboard;
/** 下一步操作回调 */
@property(copy, nonatomic) void(^setPwdNextStep)(CYTNetworkResponse *responseObject);
/** 已注册账号 */
@property(copy, nonatomic) NSString *registerPhoneNum;

@end
