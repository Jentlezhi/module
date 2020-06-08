//
//  CYTLogisticsProtocalView.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/5/15.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendView.h"
#import "UIButton+FFCommon.h"

@interface CYTLogisticsProtocalView : FFExtendView
@property (nonatomic, strong) UIButton *checkButton;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, assign) BOOL select;

@property (nonatomic, copy) void (^selectBlock) (BOOL);
@property (nonatomic, copy) void (^agreeProtocalBlock) (void);


@end
