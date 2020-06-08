//
//  CYTCardView.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/8/9.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCardView.h"

static NSString *const selectedIcon = @"ic_yes_sel";
static NSString *const unselectedIcon = @"ic_yes_unsel";

static NSString *const unauthorizedImage = @"img_shan_620x780_hl";
static NSString *const carSourceEvaluateImage = @"img_han_620x740_hl";
static NSString *const seekCarEvaluateImage = @"img_sha_620x740_hl";
static NSString *const logisticsImage = @"img_yangwei_620x720_hl";
static NSString *const logisticComment = @"img_yang_620x740_hl";
 
@implementation CYTCardView
{
    //背景
    UIView *_backgroundView;
    //图片
    UIImageView *_contentImageView;
    //按钮
    UIButton *_operationBtn;
    //移除按钮
    UIButton *_removeBtn;
    //选择按钮
    UIButton *_selectedBtn;
    //提示文字
    UILabel *_tipLabel;
}

+ (instancetype)showCardViewWithType:(CYTCardViewType)cardViewType{
    if (cardViewType == CYTCardViewTypeCarSourceEvaluate) {
        if (CYTValueForKey(CYTCardViewCarSourceNeverShowKey))return nil;
    }else if (cardViewType == CYTCardViewTypeSeekCarEvaluate){
        if (CYTValueForKey(CYTCardViewSeekCarNeverShowKey))return nil;
    }else if (cardViewType == CYTCardViewTypeLogisticComment){
        if (CYTValueForKey(CYTCardViewLogisticCommentNeverShowKey))return nil;
    }
    CYTCardView *carView = [[CYTCardView alloc] initWithType:cardViewType];
    carView.frame = kScreenBounds;
    [kWindow addSubview:carView];
    return carView;
}

- (instancetype)initWithType:(CYTCardViewType)cardViewType{
    if (self = [super init]) {
        [self cardViewBasicConfig];
        [self initCardViewComponentsWithType:cardViewType];
        [self makeConstrainsWithType:cardViewType];
    }
    return  self;
}

- (void)setHideRemoveView:(BOOL)hideRemoveView {
    _removeBtn.hidden = YES;
}

/**
 *  基本配置
 */
- (void)cardViewBasicConfig{
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4f];
}
/**
 *  初始化子控件
 */
- (void)initCardViewComponentsWithType:(CYTCardViewType)cardViewType{
    //背景
    UIView *backgroundView = [[UIView alloc] init];
    backgroundView.backgroundColor = [UIColor whiteColor];
    backgroundView.clipsToBounds = YES;
    [self showAnimationWithView:backgroundView];
    [self addSubview:backgroundView];
    _backgroundView = backgroundView;
    
    
    //图片
    UIImageView *contentImageView = [[UIImageView alloc] init];
    [backgroundView addSubview:contentImageView];
    if (cardViewType == CYTCardViewTypeUnauthorized) {
        contentImageView.image = [UIImage imageNamed:unauthorizedImage];
    }else if (cardViewType == CYTCardViewTypeCarSourceEvaluate){
        contentImageView.image = [UIImage imageNamed:carSourceEvaluateImage];
    }else if (cardViewType == CYTCardViewTypeSeekCarEvaluate){
        contentImageView.image = [UIImage imageNamed:seekCarEvaluateImage];
    }else if (cardViewType == CYTCardViewTypeLogisticsServe) {
        contentImageView.image = [UIImage imageNamed:logisticsImage];
    }else if (cardViewType == CYTCardViewTypeLogisticComment){
        contentImageView.image = [UIImage imageNamed:logisticComment];
    }
    _contentImageView = contentImageView;
    
    NSString *btnTitle = [NSString string];
    if (cardViewType == CYTCardViewTypeUnauthorized) {
        btnTitle = @"联系客服";
    }else if (cardViewType == CYTCardViewTypeLogisticsServe) {
        btnTitle = @"打电话";
    }else if (cardViewType == CYTCardViewTypeLogisticComment) {
        [self addNeverShowItemWithType:cardViewType];
        btnTitle = @"去评价";
    }else{
        [self addNeverShowItemWithType:cardViewType];
        btnTitle = @"OK";
    }

     CYTWeakSelf
    //移除按钮
    UIButton *removeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [removeBtn setBackgroundImage:[UIImage imageNamed:@"btn_60delete_dl"] forState:UIControlStateNormal];
    [[removeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self removeCarViewWithComplation:^{
            if (cardViewType == CYTCardViewTypeCarSourceEvaluate) {
                BOOL neverShowAgain = CYTValueForKey(CYTCardViewCarSourceNeverShowKey) != nil;
                !weakSelf.removeBtnClick?:weakSelf.removeBtnClick(neverShowAgain);
            }else if (cardViewType == CYTCardViewTypeSeekCarEvaluate){
                BOOL neverShowAgain = CYTValueForKey(CYTCardViewSeekCarNeverShowKey) != nil;
                !weakSelf.removeBtnClick?:weakSelf.removeBtnClick(neverShowAgain);
            }else if (cardViewType == CYTCardViewTypeLogisticComment){
                BOOL neverShowAgain = CYTValueForKey(CYTCardViewLogisticCommentNeverShowKey) != nil;
                !weakSelf.removeBtnClick?:weakSelf.removeBtnClick(neverShowAgain);
            }else{
                !weakSelf.removeBtnClick?:weakSelf.removeBtnClick(NO);
            }
        }];
    }];
    [self addSubview:removeBtn];
    _removeBtn = removeBtn;
    
   
    //按钮
    UIButton *operationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [operationBtn setBackgroundImage:[UIImage imageNamed:@"btn_green420 × 80_dl"] forState:UIControlStateNormal];
    [operationBtn setTitle:btnTitle forState:UIControlStateNormal];
    operationBtn.titleLabel.font = CYTFontWithPixel(30.f);
    [operationBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [[operationBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [weakSelf removeCarViewWithComplation:^{
            if (cardViewType == CYTCardViewTypeCarSourceEvaluate) {
                BOOL neverShowAgain = CYTValueForKey(CYTCardViewCarSourceNeverShowKey) != nil;
                !weakSelf.operationBtnClick?:weakSelf.operationBtnClick(neverShowAgain);
            }else if (cardViewType == CYTCardViewTypeSeekCarEvaluate){
                BOOL neverShowAgain = CYTValueForKey(CYTCardViewSeekCarNeverShowKey) != nil;
                !weakSelf.operationBtnClick?:weakSelf.operationBtnClick(neverShowAgain);
            }else if (cardViewType == CYTCardViewTypeLogisticComment){
                BOOL neverShowAgain = CYTValueForKey(CYTCardViewLogisticCommentNeverShowKey) != nil;
                !weakSelf.operationBtnClick?:weakSelf.operationBtnClick(neverShowAgain);
            }else{
                !weakSelf.operationBtnClick?:weakSelf.operationBtnClick(NO);
            }
        }];
    }];
    [backgroundView addSubview:operationBtn];
    _operationBtn = operationBtn;
    
    
    //测试数据
//    _contentImageView.image = [UIImage imageWithColor:[UIColor redColor]];
    
}
- (void)addNeverShowItemWithType:(CYTCardViewType)cardViewType{
    CYTWeakSelf
    //选择按钮
    UIButton *selectedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    selectedBtn.adjustsImageWhenHighlighted = NO;
    [selectedBtn setBackgroundImage:[UIImage imageNamed:unselectedIcon] forState:UIControlStateNormal];
    [[selectedBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [weakSelf selectedButtonClickWithType:cardViewType];
    }];
    [_backgroundView addSubview:selectedBtn];
    _selectedBtn = selectedBtn;
    
    //提示文字
    UILabel *tipLabel = [UILabel labelWithText:@"勾选后，该弹窗将不再提示" textColor:CYTHexColor(@"#838383") textAlignment:NSTextAlignmentLeft fontPixel:24.f setContentPriority:YES];
    [tipLabel addTapGestureRecognizerWithTap:^(UITapGestureRecognizer *tap) {
        [weakSelf selectedButtonClickWithType:cardViewType];
    }];
    [_backgroundView addSubview:tipLabel];
    _tipLabel = tipLabel;
}
/**
 *  布局子控件
 */
- (void)makeConstrainsWithType:(CYTCardViewType)cardViewType{
    CGFloat bgViewH = 0.f;
    CGFloat contentImageViewH = 0.f;
    if (cardViewType == CYTCardViewTypeUnauthorized || cardViewType == CYTCardViewTypeLogisticsServe) {
        bgViewH = CYTAutoLayoutV(900.f);
        contentImageViewH = CYTAutoLayoutV(765.f);
    }else{
        bgViewH = CYTAutoLayoutV(920.f);
        contentImageViewH = CYTAutoLayoutV(720.f);
        
        CGFloat selectedBtnWH = CYTAutoLayoutV(28.f);
        CGFloat selectedBtnRMargin = CYTAutoLayoutV(5.f);
        [_tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_operationBtn.mas_bottom).offset(CYTMarginV);
            make.centerX.equalTo(self).offset(selectedBtnWH*0.5 + selectedBtnRMargin*0.5);
        }];
        
        [_selectedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(selectedBtnWH);
            make.centerY.equalTo(_tipLabel);
            make.right.equalTo(_tipLabel.mas_left).offset(-selectedBtnRMargin);
        }];
    }
    [_backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(CYTAutoLayoutV(197.f));
        make.centerX.equalTo(self);
        make.size.equalTo(CGSizeMake(CYTAutoLayoutV(620.f),bgViewH));
        _backgroundView.layer.cornerRadius = 3.f;
        _backgroundView.layer.masksToBounds = YES;
    }];
    
    CGFloat contentImageViewMargin = CYTAutoLayoutV(0.f);
    
    [_contentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(contentImageViewMargin);
        make.right.equalTo(-contentImageViewMargin);
        make.height.equalTo(contentImageViewH);
        _contentImageView.layer.cornerRadius = _backgroundView.layer.cornerRadius;
        _contentImageView.layer.masksToBounds = YES;
    }];
    
    [_operationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(CYTAutoLayoutH(400.f), CYTAutoLayoutV(80.f)));
        make.centerX.equalTo(self);
        make.top.equalTo(_contentImageView.mas_bottom).offset(CYTMarginV);
    }];
    
    [_removeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(CYTAutoLayoutV(60.f));
        make.centerX.equalTo(self);
        make.bottom.equalTo(-CYTAutoLayoutV(107.f));
    }];
}


#pragma mark - 配置

- (void)selectedButtonClickWithType:(CYTCardViewType)cardViewType{
    NSString *imageName = [NSString string];
    if (_selectedBtn.isSelected) {
        _selectedBtn.selected = NO;
        imageName = unselectedIcon;
        if (cardViewType == CYTCardViewTypeSeekCarEvaluate) {
           [CYTCommonTool removeValueForKey:CYTCardViewCarSourceNeverShowKey];
            [CYTCommonTool removeValueForKey:CYTCardViewLogisticCommentNeverShowKey];
        }else if (cardViewType == CYTCardViewTypeCarSourceEvaluate){
            [CYTCommonTool removeValueForKey:CYTCardViewSeekCarNeverShowKey];
            [CYTCommonTool removeValueForKey:CYTCardViewLogisticCommentNeverShowKey];
        }else if (cardViewType == CYTCardViewTypeLogisticComment){
            [CYTCommonTool removeValueForKey:CYTCardViewSeekCarNeverShowKey];
            [CYTCommonTool removeValueForKey:CYTCardViewCarSourceNeverShowKey];
        }
        
    }else{
        _selectedBtn.selected = YES;
        imageName = selectedIcon;
        if (cardViewType == CYTCardViewTypeSeekCarEvaluate) {
             [CYTCommonTool setValue:@"SeekCarNeverShowKey" forKey:CYTCardViewSeekCarNeverShowKey];
        }else if (cardViewType == CYTCardViewTypeCarSourceEvaluate){
            [CYTCommonTool setValue:@"CarSourceNeverShowKey" forKey:CYTCardViewCarSourceNeverShowKey];
        }else if (cardViewType == CYTCardViewTypeLogisticComment){
            [CYTCommonTool setValue:@"cardViewLogisticCommentNeverShowKey" forKey:CYTCardViewLogisticCommentNeverShowKey];
        }
    }
    [_selectedBtn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
}

- (void)showAnimationWithView:(UIView *)view{
    view.center = CGPointMake(kWindow.center.x, -view.bounds.size.height/2);
    view.transform = CGAffineTransformMakeRotation(-M_1_PI / 2);
    [UIView animateWithDuration:kAnimationDurationInterval delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        view.transform = CGAffineTransformMakeRotation(0);
        view.center = kWindow.center;
    } completion:nil];
}

- (void)dismissAnimationWithView:(UIView *)view complation:(void(^)())complation{
    _removeBtn.alpha = 0.f;
    [UIView animateWithDuration:kAnimationDurationInterval + 0.1f delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        view.center = CGPointMake(kWindow.center.x, kWindow.bounds.size.height+view.bounds.size.height);
        view.transform = CGAffineTransformMakeRotation(M_1_PI / 1.5);
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0f];
    } completion:^(BOOL finished) {
        if (complation) {
            complation();
        }
        [self removeFromSuperview];
    }];
}

- (void)removeCarViewWithComplation:(void(^)())complation{
    [self dismissAnimationWithView:_backgroundView complation:complation];
}

@end
