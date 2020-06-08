//
//  CYTLogisticsNeedDetailBottomView.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/5/17.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendView.h"
#import "FFOtherView_1.h"

@interface CYTLogisticsNeedDetailBottomView : FFExtendView

@property (nonatomic, strong) FFOtherView_1 *serviceView;
@property (nonatomic, strong) UIButton *rightButton;

@property (nonatomic, copy) void (^serviceBlock) (void);
@property (nonatomic, copy) void (^rightActionBlock) (void);


@end
