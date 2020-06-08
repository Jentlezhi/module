//
//  FFBasicSegmentItemView.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/8/1.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendView.h"
#import "FFBubbleView.h"

@interface FFBasicSegmentItemView : FFExtendView
@property (nonatomic, strong) UIButton *titleButton;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) FFBubbleView *bubbleView;
@property (nonatomic, assign) float bubbleWidth;
@property (nonatomic, strong) UIView *vline;
@property (nonatomic, copy) void (^selectBlock) (void);

@end
