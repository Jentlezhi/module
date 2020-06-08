//
//  CYTLoginView.h
//  CYTEasyPass
//
//  Created by Juniort on 2017/3/5.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CYTUsersInfoModel;

@interface CYTAccountLoginView : UIView

/** 调起键盘 */
@property(assign, nonatomic) BOOL showKeyboard;
/** 登录成功回调 */
@property(copy, nonatomic) void(^loginSuccess)(CYTNetworkResponse *response);
/** 忘记密码 */
@property(copy, nonatomic) void(^forgetPwd)();
/** 免费注册 */
@property(copy, nonatomic) void(^registerAccount)();

@end
