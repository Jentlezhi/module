//
//  CYTCarSearchView.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/3/21.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCarSearchView.h"

@implementation CYTCarSearchView

- (void)ff_addSubViewAndConstraints {
    [self addSubview:self.backButton];
    [self addSubview:self.searchTextFiled];
    [self addSubview:self.clearButton];
    
    //扩大点击事件
    [self.clearButton enlargeWithValue:5];
    [self.backButton enlargeWithValue:5];
    
    [self.backButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(CYTAutoLayoutH(4));
        make.size.equalTo(CGSizeMake(34, 44));
    }];
    [self.searchTextFiled mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.backButton.mas_right).offset(0);
        make.right.equalTo(-CYTAutoLayoutH(30));
        make.height.equalTo(30);
    }];
    [self.clearButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.searchTextFiled);
        make.right.equalTo(self.searchTextFiled).offset(-CYTItemMarginH);
        make.width.height.equalTo(CYTAutoLayoutH(40));
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextFieldTextDidChangeNotification object:nil];
}

//文字发生改变
- (void)textChanged:(NSNotification *) noti{
    if (![noti.object isEqual:self.searchTextFiled]) {
        return;
    }
    self.clearButton.hidden = (self.searchTextFiled.text.length == 0);
    
    if (self.searchTextFiled.text.length == 0) {
        if (self.beginBlock) {
            self.beginBlock();
        }
    }else {
        if (self.associationBlock) {
            self.associationBlock(self.searchTextFiled.text,self.searchTextFiled);
        }
    }
}

//点击搜索
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (self.searchItemBlock) {
        self.searchItemBlock(textField.text);
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.clearButton.hidden = (self.searchTextFiled.text.length == 0);
    
    if (textField.text.length>0) {
        return;
    }
    if (self.beginBlock) {
        self.beginBlock();
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.clearButton.hidden = YES;
}

#pragma mark- set
- (void)setSearchPlaceholder:(NSString *)searchPlaceholder {
    _searchPlaceholder = searchPlaceholder;
    
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:searchPlaceholder];
    [placeholder addAttribute:NSForegroundColorAttributeName
                        value:UIColorFromRGB(0x999999)
                        range:NSMakeRange(0, placeholder.length)];
    _searchTextFiled.attributedPlaceholder = placeholder;
}

#pragma mark- get
- (UIButton *)backButton {
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
        @weakify(self);
        [[_backButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            if (self.backBlock) {
                self.backBlock();
            }
        }];
    }
    return _backButton;
}

- (UITextField *)searchTextFiled {
    if (!_searchTextFiled) {
        _searchTextFiled = [UITextField new];
        
        UIView *left = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 36, 22)];
        UIImageView *imageView = [UIImageView new];
        imageView.frame = CGRectMake(10, 0, 26, 22);
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.image = [UIImage imageNamed:@"carSource_nav_search"];
        [left addSubview:imageView];
        
        _searchTextFiled.leftView = left;
        _searchTextFiled.leftViewMode = UITextFieldViewModeAlways;
        
        NSString *placeholderTxt = @"搜索品牌/车系/指导价";
        NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:placeholderTxt];
        [placeholder addAttribute:NSForegroundColorAttributeName
                            value:UIColorFromRGB(0x999999)
                            range:NSMakeRange(0, placeholder.length)];
        _searchTextFiled.attributedPlaceholder = placeholder;
        
        _searchTextFiled.backgroundColor = UIColorFromRGB(0xf5f5f5);
        [_searchTextFiled radius:30/2.0 borderWidth:0.5 borderColor:[UIColor clearColor]];
        _searchTextFiled.font = CYTFontWithPixel(24);
        _searchTextFiled.returnKeyType = UIReturnKeySearch;
        _searchTextFiled.delegate = self;
        _searchTextFiled.enablesReturnKeyAutomatically = YES;

    }
    return _searchTextFiled;
}

- (UIButton *)clearButton {
    if (!_clearButton) {
        _clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _clearButton.hidden = YES;
        [_clearButton setImage:[UIImage imageNamed:@"carSourceAndSeekCarSearch_clear"] forState:UIControlStateNormal];
        [_clearButton setImage:[UIImage imageNamed:@"carSourceAndSeekCarSearch_clear"] forState:UIControlStateHighlighted];
        
        @weakify(self);
        [[_clearButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            self.clearButton.hidden = YES;
            [self.searchTextFiled becomeFirstResponder];
            self.searchTextFiled.text = @"";
            if (self.beginBlock) {
                self.beginBlock();
            }
        }];
    }
    return _clearButton;
}

@end
