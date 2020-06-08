//
//  CYTAddressChooseHeaderView.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/6/8.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendView.h"

@interface CYTAddressChooseHeaderView : FFExtendView
@property (nonatomic, strong) FFSectionHeadView_style0 *areaHeader;
@property (nonatomic, strong) FFSectionHeadView_style0 *cityHeader;
@property (nonatomic, strong) UIView *areaView;
///是否需要显示大区
@property (nonatomic, assign) BOOL needArea;
///index
@property (nonatomic, assign) NSInteger index;

///点击事件  0-index  1-区id
@property (nonatomic, copy) void (^areaBlock) (NSInteger,NSInteger);
@property (nonatomic, copy) void (^reaviewBlock) (void);

@end
