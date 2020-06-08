//
//  CYTGetCashPwdInputView.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/3/23.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendView.h"
#import "CYTGetCashPwdInputAlertView.h"

@interface CYTGetCashPwdInputView : FFExtendView
@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) CYTGetCashPwdInputAlertView *alertView;

@property (nonatomic, copy) void (^cancelBlock) (void);
@property (nonatomic, copy) void (^finishedBlock) (NSString *pwd);

///将要获取的金额数量
@property (nonatomic, copy) NSString *cashWillGet;
///错误信息
@property (nonatomic, copy) NSString *error;

- (void)showInView:(UIView *)view;

@end
