//
//  CYTGetCashPwdInputAlertView.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/3/23.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendView.h"
#import "CYTCommonPwdInputView.h"

@interface CYTGetCashPwdInputAlertView : FFExtendView

@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) UILabel *flagLabel;
@property (nonatomic, strong) UILabel *cashLabel;
@property (nonatomic, strong) UILabel *desLabel;

@property (nonatomic, strong) CYTCommonPwdInputView *inputView;
@property (nonatomic, strong) UILabel *alertLabel;

@property (nonatomic, copy) void (^cancelBlock) (void);
@property (nonatomic, copy) void (^finishedBlock) (NSString *pwd);

@property (nonatomic, copy) NSString *cashWillGet;
@property (nonatomic, copy) NSString *error;

@end
