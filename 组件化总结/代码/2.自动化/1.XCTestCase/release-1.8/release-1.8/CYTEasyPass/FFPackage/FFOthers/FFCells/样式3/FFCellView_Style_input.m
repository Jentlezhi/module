//
//  FFCellView_Style_input.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/5/11.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFCellView_Style_input.h"
#import "FFBasicMacro.h"
#import "FFCommonCode.h"

@implementation FFCellView_Style_input

- (void)ff_addSubViewAndConstraints {
    
    [self addSubview:self.borderView];
    [self.borderView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    //
    [self addContentView];
}

- (void)addContentView {
    [self.borderView addSubview:self.flagLabel];
    [self.borderView addSubview:self.textFiled];
    [self.borderView addSubview:self.assistantLabel];
    [self.borderView addSubview:self.line];
    
    [self.flagLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(kFFAutolayoutH(30));
        make.top.bottom.equalTo(self.borderView);
        make.height.equalTo(kFFAutolayoutV(90));
    }];
    
    //让textField被拉伸
    [self.textFiled setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    [self.flagLabel setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    [self.assistantLabel setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    
    [self.textFiled makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.flagLabel.right).offset(5);
        make.top.bottom.equalTo(self.borderView);
        make.height.equalTo(kFFAutolayoutV(90));
    }];
    [self.assistantLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.borderView);
        make.right.equalTo(-kFFAutolayoutH(30));
        make.left.equalTo(self.textFiled.right);
    }];
    [self.line makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(kFFAutolayoutH(30));
        make.right.equalTo(-kFFAutolayoutH(30));
        make.bottom.equalTo(0);
        make.height.equalTo(kFFLayout_line);
    }];
}


- (void)setShowNone:(BOOL)showNone {
    _showNone = showNone;
    
    if (showNone) {
        [self.borderView removeFromSuperview];
        [self makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(kFFLayout_line);
        }];
        
    }else {
        [self addSubview:self.borderView];
        [self.borderView remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
}

#pragma mark- get
- (UIView *)borderView {
    if (!_borderView) {
        _borderView = [UIView new];
        _borderView.layer.masksToBounds = YES;
    }
    return _borderView;
}

- (UILabel *)flagLabel {
    if (!_flagLabel) {
        _flagLabel = [UILabel labelWithFontPxSize:28 textColor:kFFColor_title_L1];
    }
    return _flagLabel;
}

- (UITextField *)textFiled {
    if (!_textFiled) {
        _textFiled = [UITextField new];
        _textFiled.font = [UIFont systemFontOfSize:13];
        _textFiled.textColor = [UIColor redColor];
        _textFiled.textAlignment = NSTextAlignmentRight;
        @weakify(self);
        [[_textFiled rac_textSignal] subscribeNext:^(id x) {
            @strongify(self);
            if (self.textBlock) {
                self.textBlock(x);
            }
        }];
    }
    return _textFiled;
}

- (UIView *)line {
    if (!_line) {
        _line = [UIView new];
        _line.backgroundColor = kFFColor_line;
    }
    return _line;
}

- (UILabel *)assistantLabel {
    if (!_assistantLabel) {
        _assistantLabel = [UILabel labelWithFontPxSize:26 textColor:kFFColor_title_L1];
    }
    return _assistantLabel;
}

@end
