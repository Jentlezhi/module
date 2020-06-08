//
//  CYTCarSourceListFrequentlyBrandView.h
//  CYTEasyPass
//
//  Created by xujunquan on 2017/10/16.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendView.h"
#import "FFSectionHeadView_style0.h"
#import "CYTCarSourceListFrequentlyBrandVM.h"

@interface CYTCarSourceListFrequentlyBrandView : FFExtendView
@property (nonatomic, strong) CYTCarSourceListFrequentlyBrandVM *viewModel;
@property (nonatomic, strong) FFSectionHeadView_style0 *headView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *contentView;

///点击品牌
@property (nonatomic, copy) ffIDBlock brandModelBlock;
///品牌筛选
@property (nonatomic, copy) ffDefaultBlock brandFilterBlock;

///刷新
- (void)reloadBrandView;

@end
