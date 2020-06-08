//
//  CYTCarSourcePriceInputView.m
//  CYTEasyPass
//
//  Created by xujunquan on 2017/11/17.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCarSourcePriceInputView.h"

@interface CYTCarSourcePriceInputView ()
@property (nonatomic, weak) UIView *supView;
@property (nonatomic, strong) UIView *bgView;

@end

@implementation CYTCarSourcePriceInputView

#pragma mark- flow control
- (void)ff_initWithViewModel:(id)viewModel {
    [super ff_initWithViewModel:viewModel];
}

- (void)ff_bindViewModel {
    [super ff_bindViewModel];
}

- (void)ff_addSubViewAndConstraints {
    [super ff_addSubViewAndConstraints];
    
    [self addSubview:self.inputView];
    [self.inputView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.bottom.equalTo(0);
        make.width.equalTo(kScreenWidth);
        make.height.equalTo(kInputViewHeight);
    }];
}

#pragma mark- api

#pragma mark- method
- (float)viewHeight {
    return kInputViewHeight;
}

- (void)showOnView:(UIView *)view {
    self.supView = view;
    
    [self.supView addSubview:self.bgView];
    [self.supView addSubview:self];
    
    [self.bgView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.supView);
    }];
    [self makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.supView);
        make.height.equalTo(kInputViewHeight);
        make.bottom.equalTo(self.supView).offset(kInputViewHeight);
    }];
    [self layoutIfNeeded];
}

#pragma mark - 键盘处理
- (void)ff_keyboardWillShow:(NSNotification *)notification {
    if (!self.effective) {
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        // 取出键盘最终的frame
        CGRect rect = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        // 取出键盘弹出需要花费的时间
        double duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        // 修改约束
        [self updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.supView).offset(-rect.size.height);
        }];
        [UIView animateWithDuration:duration animations:^{
            [self.supView layoutIfNeeded];
            self.bgView.alpha = 1;
        }];
    });
}

- (void)ff_keyboardWillHide:(NSNotification *)notification {
    if (!self.effective) {
        return;
    }
    [self hideSelf];
}

- (void)hideSelf {
    dispatch_async(dispatch_get_main_queue(), ^{
        // 取出键盘弹出需要花费的时间
        double duration = 0.2;
        // 修改约束
        [self updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.supView.bottom).offset(kInputViewHeight);
        }];
        [UIView animateWithDuration:duration animations:^{
            [self.supView layoutIfNeeded];
            self.bgView.alpha = 0;
        }];
    });
    
    [self.inputView.contentView.textFiled resignFirstResponder];
    [self.inputView.contentView clearMethod];
}

#pragma mark- set
- (void)setEffective:(BOOL)effective {
    _effective = effective;
    
    if (effective) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.inputView.contentView.textFiled becomeFirstResponder];
        });
    }
}

- (void)setGuidePrice:(NSString *)guidePrice {
    _guidePrice = guidePrice;
    self.inputView.guidePrice = guidePrice;
}

#pragma mark- get
- (CYTPriceInputView *)inputView {
    if (!_inputView) {
        _inputView = [[CYTPriceInputView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kInputViewHeight)];
        
        @weakify(self);
        [_inputView setCancelBlock:^{
            @strongify(self);
            [self hideSelf];
            if (self.cancelBlock) {
                self.cancelBlock();
            }
        }];
        
        [_inputView setAffirmBlock:^(NSInteger index, NSString *value, NSString *resultPrice) {
            @strongify(self);
            if (index == 3 && ([value isEqualToString:@""] || [value floatValue] == 0)) {
                [CYTToast messageToastWithMessage:@"报价不能为空"];
//                return ;
            }
            [self hideSelf];
            if (self.affirmBlock) {
                self.affirmBlock(index,value,resultPrice);
            }
        }];
    }
    return _inputView;
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [UIView new];
        _bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        UITapGestureRecognizer *tapGes = [UITapGestureRecognizer new];
        _bgView.alpha = 0;
        @weakify(self);
        [[tapGes rac_gestureSignal] subscribeNext:^(id x) {
            @strongify(self);
            
            [self hideSelf];
            if (self.cancelBlock) {
                self.cancelBlock();
            }
        }];
        [_bgView addGestureRecognizer:tapGes];
    }
    return _bgView;
}

@end
