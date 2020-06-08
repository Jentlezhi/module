//
//  CYTShareActionView.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/4/6.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTShareActionView.h"

#define kAnimateDuration    (0.25)

@implementation CYTShareActionView

- (void)ff_initWithViewModel:(id)viewModel {
    self.type = [viewModel integerValue];
}

- (void)setType:(ShareViewType)type {
    _type = type;

    self.shareView.type = type;
}

- (void)ff_addSubViewAndConstraints {
    [self addSubview:self.backView];
    [self addSubview:self.shareView];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [self.shareView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.bottom);
        make.height.equalTo(CYTAutoLayoutV(454));
    }];
}

- (void)showWithSuperView:(UIView *)superView {
    [kWindow addSubview:self];
    self.backView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.01f];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        self.backView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4f];
        make.edges.equalTo(0);
    }];
    [self layoutIfNeeded];
    
    float topY = kScreenHeight - CYTAutoLayoutV(454);
    [self.shareView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topY);
    }];
    [UIView animateWithDuration:kAnimateDuration animations:^{
        [self layoutIfNeeded];
    }];
}

#pragma mark- get
- (UIView *)backView {
    if (!_backView) {
        _backView = [UIView new];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        [[tap rac_gestureSignal] subscribeNext:^(id x) {
            [self dismissWithAnimation:YES];
        }];
        [_backView addGestureRecognizer:tap];
    }
    return _backView;
}

- (CYTShareBottomView *)shareView {
    if (!_shareView) {
        _shareView = [CYTShareBottomView new];
        @weakify(self);
        [_shareView setClickedBlock:^(NSInteger tag) {
            @strongify(self);
            if (tag==-1) {
                //取消操作
                [self dismissWithAnimation:YES];
                return ;
            }else {
                //其他分享
                if (self.clickedBlock) {
                    self.clickedBlock(tag);
                }
                [self dismissWithAnimation:YES];
            }
        }];
    }
    return _shareView;
}
/**
 * 消失动画
 */
- (void)dismissWithAnimation:(BOOL)animation{
    if (!animation) {
        [self removeFromSuperview];
        return;
    }
    CGRect rect = self.frame;
    rect.origin.y = CGRectGetMaxY(rect);
    [UIView animateWithDuration:kAnimateDuration animations:^{
        self.shareView.frame = rect;
        self.alpha = 0.01f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
