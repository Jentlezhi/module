//
//  CYTPriceInputContentView.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/6/9.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTPriceInputContentView.h"


@interface CYTPriceInputContentView()<UITextFieldDelegate>
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, assign) NSInteger currentIndex;
///没有指导价
@property (nonatomic, assign) NSInteger noGuidePrice;

@end

@implementation CYTPriceInputContentView

- (void)ff_initWithViewModel:(id)viewModel {
    self.titleArray = @[@"优惠万元",@"优惠点数",@"加价万元",@"直接报价"];
}

- (void)ff_addSubViewAndConstraints {
    [self addSubview:self.segmentView];
    [self addSubview:self.borderView];
    
    [self.segmentView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTMarginH);
        make.right.equalTo(-CYTMarginH);
        make.top.equalTo(CYTAutoLayoutV(10));
        make.height.equalTo(CYTAutoLayoutV(90));
    }];
    [self.borderView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.segmentView.bottom).offset(CYTItemMarginV);
        make.left.right.equalTo(0);
        make.bottom.equalTo(-CYTMarginV);
        make.height.equalTo(CYTAutoLayoutV(90));
    }];
    
    
    [self.borderView addSubview:self.leftLabel];
    [self.borderView addSubview:self.textFiled];
    [self.borderView addSubview:self.rightLabel];
    
    [self.textFiled setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    [self.leftLabel setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    [self.rightLabel setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    
    [self.leftLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTMarginH);
        make.top.bottom.equalTo(self.borderView);
    }];
    [self.textFiled makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.leftLabel);
        make.height.equalTo(CYTAutoLayoutV(90));
        make.left.equalTo(self.leftLabel.right).offset(10);
        make.right.equalTo(self.rightLabel.left).offset(-5);
    }];
    [self.rightLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.leftLabel);
        make.right.equalTo(-CYTItemMarginH);
        make.top.bottom.equalTo(self.borderView);
    }];
}

- (float)viewHeight {
    return CYTAutoLayoutV(130);
}

- (UIButton *)itemButton:(NSString *)title {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:kFFColor_title_L1 forState:UIControlStateNormal];
    button.titleLabel.font = CYTFontWithPixel(22);
    
    return button;
}

- (void)addLine:(UIButton *)button {
    UIView *line = [UIView new];
    line.backgroundColor = kFFColor_line;
    [button addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(button);
        make.width.equalTo(CYTLineH);
    }];
}

- (void)setCurrentIndex:(NSInteger)currentIndex {
    _currentIndex = currentIndex;
    if (self.indexBlock) {
        self.indexBlock(currentIndex);
    }
    self.textFiled.text = @"";
    
    if (self.priceBlock) {
        self.priceBlock(@"");
    }
    
    [self setAssistantWithIndex:currentIndex];
}

- (void)setAssistantWithIndex:(NSInteger)index {
    if (index == 0) {
        self.leftLabel.text = @"下";
        self.rightLabel.text = @"万元";
    }else if (index == 1) {
        self.leftLabel.text = @"下";
        self.rightLabel.text = @"点";
    }else if (index == 2) {
        self.leftLabel.text = @"加";
        self.rightLabel.text = @"万元";
    }else if (index == 3) {
        self.leftLabel.text = @"";
        self.rightLabel.text = @"万元";
    }
}

#pragma mark- method
- (void)clearMethod {
    self.textFiled.text = @"";
    self.segmentView.index = 0;
}

- (void)setGuidePrice:(NSString *)guidePrice {
    _guidePrice = guidePrice;
    
    if ([guidePrice isEqualToString:@""] || [guidePrice floatValue] == 0 || [guidePrice isEqualToString:@"暂无"]) {
        //判断如果指导价是0，那么只能进行直接输入
        self.noGuidePrice  = YES;
        self.segmentView.index = 3;
        self.segmentView.userInteractionEnabled = NO;
    }else {
        //否则默认输入
        self.noGuidePrice = NO;
        self.segmentView.index = 0;
        self.segmentView.userInteractionEnabled = YES;
    }
}

- (float)resultPrice {
    
    float guidePrice = [self.guidePrice floatValue];
    float value = [self.textFiled.text floatValue];
    
    if (self.currentIndex == 0) {
        float result = guidePrice-value;
        if (result >0) {
            return result;
        }else {
            return 0;
        }
    }else if (self.currentIndex == 1) {
        float result = guidePrice-guidePrice*value/100.0;
        if (result >0) {
            return result;
        }else {
            return 0;
        }
    }else if (self.currentIndex == 2) {
        return guidePrice+value;
    }else if (self.currentIndex == 3) {
        return value;
    }
    return 0;
}

#pragma mark- get
- (FFBasicSegmentView *)segmentView {
    if (!_segmentView) {
        _segmentView = [FFBasicSegmentView new];
        _segmentView.type = FFBasicSegmentTypeAverage;
        _segmentView.showIndicatorLine = YES;
        _segmentView.showBottomLine = NO;
        _segmentView.indicatorBgColor = [UIColor clearColor];
        _segmentView.titlesArray = self.titleArray;
        
        @weakify(self);
        [_segmentView setIndexChangeBlock:^(NSInteger index) {
            @strongify(self);
            if (self.noGuidePrice && index != 3) {
                return;
            }
            self.currentIndex = index;
        }];
    }
    return _segmentView;
}

- (UIView *)borderView {
    if (!_borderView) {
        _borderView = [UIView new];
        [_borderView radius:1 borderWidth:CYTLineH borderColor:kFFColor_line];
    }
    return _borderView;
}

- (UITextField *)textFiled {
    if (!_textFiled) {
        _textFiled = [UITextField new];
        _textFiled.keyboardType = UIKeyboardTypeDecimalPad;
        _textFiled.textAlignment = NSTextAlignmentRight;
        _textFiled.font = CYTFontWithPixel(36);
        _textFiled.textColor = CYTRedColor;
        _textFiled.delegate = self;
        
        @weakify(self);
        [[_textFiled rac_textSignal] subscribeNext:^(id x) {
            @strongify(self);
            
            //保证数据大于0
            float value = [self resultPrice];
            
            if (value == 0) {
                self.textFiled.text = @"";
            }
            
            if (self.priceBlock) {
                self.priceBlock(self.textFiled.text);
            }
            
        }];
    }
    return _textFiled;
}

- (UILabel *)leftLabel {
    if (!_leftLabel) {
        _leftLabel = [UILabel new];
        _leftLabel.font = CYTFontWithPixel(26);
        _leftLabel.textColor = kFFColor_title_L2;
        _leftLabel.text = @"下";
    }
    return _leftLabel;
}

- (UILabel *)rightLabel {
    if (!_rightLabel) {
        _rightLabel = [UILabel new];
        _rightLabel.font = CYTFontWithPixel(26);
        _rightLabel.textColor = kFFColor_title_L2;
        _rightLabel.text = @"万元";
    }
    return _rightLabel;
}

@end
