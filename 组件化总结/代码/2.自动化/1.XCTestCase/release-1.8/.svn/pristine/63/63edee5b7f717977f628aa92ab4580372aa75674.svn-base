//
//  CYTCarSourcePublishSearchView.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/5/25.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTUnenableSearchView.h"

@interface CYTUnenableSearchView()
@property (nonatomic, assign) float height;
@property (nonatomic, strong) UITapGestureRecognizer *gesture;

@end

@implementation CYTUnenableSearchView

- (void)ff_initWithViewModel:(id)viewModel {
    if (viewModel) {
        self.height = [viewModel integerValue];
    }else {
        self.height = CYTAutoLayoutV(66);
    }
}

- (void)ff_addSubViewAndConstraints {
    //默认不可填写
    self.canFillText = NO;
    
    [self addSubview:self.bgView];
    [self addSubview:self.imageView];
    [self addSubview:self.textField];
    
    [self.bgView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self.textField.left).offset(-CYTAutoLayoutH(10));
    }];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.centerX.equalTo(self).offset(CYTAutoLayoutH(15));
    }];
    
}

- (void)setCanFillText:(BOOL)canFillText {
    _canFillText = canFillText;
    self.textField.userInteractionEnabled = canFillText;
    [self.bgView removeGestureRecognizer:self.gesture];
    
    if (!canFillText) {
        //不可填写
        [self.bgView addGestureRecognizer:self.gesture];
    }
}

- (float)viewHeight {
    return self.height;
}

#pragma mark- method
- (void)moveLeft {
    [self.imageView remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self.textField.left).offset(-CYTAutoLayoutH(10));
        make.left.equalTo(CYTAutoLayoutH(25));
    }];
    [self.textField remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
    }];
}

- (void)moveOri {
    [self.imageView remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self.textField.left).offset(-CYTAutoLayoutH(10));
    }];
    [self.textField remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.centerX.equalTo(self).offset(CYTAutoLayoutH(15));
    }];
}

#pragma mark- get
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [UIView new];
        _bgView.backgroundColor = kFFColor_bg_nor;
        [_bgView radius:self.height/2.0 borderWidth:0.5 borderColor:[[UIColor blackColor] colorWithAlphaComponent:0.1]];
    }
    return _bgView;
}

- (UITapGestureRecognizer *)gesture {
    if (!_gesture) {
        _gesture = [UITapGestureRecognizer new];
        @weakify(self);
        [[_gesture rac_gestureSignal] subscribeNext:^(id x) {
            @strongify(self);
            if (self.searchBlock) {
                self.searchBlock();
            }
        }];
    }
    return _gesture;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [UIImageView new];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.image = [UIImage imageNamed:@"carSource_nav_search"];
    }
    return _imageView;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [UITextField new];
        _textField.textColor = kFFColor_title_L1;
        _textField.font = CYTFontWithPixel(26);
        _textField.placeholder = @"placeholder";
    }
    return _textField;
}

@end
