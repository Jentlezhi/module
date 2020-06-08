//
//  CYTSimpleBottomView.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/5/25.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTSimpleBottomView.h"

@implementation CYTSimpleBottomView

- (void)ff_addSubViewAndConstraints {
    [self addSubview:self.bottomButton];
    [self.bottomButton makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsMake(CYTAutoLayoutV(20), CYTAutoLayoutV(30), CYTAutoLayoutV(20), CYTAutoLayoutV(30)));
    }];
}

- (void)setEnable:(BOOL)enable {
    _enable = enable;
    UIColor *color = (enable)?kFFColor_green:CYTBtnDisableColor;
    self.bottomButton.backgroundColor = color;
    self.bottomButton.enabled = enable;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    [self.bottomButton setTitle:title forState:UIControlStateNormal];
}

+ (float)height {
    return CYTAutoLayoutV(120);
}

#pragma mark- get
- (UIButton *)bottomButton {
    if (!_bottomButton) {
        _bottomButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_bottomButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _bottomButton.titleLabel.font = CYTFontWithPixel(35);
        _bottomButton.backgroundColor = kFFColor_green;
        [_bottomButton radius:2 borderWidth:1 borderColor:[UIColor clearColor]];
        
        @weakify(self);
        [[_bottomButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            if (self.clickBlock) {
                self.clickBlock();
            }
        }];
    }
    return _bottomButton;
}

@end
