//
//  CYTDealerCommentPublishView.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/8/3.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTDealerCommentPublishView.h"

@interface CYTDealerCommentPublishView ()
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) CYTDealerCommentPublishContentView *contentView;
@property (nonatomic, assign) BOOL showing;

@end

@implementation CYTDealerCommentPublishView

- (void)ff_initWithViewModel:(id)viewModel {
    [super ff_initWithViewModel:viewModel];
    self.viewModel = viewModel;
}

- (void)ff_addSubViewAndConstraints {
    [super ff_addSubViewAndConstraints];
    [self addSubview:self.bgView];
    [self addSubview:self.contentView];
    
    [self.bgView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.contentView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(0);
        make.height.equalTo(CYTAutoLayoutV(620));
    }];
}

- (void)showNow {
    NSArray *views = kTabbarCtr.view.subviews;
    for (UIView *obj in views) {
        if ([obj isKindOfClass:[CYTDealerCommentPublishView class]]) {
            [obj removeFromSuperview];
        }
    }
    
    self.contentView.textView.placeholder = @"请输入评价内容（0-200字）";
    self.contentView.textView.placeholderColor = kFFColor_title_gray;
    self.contentView.textView.textColor = kFFColor_title_L2;
    
    [kTabbarCtr.view addSubview:self];
    [self makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(kTabbarCtr.view);
    }];
    
    //动画
    self.alpha = 0;
    [UIView animateWithDuration:kAnimationDurationInterval animations:^{
        self.alpha = 1;
    }completion:^(BOOL finished) {
        self.showing = YES;
    }];
}

- (void)hide {
    if (self.superview) {
        [UIView animateWithDuration:kAnimationDurationInterval animations:^{
            self.alpha = 0.1;
        }completion:^(BOOL finished) {
            [self removeFromSuperview];
            self.showing = NO;
        }];
    }
}

- (void)config {
    //暂时不要优化
    //NONE
}

#pragma mark - 键盘处理
- (void)ff_keyboardWillShow:(NSNotification *)notification {
    if (!_showing) {
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        // 取出键盘最终的frame
        CGRect rect = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        // 取出键盘弹出需要花费的时间
        double duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        // 修改约束
        [self.contentView updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(-rect.size.height);
        }];
        
        [UIView animateWithDuration:duration animations:^{
            [self.superview layoutIfNeeded];
        }];
    });
}

- (void)ff_keyboardWillHide:(NSNotification *)notification {
    if (!self.showing) {
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        // 取出键盘弹出需要花费的时间
        double duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        // 修改约束
        [self.contentView updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(0);
        }];
        
        [UIView animateWithDuration:duration animations:^{
            [self.superview layoutIfNeeded];
        }];
    });
}

#pragma mark- set
- (void)setTitle:(NSString *)title {
    _title = title;
    self.contentView.titleLabel.text = title;
}

#pragma mark- get
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [UIView new];
        _bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4f];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        [[tap rac_gestureSignal] subscribeNext:^(id x) {
            [self hide];
        }];
        [_bgView addGestureRecognizer:tap];
    }
    return _bgView;
}

- (CYTDealerCommentPublishContentView *)contentView {
    if (!_contentView) {
        _contentView = [[CYTDealerCommentPublishContentView alloc] initWithViewModel:self.viewModel];
        
        @weakify(self);
        [_contentView setCancelBlock:^{
            @strongify(self);
            [self hide];
        }];
        [_contentView setPublishBlock:^(CYTDealerCommentPublishVM *model) {
            @strongify(self);
            [self hide];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kAnimationDurationInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                //发布评论
                [self.viewModel.requestCommand execute:nil];
            });
            
        }];
    }
    return _contentView;
}


@end
