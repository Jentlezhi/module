//
//  CarFilterConditionView.h
//  CYTEasyPass
//
//  Created by xujunquan on 2017/10/12.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFConditionView.h"
#import "CarFilterConditionTableView.h"
#import "CarFilterConditionVM.h"
#import "CarFilterConditionTableVM.h"

@interface CarFilterConditionView : FFConditionView
@property (nonatomic, strong) CarFilterConditionVM *viewModel;
@property (nonatomic, copy) void (^conditionViewExtendBlock) (BOOL isExtend);
///更改segment的item样式
- (void)updateSegmentTitleWithModel:(id)model andSeriesModel:(CarFilterConditionSubbrand_seriesModel *)seriesModel andType:(CarFilterConditionTableType)type;
///更新视图高度
- (void)updateSingleSeriesHeight:(float)height;

@end
