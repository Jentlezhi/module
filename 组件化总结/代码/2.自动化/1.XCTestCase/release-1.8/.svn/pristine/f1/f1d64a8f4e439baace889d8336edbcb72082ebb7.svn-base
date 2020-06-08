//
//  LogisticsHomeHeadView.h
//  CYTEasyPass
//
//  Created by xujunquan on 2017/10/9.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendView.h"
#import "SDCycleScrollView.h"
#import "LogisticsHomeHeadItem.h"

@interface LogisticsHomeHeadView : FFExtendView<SDCycleScrollViewDelegate>
@property (nonatomic, strong) SDCycleScrollView *bannerView;
@property (nonatomic, strong) LogisticsHomeHeadItem *publishView;
@property (nonatomic, strong) LogisticsHomeHeadItem *needView;
@property (nonatomic, strong) LogisticsHomeHeadItem *orderView;

///点击banner
@property (nonatomic, copy) void (^bannerBlock) (NSInteger index);
@property (nonatomic, copy) void (^clickedBlock) (NSInteger index);

@end
