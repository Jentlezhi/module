//
//  FFSideSlideContentView.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/5/31.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendView.h"
#import "FFSideSlideContentBasicController.h"

@interface FFSideSlideContentView : FFExtendView
@property (nonatomic, assign) BOOL showing;
///顶部偏移量,默认=CYTViewOriginY
@property (nonatomic, assign) float topOffset;
///侧边栏宽度，默认为kScreenWidth*2/3.0
@property (nonatomic, assign) float viewWidth;
///侧边栏内容控制器
@property (nonatomic, strong) FFSideSlideContentBasicController *contentController;
///点击背景隐藏时的回调闭包
@property (nonatomic, copy) void (^willDismissBlock) (void);

///显示侧边栏
- (void)showHalfView;
///隐藏侧边栏
- (void)hideHalfView;

@end
