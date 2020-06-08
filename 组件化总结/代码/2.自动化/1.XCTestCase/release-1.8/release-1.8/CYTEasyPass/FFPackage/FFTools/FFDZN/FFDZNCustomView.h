//
//  CGDZNCustomView.h
//  Pcms
//
//  Created by xujunquan on 16/10/20.
//  Copyright © 2016年 cig. All rights reserved.
//
/*
 1、集成在FFMainView中使用,无需任何代码即可使用。
 使用默认的loading、empty、reload页面,页面可以进行自定义文字图片，也可以完全自定义。
 点击“重新加载”会重新请求接口。

 2、自定义dzn页面
 //设置网络异常样式
 CYTCommonNetErrorView *reloadView = [[CYTCommonNetErrorView alloc] init];
 reloadView.bottomSpace = 0;
 reloadView.topSpace = 0;
 reloadView.contentText = @"Sorry 网络出现问题了";
 reloadView.contentSubText = @"- 请稍后再试吧 -";
 reloadView.contentImage = @"dzn_netError_2";
 mainView.dznCustomView.reloadView = reloadView;
 
 //设置空数据样式
 mainView.dznCustomView.emptyView.contentText = @"- 暂时没有您要的数据 -";
 mainView.dznCustomView.emptyView.contentImage = @"dzn_empty_2";
 */

#import "FFExtendView.h"
#import "FFDZNEmptyView.h"
#import "FFDZNLoadingView.h"
#import "FFDZNReloadView.h"

typedef NS_ENUM(NSInteger,DZNViewType) {
    DZNViewTypeEmpty = 0,
    DZNViewTypeReload,
    DZNViewTypeLoading
};

@interface FFDZNCustomView : FFExtendView
@property (nonatomic, strong) FFDZNLoadingView *loadingView;
@property (nonatomic, strong) FFDZNEmptyView *emptyView;
@property (nonatomic, strong) FFDZNReloadView *reloadView;
///设置dznView显示样式
@property (nonatomic ,assign) DZNViewType type;

@end
