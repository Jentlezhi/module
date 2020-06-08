//
//  CYTHomeSearchBarView.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/3/21.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendView.h"

@interface CYTHomeSearchBarView : FFExtendView
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *messageBorderView;
@property (nonatomic, strong) FFOtherView_1 *messageView;
@property (nonatomic, strong) UIImageView *bubbleView;
/** 半透明 */
@property(assign, nonatomic,getter=isTranslucence) BOOL translucence;

@property (nonatomic, copy) void (^searchBlock) (void);
@property (nonatomic, copy) void (^messageBlock) (void);

- (void)showBubbleView:(BOOL)show;

@end
