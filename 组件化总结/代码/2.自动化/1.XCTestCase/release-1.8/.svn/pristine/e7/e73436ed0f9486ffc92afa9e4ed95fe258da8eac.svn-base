//
//  CYTYiCheCoinSignView.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/11/8.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTYiCheCoinSignView.h"
#import "CYTSignTimeView.h"
#import "MyYicheCoinConfig.h"
#import "CYTCoinSignModel.h"
#import "CYTCoinSignResultModel.h"
#import "CYTCoinValueView.h"

static const NSUInteger cTotaItems = 10;
static const NSTimeInterval signIndicatorAnimation = 0.3f;

@interface CYTYiCheCoinSignView()
/** 签到次数背景 */
@property(strong, nonatomic) UIView *signTimeBgView;
/** 金币个数背景 */
@property(strong, nonatomic) UIView *coinNumBgView;
/** 签到天数集合 */
@property(strong, nonatomic) NSMutableArray <CYTCoinSignModel *>*coinSignModels;
/** 签到指示器 */
@property(strong, nonatomic) UIImageView *signIndicator;
/** 签到指示器位置 */
@property(assign, nonatomic) NSUInteger currentIndex;
@end

@implementation CYTYiCheCoinSignView

- (void)basicConfig{
    self.backgroundColor = [UIColor whiteColor];
}

- (void)initSubComponents{
    [self addSubview:self.signTimeBgView];
    [self addSubview:self.signIndicator];
    [self addSubview:self.coinNumBgView];
}

- (void)makeSubConstrains{
    [self.signTimeBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(CYTAutoLayoutV(30.f));
        make.left.equalTo(CYTMarginH);
        make.right.equalTo(-CYTMarginH);
        make.height.equalTo(CYTAutoLayoutV(50.f));
    }];
    
    [self.coinNumBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.signTimeBgView.mas_bottom);
        make.left.equalTo(CYTMarginH);
        make.right.equalTo(-CYTMarginH);
        make.height.equalTo(CYTAutoLayoutV(50.f));
    }];
}

#pragma mark - 懒加载
- (NSMutableArray *)coinSignModels{
    if (!_coinSignModels) {
        _coinSignModels = [NSMutableArray arrayWithCapacity:cTotaItems];
        for (NSInteger index = 0; index < cTotaItems; index ++) {
            CYTCoinSignModel *model = CYTCoinSignModel.new;
            model.title = [NSString stringWithFormat:@"%ld",index+1];
            [_coinSignModels addObject:model];
        }
    }
    return _coinSignModels;
}
- (UIView *)signTimeBgView{
    if (!_signTimeBgView) {
        _signTimeBgView = UIView.new;
        _signTimeBgView.backgroundColor = [UIColor whiteColor];
    }
    return _signTimeBgView;
}
- (UIImageView *)signIndicator{
    if (!_signIndicator) {
        _signIndicator = [UIImageView ff_imageViewWithImageName:@"pic_triangle"];
        CGFloat signIndicatorWidth = CYTAutoLayoutV(30.f);
        _signIndicator.frame = CGRectMake(kSignIndicatorOriginX, 0, signIndicatorWidth, CYTAutoLayoutV(14.f));
    }
    return _signIndicator;
}

- (UIView *)coinNumBgView{
    if (!_coinNumBgView) {
        _coinNumBgView = UIView.new;
        _coinNumBgView.backgroundColor = [UIColor whiteColor];
    }
    return _coinNumBgView;
}

- (void)setSignResultModel:(CYTCoinSignResultModel *)signResultModel{
    _signResultModel = signResultModel;
    NSUInteger continuousDays = signResultModel.continuousDays;
    BOOL isSignIn = signResultModel.isSignIn;
    NSUInteger baseDay = [signResultModel.baseDay integerValue];
    self.currentIndex = isSignIn ? (continuousDays>1?continuousDays-1:0) : continuousDays;
    NSUInteger limitedDays = isSignIn ? continuousDays : continuousDays + 1;
    //重置
    [self.coinSignModels enumerateObjectsUsingBlock:^(CYTCoinSignModel * _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
        model.hasSign = NO;
        model.btnShowDotLine = NO;
    }];
    if (limitedDays>8) {
        CYTCoinSignModel *currentModel = self.coinSignModels[cTotaItems-3];
        self.currentIndex = cTotaItems - 3;
        NSUInteger currentInteger = isSignIn ? continuousDays : continuousDays + 1;
        currentModel.title = [NSString stringWithFormat:@"%lu",(unsigned long)currentInteger];
        //前一个
        CYTCoinSignModel *beforeCurrentModel = self.coinSignModels[cTotaItems-4];
        beforeCurrentModel.title = [NSString stringWithFormat:@"%lu",(unsigned long)(currentInteger-1)];
        //后一个
        CYTCoinSignModel *afterCurrentModel = self.coinSignModels[cTotaItems-2];
        afterCurrentModel.title = [NSString stringWithFormat:@"%lu",(unsigned long)(currentInteger+1)];
        //最后一个
        CYTCoinSignModel *lastModel = [self.coinSignModels lastObject];
        lastModel.title = [NSString stringWithFormat:@"%lu",(unsigned long)(currentInteger + 2)];
        //显示省略...
        CYTCoinSignModel *omitModel = self.coinSignModels[cTotaItems-5];
        omitModel.btnShowDotLine = YES;
    }
    [self.coinSignModels enumerateObjectsUsingBlock:^(CYTCoinSignModel * _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
        NSUInteger signNum = [model.title integerValue];
        //设置已签到
        model.hasSign = signNum <= continuousDays;
        //设置圆角类型
        if (continuousDays == 1) {
            model.cornerType = CYTBtnCornerTypeAll;
        }else if(continuousDays == 2){
            if(idx == 0){
                model.cornerType = CYTBtnCornerTypeTopBottomLeft;
            }else{
                model.cornerType = CYTBtnCornerTypeTopBottomRight;
            }
        }else{
            if (idx == 0) {
                model.cornerType = CYTBtnCornerTypeTopBottomLeft;
            }else if(signNum == continuousDays){
                model.cornerType = CYTBtnCornerTypeTopBottomRight;
            }else{
                model.cornerType = CYTBtnCornerTypeNone;
            }
        }

        //设置签到金币数、“今日”提示或省略
        if (model.btnShowDotLine == YES) {
            model.coinValue = @"";
        }else if (isSignIn && signNum == continuousDays) {
            model.coinValue = @"今日";
        }else if(!isSignIn && signNum == continuousDays + 1){
            model.coinValue = @"今日";
        }else if (signNum < baseDay) {
            model.coinValue = [NSString stringWithFormat:@"+%@",signResultModel.preBaseCoins];
        }else{
            model.coinValue = [NSString stringWithFormat:@"+%@",signResultModel.sufBaseCoins];
        }
        //签到字体特殊显示
        if (signNum == baseDay && continuousDays < baseDay) {
            model.keyCoinValue = YES;
        }else{
            model.keyCoinValue = NO;
        }
    }];
    [self updateSignView];
}
/**
 *  更新视图
 */
- (void)updateSignView{
    [self updateSignDaysUI];
    [self updateSignIndicatorWithIndex:self.currentIndex];
}
/**
 *  更新签到天数/金币个数
 */
- (void)updateSignDaysUI{
    CGFloat totalWidth = kScreenWidth - 2*CYTMarginH;
    CGFloat width = totalWidth/cTotaItems;
    CGFloat viewX = 0;
    CGFloat viewY = 0;
    CGFloat viewW = width;
    CGFloat viewH = CYTAutoLayoutV(kSignViewHeight);
    for (NSInteger index = 0; index<cTotaItems; index++) {
        CYTSignTimeView *signTimeView = CYTSignTimeView.new;
        viewX = index*viewW;
        CYTCoinSignModel *model = self.coinSignModels[index];
        model.hideLeftDotLine = index == 0;
        model.hideRightDotLine = index == cTotaItems - 1;
        signTimeView.coinSignModel = model;
        [self.signTimeBgView addSubview:signTimeView];
        signTimeView.frame = CGRectMake(viewX, viewY, viewW, viewH);
        
        CYTCoinValueView *coinValueView = CYTCoinValueView.new;
        coinValueView.backgroundColor = [UIColor whiteColor];
        coinValueView.coinSignModel = model;
        [self.coinNumBgView addSubview:coinValueView];
        coinValueView.frame = CGRectMake(viewX, viewY, viewW, viewH);
    }
}
/**
 *  更新指示器
 */
- (void)updateSignIndicatorWithIndex:(NSUInteger)index{
    index = index<=0 ? 0 : index;
    CGRect rempRect = self.signIndicator.frame;
    rempRect.origin.x = kSignIndicatorOriginX + index*kSignViewWidth;
    [UIView animateWithDuration:signIndicatorAnimation animations:^{
        self.signIndicator.frame = rempRect;
    }];
}

@end
