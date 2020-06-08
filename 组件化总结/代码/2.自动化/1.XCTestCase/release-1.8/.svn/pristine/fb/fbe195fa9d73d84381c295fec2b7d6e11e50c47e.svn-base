//
//  CYTAddressAddOrModifyDetailCell.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/5/23.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTAddressAddOrModifyDetailCell.h"

@implementation CYTAddressAddOrModifyDetailCell

- (void)ffSubviewsAndConfig:(void (^)(NSArray *, ffDefaultBlock))block {
    NSArray *views = @[self.flagLabel,self.line,self.textView];
    block(views,^{
        self.bottomHeight = 0;
    });
}

- (void)updateConstraints {
    [self.flagLabel updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTMarginH);
        make.top.equalTo(CYTAutoLayoutV(30));
        make.bottom.equalTo(self.line.top).offset(-CYTAutoLayoutV(30));
    }];
    [self.line updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTAutoLayoutH(30));
        make.right.equalTo((-CYTMarginH));
        make.height.equalTo(CYTLineH);
    }];
    [self.textView updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTAutoLayoutH(25));
        make.top.equalTo(self.line.bottom);
        make.right.equalTo(CYTAutoLayoutH(-25));
        make.height.equalTo(CYTAutoLayoutV(210));
        make.bottom.equalTo(-CYTAutoLayoutV(20));
    }];

    [super updateConstraints];
}

#pragma mark- get
- (UILabel *)flagLabel {
    if (!_flagLabel) {
        _flagLabel = [UILabel labelWithFontPxSize:28 textColor:kFFColor_title_L1];
        _flagLabel.text = @"详细地址";
    }
    return _flagLabel;
}

- (UIView *)line {
    if (!_line) {
        _line = [UIView new];
        _line.backgroundColor = kFFColor_line;
    }
    return _line;
}

- (UITextView *)textView {
    if (!_textView) {
        _textView = [UITextView new];
        _textView.textColor = kFFColor_title_L2;
        _textView.font = CYTFontWithPixel(28);
        _textView.placeholder = @"请输入详细地址";
        _textView.placeholderColor = kFFColor_title_gray;
        
        @weakify(self);
        [[_textView rac_textSignal] subscribeNext:^(NSString *x) {
            @strongify(self);
            //暂时不需要长度限制
//            NSInteger maxLenth = 100;
//            
//            if (x && x.length >maxLenth) {
//                x = [x substringToIndex:maxLenth];
//                self.textView.text = x;
//            }
            
            if (self.textBlock) {
                self.textBlock(self.textView.text);
            }
            
        }];
    }
    return _textView;
}

@end
