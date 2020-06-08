//
//  FFDZNItemView.m
//  CYTEasyPass
//
//  Created by xujunquan on 2017/9/27.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFDZNItemView.h"

@implementation FFDZNItemView

- (void)ff_addSubViewAndConstraints {

}

#pragma mark- get
- (UIImageView *)dznImageView {
    if (!_dznImageView) {
        _dznImageView = [UIImageView ff_imageViewWithImageName:nil];
    }
    return _dznImageView;
}

- (UILabel *)dznLabel {
    if (!_dznLabel) {
        _dznLabel = [UILabel labelWithFontPxSize:28 textColor:kFFColor_title_gray];
        _dznLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _dznLabel;
}

- (UIButton *)dznButton {
    if (!_dznButton) {
        _dznButton = [UIButton buttonWithFontPxSize:24 textColor:kFFColor_title_L1 text:nil];
        @weakify(self);
        [[_dznButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            if (self.dznReloadBlock) {
                self.dznReloadBlock();
            }
        }];
    }
    return _dznButton;
}

@end
