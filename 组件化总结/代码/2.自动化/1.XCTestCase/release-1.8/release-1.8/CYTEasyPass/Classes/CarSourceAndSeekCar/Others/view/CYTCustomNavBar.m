
//  CYTEasyPass
//
//  Created by xujunquan on 17/2/28.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCustomNavBar.h"

@interface CYTCustomNavBar ()
@property (nonatomic, strong) UIButton *publishButton;
@property (nonatomic, strong) UIButton *backButton;

@end

@implementation CYTCustomNavBar

- (void)ff_addSubViewAndConstraints {
    [self addSubview:self.publishButton];
    [self addSubview:self.searchTextFiled];
    [self addSubview:self.line];

    [self.publishButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(CYTAutoLayoutH(-20));
    }];
    [self.searchTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(CYTItemMarginH);
        make.right.equalTo(self.publishButton.mas_left).offset(-CYTAutoLayoutH(24));
        make.height.equalTo(30);
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.equalTo(CYTLineH);
    }];
    
    
    [self.publishButton addSubview:self.rightImageView];
    [self.publishButton addSubview:self.rightTitleLabel];
    
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.publishButton);
    }];
    [self.rightTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rightImageView.bottom);
        make.centerX.equalTo(self.publishButton);
    }];
    
}

#pragma makr- delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (self.searchBlock) {
        self.searchBlock();
        return NO;
    }
    return YES;
}

#pragma mark- get
- (UIImageView *)rightImageView {
    if (!_rightImageView) {
        _rightImageView = [UIImageView new];
        _rightImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _rightImageView;
}

- (UILabel *)rightTitleLabel {
    if (!_rightTitleLabel) {
        _rightTitleLabel = [UILabel new];
        _rightTitleLabel.font = CYTFontWithPixel(20);
        _rightTitleLabel.textColor = UIColorFromRGB(0x686868);;
        _rightTitleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _rightTitleLabel;
}

- (UIView *)line {
    if (!_line) {
        _line = [UIView new];
        _line.backgroundColor = kFFColor_line;
    }
    return _line;
}

- (UIButton *)publishButton {
    if (!_publishButton) {
        _publishButton = [UIButton new];
        
        @weakify(self);
        [[_publishButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            if (self.publishBlock) {
                self.publishBlock();
            }
        }];
        
    }
    return _publishButton;
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
        
        _searchTextFiled.backgroundColor = kFFColor_bg_nor;
        [_searchTextFiled radius:30/2.0 borderWidth:0.5 borderColor:[UIColor clearColor]];
        _searchTextFiled.font = CYTFontWithPixel(24);
        _searchTextFiled.delegate = self;
    }
    return _searchTextFiled;
}
@end
