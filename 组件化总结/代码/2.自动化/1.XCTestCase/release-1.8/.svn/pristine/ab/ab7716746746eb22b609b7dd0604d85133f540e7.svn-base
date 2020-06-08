//
//  CYTGetCashPwdInputView.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/3/23.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTGetCashPwdInputView.h"

@implementation CYTGetCashPwdInputView


- (void)ff_addSubViewAndConstraints {
    [self addSubview:self.backImageView];
    [self addSubview:self.alertView];
    [self.alertView radius:7 borderWidth:1 borderColor:[UIColor clearColor]];
    
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [self.alertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self).offset(-100);
        make.size.equalTo(CGSizeMake(CYTAutoLayoutH(520), CYTAutoLayoutH(410)));
    }];
}

#pragma mark- set
- (void)setCashWillGet:(NSString *)cashWillGet {
    _cashWillGet = cashWillGet;
    self.alertView.cashWillGet = cashWillGet;
}

- (void)setError:(NSString *)error {
    _error = error;
    self.alertView.error = error;
}

- (void)showInView:(UIView *)view {
    extern NSString *CYTKeyboardSwitchNot;
    [[NSNotificationCenter defaultCenter] postNotificationName:CYTKeyboardSwitchNot object:@(YES)];
    
    [view addSubview:self];
    [self makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(view);
    }];
    self.alpha = 0.3;
    [self layoutIfNeeded];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 1;
    }completion:^(BOOL finished) {
        [self.alertView.inputView.textField becomeFirstResponder];
        
    }];
}

#pragma mark- get
- (UIImageView *)backImageView {
    if (!_backImageView) {
        _backImageView = [UIImageView new];
        _backImageView.image = [UIImage imageWithColor:[[UIColor blackColor] colorWithAlphaComponent:0.4]];
    }
    return _backImageView;
}

- (CYTGetCashPwdInputAlertView *)alertView {
    if (!_alertView) {
        _alertView = [CYTGetCashPwdInputAlertView new];
        @weakify(self);
        [_alertView setCancelBlock:^{
            @strongify(self);
            extern NSString *CYTKeyboardSwitchNot;
            [[NSNotificationCenter defaultCenter] postNotificationName:CYTKeyboardSwitchNot object:@(NO)];
            [UIView animateWithDuration:0.1 animations:^{
                self.alpha = 0;
            }completion:^(BOOL finished) {
                [self removeFromSuperview];
                if (self.cancelBlock) {
                    self.cancelBlock();
                }
            }];
        }];
        
        [_alertView setFinishedBlock:^(NSString *pwd) {
            @strongify(self);
            if (self.finishedBlock) {
                self.finishedBlock(pwd);
            }
        }];
    }
    return _alertView;
}

@end
