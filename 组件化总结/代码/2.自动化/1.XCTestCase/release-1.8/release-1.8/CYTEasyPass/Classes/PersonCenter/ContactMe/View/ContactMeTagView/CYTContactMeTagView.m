//
//  CYTContactMeTagView.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/10/17.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTContactMeTagView.h"
#import "ContactMeConfig.h"

@interface CYTContactMeTagView ()

/** 车源 */
@property(strong, nonatomic) UILabel *carSourceLabel;
/** 寻车 */
@property(strong, nonatomic) UILabel *seekCarLabel;
/** 分割线 */
@property(strong, nonatomic) UILabel *dividerLine;
/** 索引条 */
@property(strong, nonatomic) UIView *indexBarView;

@end

@implementation CYTContactMeTagView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self contactMeTagViewBasicConfig];
        [self initContactMeTagViewComponents];
        [self makeConstrains];
    }
    return  self;
}
/**
 *  基本配置
 */
- (void)contactMeTagViewBasicConfig{
    self.backgroundColor = [UIColor whiteColor];
}
/**
 *  初始化子控件
 */
- (void)initContactMeTagViewComponents{
    [self addSubview:self.carSourceLabel];
    [self addSubview:self.seekCarLabel];
    [self addSubview:self.dividerLine];
    [self addSubview:self.indexBarView];
}
/**
 *  布局子控件
 */
- (void)makeConstrains{
    [self.dividerLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(CYTAutoLayoutV(15.f));
        make.bottom.equalTo(-CYTAutoLayoutV(15.f));
        make.centerX.equalTo(self);
        make.width.equalTo(CYTDividerLineWH);
    }];
    
    [self.carSourceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self);
        make.right.equalTo(self.dividerLine.mas_left);
    }];

    [self.seekCarLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(self);
        make.left.equalTo(self.dividerLine.mas_right);
    }];
}

#pragma mark - 懒加载

- (UILabel *)carSourceLabel{
    if (!_carSourceLabel) {
        _carSourceLabel = [UILabel labelWithText:@"车源" textColor:CYTHexColor(@"#333333") textAlignment:NSTextAlignmentCenter fontPixel:32.f setContentPriority:NO];
        @weakify(self);
        [_carSourceLabel addTapGestureRecognizerWithTap:^(UITapGestureRecognizer *tap) {
            @strongify(self);
            self.currentIndex = 0;
            !self.indicatorClicked?:self.indicatorClicked(self.currentIndex);
        }];
    }
    return _carSourceLabel;
}
- (UILabel *)seekCarLabel{
    if (!_seekCarLabel) {
        _seekCarLabel = [UILabel labelWithText:@"寻车" textColor:CYTHexColor(@"#999999") textAlignment:NSTextAlignmentCenter fontPixel:30.f setContentPriority:NO];
        @weakify(self);
        [_seekCarLabel addTapGestureRecognizerWithTap:^(UITapGestureRecognizer *tap) {
            @strongify(self);
            self.currentIndex = 1;
            !self.indicatorClicked?:self.indicatorClicked(self.currentIndex);
        }];
    }
    return _seekCarLabel;
}

- (UILabel *)dividerLine{
    if (!_dividerLine) {
        _dividerLine = [UILabel dividerLineLabel];
    }
    return _dividerLine;
}
- (UIView *)indexBarView{
    if (!_indexBarView) {
        _indexBarView = [[UIView alloc] init];
        _indexBarView.backgroundColor = CYTGreenNormalColor;
        CGFloat indexBarViewW = CYTAutoLayoutH(kIndexBarViewW);
        CGFloat indexBarViewH = CYTAutoLayoutV(3.f);
        CGFloat indexBarViewX = (kScreenWidth*0.5 - indexBarViewW)*0.5f;
        CGFloat indexBarViewY = CYTAutoLayoutV(kContactMeTagViewHeight) - indexBarViewH;
        _indexBarView.frame = CGRectMake(indexBarViewX, indexBarViewY, indexBarViewW, indexBarViewH);
    }
    return _indexBarView;
}

- (void)setCurrentIndex:(NSInteger)currentIndex{
    _currentIndex = currentIndex;
    CGRect frame = self.indexBarView.frame;
    if (currentIndex == 0) {
        self.carSourceLabel.textColor = CYTHexColor(@"#333333");
        self.carSourceLabel.font = CYTFontWithPixel(32.f);
        self.seekCarLabel.textColor = CYTHexColor(@"#999999");
        self.seekCarLabel.font = CYTFontWithPixel(30.f);
        frame.origin.x = (kScreenWidth*0.5 - CYTAutoLayoutH(kIndexBarViewW))*0.5f;
    }else{
        self.seekCarLabel.textColor = CYTHexColor(@"#333333");
        self.seekCarLabel.font = CYTFontWithPixel(32.f);
        self.carSourceLabel.textColor = CYTHexColor(@"#999999");
        self.carSourceLabel.font = CYTFontWithPixel(30.f);
        frame.origin.x = (kScreenWidth*1.5 - CYTAutoLayoutH(kIndexBarViewW))*0.5f;
    }
    [UIView animateWithDuration:kAnimationDurationInterval animations:^{
        self.indexBarView.frame = frame;
    }];
    
}

@end
