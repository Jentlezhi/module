//
//  CYTNoDataView.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/5/9.
//  Copyright © 2017年 EasyPass. All rights reserved.
//
/*
 self.noDataView.content = @"抱歉，该订单未使用平台物流\n- 暂无实时状态 -";
 self.noDataView.imageName = @"bg_manage_dl";
 [self showNoDataView];
 */

#import <UIKit/UIKit.h>

@interface CYTNoDataView : UIView

/** 首页特殊布局 */
@property(assign, nonatomic) BOOL homeLayout;
/** 文字 */
@property(copy, nonatomic) NSString *content;
/** 无数据图片 */
@property(weak, nonatomic) UIImageView *noDataImageView;
/** 无数据图片名字 */
@property(copy, nonatomic) NSString *imageName;

@end
