//
//  CYTUnbindView.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/2.
//  Copyright © 2017年 EasyPass. All rights reserved.
//  用户注册未绑定视图

#import <UIKit/UIKit.h>

@interface CYTUnbindView : UIView


/** 注册手机号 */
@property(copy, nonatomic) NSString *registerPhoneNum;
/** 调起键盘 */
@property(assign, nonatomic) BOOL showKeyboard;
/** 下一步按钮的回调 */
@property(copy, nonatomic) void(^nextStepClick)(CYTUserStatus,NSString *);
/** 注册协议的回调 */
@property(copy, nonatomic) void(^userProtocolClick)();

@end
