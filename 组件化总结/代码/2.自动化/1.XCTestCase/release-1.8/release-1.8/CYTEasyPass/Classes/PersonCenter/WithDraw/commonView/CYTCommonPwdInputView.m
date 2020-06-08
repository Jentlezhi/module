//
//  CYTCommonPwdInputView.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/3/24.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCommonPwdInputView.h"

#define kPointWidth 10

@implementation CYTCommonPwdInputViewItem

- (void)ff_initWithViewModel:(id)viewModel {
    [self radius:1 borderWidth:0.5 borderColor:kFFColor_line];
}

- (void)ff_addSubViewAndConstraints {
    [self addSubview:self.pointView];
    [self.pointView radius:kPointWidth/2.0 borderWidth:1 borderColor:[UIColor clearColor]];
    [self.pointView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.equalTo(CGSizeMake(kPointWidth, kPointWidth));
    }];
}

#pragma mark- get
- (UIView *)pointView {
    if (!_pointView) {
        _pointView = [UIView new];
        _pointView.backgroundColor = kFFColor_title_L1;
    }
    return _pointView;
}

@end


@implementation CYTCommonPwdInputView

- (void)ff_initWithViewModel:(id)viewModel {
    UITapGestureRecognizer *tapGes = [UITapGestureRecognizer new];
    [[tapGes rac_gestureSignal] subscribeNext:^(id x) {
//        !self.clickBlock?:self.clickBlock();
        [self.textField becomeFirstResponder];
    }];
    [self addGestureRecognizer:tapGes];
    
    self.itemArray = [NSMutableArray array];
}

- (void)clearAll {
    for (int i=0; i<self.itemArray.count; i++) {
        CYTCommonPwdInputViewItem *item = self.itemArray[i];
        item.pointView.backgroundColor = [UIColor whiteColor];
    }
    self.textField.text = @"";
}

- (void)ff_addSubViewAndConstraints {
    [self addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    UIView *lastView;
    for (int i=0; i<6; i++) {
        CYTCommonPwdInputViewItem *item = [CYTCommonPwdInputViewItem new];
        [self addSubview:item];
        [self.itemArray addObject:item];
        
        
        [item mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            if (lastView) {
                make.left.equalTo(lastView.mas_right);
            }else{
                make.left.equalTo(0);
            }
            make.width.equalTo(self).multipliedBy(1/6.0);
        }];
        
        lastView = item;
        
    }
}

- (void)textFieldDidChange:(UITextField *)textField {
    
    if (textField.text.length > 6) {
        textField.text = [textField.text substringToIndex:6];
    }
    
    NSString *text = textField.text;
    [self updateItemWithString:text];
}

- (void)updateItemWithString:(NSString *)txt {
    NSInteger length = txt.length;
    
    for (int i=0; i<self.itemArray.count; i++) {
        CYTCommonPwdInputViewItem *item = self.itemArray[i];
        if (i<length) {
            item.pointView.backgroundColor = kFFColor_title_L1;
        }
        
        if (i>=length && i<6) {
            item.pointView.backgroundColor = [UIColor whiteColor];
        }
    }
    
    if (length == 6) {
        if (self.finishedBlock) {
            self.finishedBlock(self.textField.text);
        }
    }
}

#pragma mark- get
- (UITextField *)textField{
    if (!_textField) {
        _textField = [UITextField new];
        _textField.backgroundColor = [UIColor whiteColor];
        //输入的文字颜色为白色
        _textField.textColor = [UIColor whiteColor];
        //输入框光标的颜色为白色
        _textField.tintColor = [UIColor whiteColor];
        _textField.delegate = self;
        _textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _textField.keyboardType = UIKeyboardTypeNumberPad;
        _textField.layer.borderColor = [kFFColor_line CGColor];
        _textField.layer.borderWidth = 1;
        [_textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _textField;
}


@end
