//
//  FFBasicSupernatant.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/9/15.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFBasicSupernatant.h"

@interface FFBasicSupernatant ()

@end

@implementation FFBasicSupernatant

- (void)ff_initWithViewModel:(id)viewModel {
    self.viewModel = viewModel;
}

- (void)ff_addSubViewAndConstraints {
    [super ff_addSubViewAndConstraints];
    [self addSubview:self.bgView];
    [self.bgView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (void)ff_showSupernatantView {
    if (self.viewModel.type == SupernatantShowTypeWindow) {
        self.viewModel.sourceView = [UIApplication sharedApplication].keyWindow;
    }
    
    //显示到指定视图上
    [self.viewModel.sourceView addSubview:self];
    [self makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.viewModel.sourceView);
    }];
    
    //引用计数
    self.refcount++;
    
    //动画
    self.alpha = 0;
    [UIView animateWithDuration:kFFAnimationDuration animations:^{
        self.alpha = 1;
    }];
}

- (void)ff_hideSupernatantView {
    self.refcount--;
    if (self.refcount==0) {
        [UIView animateWithDuration:kFFAnimationDuration animations:^{
            self.alpha = 0;
        }completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
}

#pragma mark- get
- (FFExtendView *)bgView {
    if (!_bgView) {
        _bgView = [FFExtendView new];
        _bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4f];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        @weakify(self);
        [[tap rac_gestureSignal] subscribeNext:^(id x) {
            @strongify(self);
            !self.viewModel.bgClickedBlock?:self.viewModel.bgClickedBlock();
        }];
        [_bgView addGestureRecognizer:tap];
    }
    return _bgView;
}

@end
