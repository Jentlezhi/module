//
//  CYTPriceInputView.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/6/9.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTPriceInputView.h"

@interface CYTPriceInputView()
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, copy) NSString *price;

@end

@implementation CYTPriceInputView

- (void)ff_addSubViewAndConstraints {

    float leftX = CYTMarginH;
    float rightX = -CYTMarginH;
    if (@available(iOS 11.0, *)) {
        [self makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(kScreenWidth);
            make.height.equalTo(kInputViewHeight);
        }];
    }
    
    self.backgroundColor = [UIColor whiteColor];
    
    [self.cancelButton enlargeWithValue:5];
    [self addSubview:self.cancelButton];
    [self addSubview:self.hopePriceLabel];
    [self addSubview:self.affirmButton];
    [self addSubview:self.lineView];
    [self addSubview:self.guidePriceView];
    [self addSubview:self.borderView];
    
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(CYTAutoLayoutV(36));
        make.height.width.equalTo(CYTAutoLayoutV(28));
        make.left.equalTo(leftX);
    }];
    [self.hopePriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.cancelButton);
        make.centerX.equalTo(self);
        make.width.equalTo(SCREEN_WIDTH-120);
    }];
    [self.affirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.cancelButton);
        make.width.equalTo(CYTAutoLayoutH(110));
        make.height.equalTo(CYTAutoLayoutV(56));
        make.right.equalTo(rightX);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.cancelButton.mas_bottom).offset(CYTAutoLayoutV(36));
        make.height.equalTo(CYTLineH);
        make.width.equalTo(SCREEN_WIDTH-CYTMarginH*2);
    }];
    [self.guidePriceView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftX);
        make.right.equalTo(rightX);
        make.height.equalTo(CYTAutoLayoutV(70));
        make.top.equalTo(self.lineView.bottom).offset(CYTItemMarginV);
    }];
    [self.borderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.guidePriceView.bottom);
        make.left.equalTo(leftX);
        make.right.equalTo(rightX);
        make.height.equalTo(CYTAutoLayoutV(230));
    }];
    
    [self.guidePriceView addSubview:self.guidePriceLabel];
    [self.guidePriceLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTItemMarginH);
        make.top.bottom.right.equalTo(0);
    }];
    
    [self.borderView addSubview:self.contentView];
    [self.contentView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.borderView);
    }];
}

#pragma mark- method
- (void)cancelMethod {
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}

- (void)affirmMethod {
    if (self.affirmBlock) {
        self.affirmBlock(self.index,self.price,[self hopePriceString]);
    }
}

- (void)setGuidePrice:(NSString *)guidePrice {
    _guidePrice = guidePrice;
    
    self.contentView.guidePrice = guidePrice;
    
    NSString *string = @"";
    if ([guidePrice isEqualToString:@""] || [guidePrice isEqualToString:@"0"] || [guidePrice isEqualToString:@"暂无"]) {
        string = @"指导价:暂无";
    }else {
        string = [NSString stringWithFormat:@"指导价: %@ 万元",guidePrice];
    }
    self.guidePriceLabel.text = string;
}

- (NSString *)hopePriceString {
    //计算报价
    NSString *resultString = @"";
    float guidePrice = [self.guidePrice floatValue];
    float value = [self.price floatValue];
    float result = 0;
    
    if (self.index == 0) {
        result = guidePrice-value;
    }else if (self.index == 1) {
        result = guidePrice-value*guidePrice/100.0;
    }else if (self.index == 2) {
        result = guidePrice+value;
    }else if (self.index == 3) {
        result = value;
    }

    resultString = [NSString stringWithFormat:@"%.2f",result];
    
    return resultString;
}

#pragma mark- get
- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton setTitleColor:kFFColor_title_L1 forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(cancelMethod) forControlEvents:UIControlEventTouchUpInside];
        [_cancelButton setImage:[UIImage imageNamed:@"carSource_publish_cancel"] forState:UIControlStateNormal];
    }
    return _cancelButton;
}

- (UILabel *)hopePriceLabel {
    if (!_hopePriceLabel) {
        _hopePriceLabel = [UILabel labelWithFontPxSize:32 textColor:kFFColor_title_L1];
        _hopePriceLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _hopePriceLabel;
}

- (UIButton *)affirmButton {
    if (!_affirmButton) {
        _affirmButton = [UIButton buttonWithFontPxSize:30 textColor:[UIColor whiteColor] text:@"确定"];
        _affirmButton.backgroundColor = kFFColor_green;
        [_affirmButton radius:CYTAutoLayoutV(56)/2.0 borderWidth:1 borderColor:kFFColor_green];
        [_affirmButton addTarget:self action:@selector(affirmMethod) forControlEvents:UIControlEventTouchUpInside];
    }
    return _affirmButton;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = kFFColor_line;
    }
    return _lineView;
}

- (UILabel *)guidePriceLabel {
    if (!_guidePriceLabel) {
        _guidePriceLabel = [UILabel labelWithFontPxSize:28 textColor:kFFColor_title_L2];
        _guidePriceLabel.text = @"指导价:0万元";
    }
    return _guidePriceLabel;
}

- (UIView *)guidePriceView {
    if (!_guidePriceView) {
        _guidePriceView = [UIView new];
        [_guidePriceView radius:2 borderWidth:0.5 borderColor:kFFColor_bg_nor];
        _guidePriceView.backgroundColor = kFFColor_bg_nor;
    }
    return _guidePriceView;
}

- (UIView *)borderView {
    if (!_borderView) {
        _borderView = [UIView new];
    }
    return _borderView;
}

- (CYTPriceInputContentView *)contentView {
    if (!_contentView) {
        _contentView = [CYTPriceInputContentView new];
        
        @weakify(self);
        [_contentView setIndexBlock:^(NSInteger index) {
            @strongify(self);
            self.index = index;
        }];
        [_contentView setPriceBlock:^(NSString *price) {
            @strongify(self);
            if ([price isEqualToString:@""]) {
                price = @"0";
            }
            self.price = price;
            
            NSString *priceString = [self hopePriceString];
            NSString *hopeprice = [NSString stringWithFormat:@"报价：%@ 万元",priceString];
            self.hopePriceLabel.text = hopeprice;
            NSRange range = [hopeprice rangeOfString:priceString];
            [self.hopePriceLabel updateWithRange:range font:CYTFontWithPixel(36) color:CYTRedColor];
            
        }];
        
    }
    return _contentView;
}

@end
