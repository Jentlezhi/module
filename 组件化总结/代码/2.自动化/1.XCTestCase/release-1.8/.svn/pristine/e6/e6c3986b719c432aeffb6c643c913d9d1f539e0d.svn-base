//
//  CYTShareActionView.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/4/6.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendView.h"
#import "CYTShareBottomView.h"

@interface CYTShareActionView : FFExtendView
///-1 取消，0好友，1朋友圈，2链接
@property (nonatomic, copy) void (^clickedBlock) (NSInteger tag);
@property (nonatomic, assign) ShareViewType type;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) CYTShareBottomView *shareView;
///显示分享view
- (void)showWithSuperView:(UIView *)superView;
///隐藏分享view
- (void)dismissWithAnimation:(BOOL)animation;



@end
