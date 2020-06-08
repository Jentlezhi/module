//
//  FFLabel_Type_WithRightView.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/4/24.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFLabel_Type_WithRightView.h"

@interface FFLabel_Type_WithRightView()
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIView *rightView;
@property (nonatomic, copy) NSString *keyWords;

@end

@implementation FFLabel_Type_WithRightView

- (void)initWithLabel:(UILabel *)label rightView:(UIView *)rightView {
    self.layer.masksToBounds = YES;
    self.label = label;
    self.rightView = rightView;
    
    [self addSubview:self.label];
    [self addSubview:self.rightView];
    
    [self.label makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self);
        make.right.equalTo(self.rightView.left).priorityHigh();
    }];
    [self.rightView makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(self).priorityHigh();
    }];
}

- (void)setShowRight:(BOOL)showRight {
    _showRight = showRight;
    
    self.rightView.hidden = !showRight;
    
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.label.text = title;
    if (!title || title.length == 0) {
        [self hideRightView];
    }else{
        [self showRightView];
    }
    
    
    if (!self.keyWords) {
        return;
    }else{
        if ([title isEqualToString:self.keyWords]) {
            [self hideRightView];
        }else{
            [self showRightView];
        }
    }
}

- (void)hideRightView {
    self.rightView.hidden = YES;
    [self.rightView remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(self).priorityHigh();
        make.width.equalTo(0).priorityHigh();
    }];
    
    [self.label updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
    }];
}

- (void)showRightView {
    self.rightView.hidden = NO;
    [self.rightView remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(self).priorityHigh();
    }];
    
    [self.label updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.rightView.left).priorityHigh();
    }];
}

- (void)hideRightIfTitleIs:(NSString *)string {
    _keyWords = string;
}

@end
