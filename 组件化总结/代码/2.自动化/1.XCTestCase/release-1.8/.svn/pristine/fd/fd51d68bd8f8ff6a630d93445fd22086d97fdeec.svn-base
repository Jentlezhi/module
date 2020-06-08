//
//  CYTCommitGuideView.m
//  CYTEasyPass
//
//  Created by xujunquan on 2017/10/26.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCommitGuideView.h"

@implementation CYTCommitGuideView

- (void)ff_addSubViewAndConstraints {
    [self addSubview:self.bgView];
    [self addSubview:self.whiteView];
    
    [self.bgView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [self.whiteView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTMarginH);
        make.right.equalTo(-CYTMarginH);
        make.top.equalTo(CYTViewOriginY+5);
        make.height.equalTo(CYTAutoLayoutV(940+136));
    }];
    
    [self.whiteView addSubview:self.imageView];
    [self.whiteView addSubview:self.actionButton];
    [self.imageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(0);
        make.height.equalTo(CYTAutoLayoutV(940));
    }];
    [self.actionButton makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(CYTAutoLayoutH(246));
        make.height.equalTo(CYTAutoLayoutV(68));
        make.centerX.equalTo(0);
        make.bottom.offset(-CYTAutoLayoutV(68));
    }];
}

#pragma mark- get
- (UIView *)whiteView {
    if (!_whiteView) {
        _whiteView = [UIView new];
        _whiteView.backgroundColor = [UIColor whiteColor];
        [_whiteView radius:5 borderWidth:0.5 borderColor:[UIColor whiteColor]];
    }
    return _whiteView;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        NSString *imageName = (self.viewModel.ffIndex==0)?@"img_buyCar_tip":@"img_sellCar_tip";
        _imageView = [UIImageView ff_imageViewWithImageName:imageName];
    }
    return _imageView;
}

- (UIButton *)actionButton {
    if (!_actionButton) {
        _actionButton = [UIButton buttonWithFontPxSize:28 textColor:[UIColor whiteColor] text:@"我知道了"];
        _actionButton.backgroundColor = kFFColor_green;
        [_actionButton radius:2 borderWidth:0.5 borderColor:[UIColor clearColor]];
        @weakify(self);
        [[_actionButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            !self.clickBlock?:self.clickBlock();
            [self ff_hideSupernatantView];
        }];
    }
    return _actionButton;
}

@end
