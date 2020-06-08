//
//  CYTMyCouponCardTagView.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/6/27.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTMyCouponCardTagView.h"
#import "CYTCouponTagModel.h"

int const tagBegin = 10000;

@interface CYTMyCouponCardTagView()

/** 我的卡券标题 */
@property(strong, nonatomic) NSArray *myCouponTags;
/** 选择卡券标题 */
@property(strong, nonatomic) NSArray *selectCouponTags;
/** 标签控件 */
@property(strong, nonatomic) NSMutableArray *tagLabels;
/** 卡券模式 */
@property(assign, nonatomic) CYTMyCouponCardType myCouponCardType;

@end

@implementation CYTMyCouponCardTagView
{
    //未使用标签
    UILabel *_noUseTagLabel;
    //已使用标签
    UILabel *_usedTagLabel;
    //已过期
    UILabel *_expireTagLabel;
    //索引条
    UIView *_indexBarView;
}

- (NSArray *)myCouponTags{
    if (!_myCouponTags) {
        _myCouponTags = @[@"未使用(0)",@"已使用(0)",@"已过期(0)"];
    }
    return _myCouponTags;
}

- (NSArray *)selectCouponTags{
    if (!_selectCouponTags) {
        _selectCouponTags = @[@"可用券(0)",@"不可使用(0)"];
    }
    return _selectCouponTags;
}

- (NSMutableArray *)tagLabels{
    if (!_tagLabels) {
        _tagLabels = [NSMutableArray array];
    }
    return _tagLabels;
}

- (instancetype)initWithCouponCardType:(CYTMyCouponCardType)aCouponCardType{
    if (self = [super init]) {
        self.myCouponCardType = aCouponCardType;
        [self myCouponCardTagBasicConfig];
        [self initComponentsWithCouponCardType:aCouponCardType];
        [self makeConstrainsWithCouponCardType:aCouponCardType];
    }
    return self;
}
/**
 *  基本配置
 */
- (void)myCouponCardTagBasicConfig{
    self.backgroundColor = [UIColor whiteColor];
}
/**
 *  初始化子控件
 */
- (void)initComponentsWithCouponCardType:(CYTMyCouponCardType)couponCardType{
    //添加标签
    NSInteger tagsTotalNum = 0;
    NSArray *tagsArray = [NSArray array];
    if (couponCardType == CYTMyCouponCardTypeDefault) {
        tagsTotalNum = 3;
        tagsArray = [self.myCouponTags copy];
    }else{
        tagsTotalNum = 2;
        tagsArray = [self.selectCouponTags copy];
    }
    for (NSInteger index = 0; index < tagsTotalNum; index++) {
       UILabel *tagLabel = [UILabel labelWithTextColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentCenter fontPixel:30.f setContentPriority:NO];
        tagLabel.text = tagsArray[index];
        tagLabel.tag = tagBegin + index;
        [self addSubview:tagLabel];
        CYTWeakSelf
        [tagLabel makeConstraints:^(MASConstraintMaker *make) {
            if (index > 0) {
                UILabel *priorLabel = [weakSelf.tagLabels lastObject];
                make.left.equalTo(priorLabel.mas_right);
            }else{
                tagLabel.textColor = CYTHexColor(@"#333333");
                make.left.equalTo(self);
            }
            make.top.bottom.equalTo(self);
            make.width.equalTo(self).dividedBy(tagsTotalNum);
            [weakSelf.tagLabels addObject:tagLabel];
        }];
        
        //点击的处理
        [tagLabel addTapGestureRecognizerWithTap:^(UITapGestureRecognizer *tap) {
            [weakSelf updateTagAndIndexWithIndex:index completion:^{
                !weakSelf.indicatorClicked?:weakSelf.indicatorClicked(index);
            }];
        }];
    }
    
    //索引条
    UIView *indexBarView = [[UIView alloc] init];
    indexBarView.backgroundColor = CYTGreenNormalColor;
    [self addSubview:indexBarView];
    _indexBarView = indexBarView;
}

/**
 *  布局子控件
 */
- (void)makeConstrainsWithCouponCardType:(CYTMyCouponCardType)couponCardType{
    CGFloat indexBarH = CYTAutoLayoutV(2);
    NSInteger tagsTotalNum = 0;
    CGFloat defaultOffsetX = 0;
    if (couponCardType == CYTMyCouponCardTypeDefault) {
        tagsTotalNum = 3;
        defaultOffsetX = kScreenWidth/tagsTotalNum;
    }else{
        tagsTotalNum = 2;
        defaultOffsetX = kScreenWidth/4;
    }
    [_indexBarView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self).offset(-defaultOffsetX);
        make.width.equalTo(CYTAutoLayoutV(150.f));
        make.height.equalTo(indexBarH);
        make.bottom.equalTo(self.bottom).offset(-indexBarH);
    }];
}

- (void)setCurrentIndex:(NSInteger)currentIndex{
    _currentIndex = currentIndex;
    [self updateTagAndIndexWithIndex:currentIndex completion:nil];
    
}

#pragma mark - 更新布局

- (void)updateTagAndIndexWithIndex:(NSInteger)currentIndex completion:(void(^)())completion{
    //更新标签
    [self updateTagWithIndex:currentIndex];
    //更新约束
    [self updateIndexBarConstraisWithIndex:currentIndex couponCardType:self.myCouponCardType completion:completion];
}
/**
 *  更新索引条约束
 */
- (void)updateIndexBarConstraisWithIndex:(NSInteger)index couponCardType:(CYTMyCouponCardType)couponCardType completion:(void(^)())completion{
    NSInteger tagsTotalNum = couponCardType == CYTMyCouponCardTypeDefault ? 3 : 2;
    CGFloat cardViewWidth = kScreenWidth/tagsTotalNum;
    CGFloat offsetX = 0;
    if (couponCardType == CYTMyCouponCardTypeDefault) {
        if (index == 0) {
            offsetX = -cardViewWidth;
        }else if (index == 1){
            offsetX = 0;
        }else{
            offsetX = cardViewWidth;
        }
        
    }else{
        if (index == 0){
            offsetX = -cardViewWidth*0.5;
        }else{
            offsetX = cardViewWidth*0.5;
        }
    }
    [_indexBarView updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self).offset(offsetX);
    }];
    CYTWeakSelf
    [UIView animateWithDuration:kAnimationDurationInterval animations:^{
        [weakSelf layoutIfNeeded];
    }completion:^(BOOL finished) {
        !completion?:completion();
    }];
}
/**
 *  更新当前标签
 */
- (void)updateTagWithIndex:(NSInteger)index{
    NSInteger tagsNum = self.tagLabels.count;
    if (index>(int)tagsNum)return;
    UILabel *label = self.tagLabels[index];
    for (UILabel *itemLabel in self.tagLabels) {
        if ([itemLabel isEqual:label]) {
            itemLabel.textColor = CYTHexColor(@"#333333");
            itemLabel.font = CYTFontWithPixel(30.f);
        }else{
            itemLabel.textColor = CYTHexColor(@"#666666");
            itemLabel.font = CYTFontWithPixel(28.f);
        }
    }
}
/**
 *  更新当前标签显示
 */
- (void)setCouponTagModel:(CYTCouponTagModel *)couponTagModel{
    _couponTagModel = couponTagModel;
    if (self.myCouponCardType == CYTMyCouponCardTypeDefault) {
        UILabel *unusedTagLabel = [self.tagLabels firstObject];
        unusedTagLabel.text = couponTagModel.unusedTag;
        
        UILabel *usedTagLabel = self.tagLabels[1];
        usedTagLabel.text = couponTagModel.usedTag;
        
        UILabel *expiredTagLabel = [self.tagLabels lastObject];
        expiredTagLabel.text = couponTagModel.expiredTag;
    }else{
        UILabel *usableLabel = [self.tagLabels firstObject];
        usableLabel.text = couponTagModel.usableTag;
        
        UILabel *disUsableLabel = [self.tagLabels lastObject];
        disUsableLabel.text = couponTagModel.disableTag;
    }

    
}

@end
