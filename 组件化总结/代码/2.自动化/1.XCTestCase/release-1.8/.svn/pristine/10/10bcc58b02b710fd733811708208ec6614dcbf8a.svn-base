//
//  CYTCoinCardView.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/11/13.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCoinCardView.h"
#import "CYTCoinSignResultModel.h"
#import "CYTGoodsModel.h"
#import "CYTGetCoinModel.h"

@interface CYTCoinCardView()<CAAnimationDelegate,UIWebViewDelegate>
/** 背景 */
@property(strong, nonatomic) UIView *bgView;
/** 图片 */
@property(strong, nonatomic) UIImageView *iconView;
/** 标题 */
@property(strong, nonatomic) UILabel *titleLabel;
/** 内容1 */
@property(strong, nonatomic) UILabel *contentLabel1;
/** 内容2 */
@property(strong, nonatomic) UILabel *contentLabel2;
/** 内容3 */
@property(strong, nonatomic) UILabel *contentLabel3;
/** 内容4 */
@property(strong, nonatomic) UILabel *contentLabel4;
/** 内容背景 */
@property(strong, nonatomic) UIView *contentBgView;
/** htmlView */
@property(strong, nonatomic) UIWebView *contentHtmlView;
/** 移除按钮 */
@property(strong, nonatomic) UIButton *removeBtn;
@end

@implementation CYTCoinCardView

+ (instancetype)showSuccessWithType:(CYTCoinCardType)coinCardType model:(id)model{
    for (UIView *itemView in kWindow.subviews) {
        if ([itemView isKindOfClass:[self class]]) {
            [itemView removeFromSuperview];
        }
    }
    CYTCoinCardView *coinCardView = [[CYTCoinCardView alloc] init];
    [coinCardView setValueWithType:coinCardType model:model];
    [coinCardView makeSubConstrainsWithType:coinCardType];
    coinCardView.frame = kScreenBounds;
    [kWindow addSubview:coinCardView];
    return coinCardView;
}

- (void)basicConfig{
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6f];
    CYTWeakSelf
    [self addTapGestureRecognizerWithTap:^(UITapGestureRecognizer *tap) {
        [weakSelf dismissAnimationWithView:weakSelf.bgView complation:nil];
    }];
}

- (void)initSubComponents{
    [self addSubview:self.bgView];
    [self showAnimationWithView:self.bgView];
    [self.bgView addSubview:self.iconView];
    [self.bgView addSubview:self.titleLabel];
    [self.iconView addSubview:self.titleLabel];
    [self.bgView addSubview:self.contentLabel1];
    [self.bgView addSubview:self.contentLabel2];
    [self.bgView addSubview:self.contentLabel3];
    [self.bgView addSubview:self.contentLabel4];
    [self.bgView addSubview:self.contentBgView];
    [self.contentBgView addSubview:self.titleLabel];
    [self.contentBgView addSubview:self.contentHtmlView];
    [self addSubview:self.removeBtn];
}

- (void)setValueWithType:(CYTCoinCardType)type model:(id)model{
    if (type == CYTCoinCardTypeSignSuccess) {
        CYTCoinSignResultModel *signResultModel = (CYTCoinSignResultModel *)model;
        self.titleLabel.text = @"签到成功";
        NSString *key1= [NSString stringWithFormat:@"+%@",signResultModel.rewardValue];
        NSString *content1 = [NSString stringWithFormat:@"恭喜您今日 %@ 易车币",key1];
        NSMutableAttributedString *attributeStr1 = [NSMutableAttributedString attributedStringWithContent:content1 keyWord:key1 keyFontPixel:36.f keyWordColor:CYTHexColor(@"#F1D239")];
        self.contentLabel1.attributedText = attributeStr1;

        NSUInteger todayContinuousDays = signResultModel.continuousDays;
        NSUInteger baseDay = [signResultModel.baseDay integerValue];
        NSString *key2= [NSString stringWithFormat:@"%ld",(unsigned long)todayContinuousDays];
        NSString *content2 = [NSString stringWithFormat:@"已连续签到 %@ 天",key2];
        NSMutableAttributedString *attributeStr2 = [NSMutableAttributedString attributedStringWithContent:content2 keyWord:key2 keyFontPixel:36.f keyWordColor:CYTHexColor(@"#F1D239")];
        self.contentLabel2.attributedText = attributeStr2;

        NSString *key3;
        NSString *contentPar;
        if (todayContinuousDays < baseDay) {
           NSString *baseDayC = [CYTCommonTool translationArabicNumerWithNum:baseDay];
            contentPar = [NSString stringWithFormat:@"连续签到至第%@天可",baseDayC];
            key3 = [NSString stringWithFormat:@"+%@",signResultModel.sufBaseCoins];
        }else{
            contentPar = @"明日签到可";
            key3 = [NSString stringWithFormat:@"+%@",signResultModel.nextRewardValue];
        }
        NSString *content3 = [NSString stringWithFormat:@"%@ %@ 易车币",contentPar,key3];
        NSMutableAttributedString *attributeStr3 = [NSMutableAttributedString attributedStringWithContent:content3 keyWord:key3 keyFontPixel:36.f keyWordColor:CYTHexColor(@"#F1D239")];
        self.contentLabel3.attributedText = attributeStr3;
        self.iconView.image = [UIImage imageNamed:@"pic_qiandao_nor"];
    }else if (type == CYTCoinCardTypeExchangeSuccess){
        CYTGoodsModel *goodsModel = (CYTGoodsModel *)model;
        self.titleLabel.text = @"兑换成功";
        self.iconView.image = [UIImage imageNamed:@"pic_shangpin_nor"];
        NSString *key1= [NSString stringWithFormat:@"%@元",goodsModel.faceValue];
        NSString *name = goodsModel.name;
        NSString *content1 = [NSString stringWithFormat:@"恭喜成功兑换 %@ %@，\n请您去我的卡券查看",key1,name];
        NSMutableAttributedString *attributeStr1 = [NSMutableAttributedString attributedStringWithContent:content1 keyWord:key1 keyFontPixel:36.f keyWordColor:CYTHexColor(@"#F1D239")];
        self.contentLabel1.numberOfLines = 0;
        self.contentLabel1.attributedText = attributeStr1;
    }else if (type == CYTCoinCardTypeGetSuccess){
        CYTGetCoinModel *getCoinModel = (CYTGetCoinModel *)model;
        self.iconView.image = [UIImage imageNamed:@"pic_qiandao_nor"];
        self.titleLabel.text = @"领取成功";
        NSString *key1= [NSString stringWithFormat:@"%@",getCoinModel.rewardValue];
        NSString *content1 = [NSString stringWithFormat:@"恭喜成功领取%@易车币",key1];
        NSMutableAttributedString *attributeStr1 = [NSMutableAttributedString attributedStringWithContent:content1 keyWord:key1 keyFontPixel:36.f keyWordColor:CYTHexColor(@"#F1D239")];
        self.contentLabel1.attributedText = attributeStr1;
    }else if (type == CYTCoinCardTypeTaskSpecification){
        NSString *htmlString;
        if ([model isKindOfClass:[NSString class]]) {
            htmlString = (NSString *)model;
        }else{
            htmlString = @"";
        }
        self.iconView.image = [UIImage imageNamed:@"pic_task_nor"];
        self.titleLabel.text = @"任务说明";
        self.titleLabel.textColor = CYTHexColor(@"#B1A48A");
        self.titleLabel.font = CYTBoldFontWithPixel(40.f);
        [self.bgView addTapGestureRecognizerWithTap:nil];
        self.bgView.layer.cornerRadius = 6;
        self.bgView.layer.masksToBounds = YES;
//        NSAttributedString *attriString = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType} documentAttributes:nil error:nil];
        [self.contentHtmlView loadHTMLString:htmlString baseURL:nil] ;
    }else if (type == CYTCoinCardTypeTaskCompletion){
        NSString *msg = (NSString *)model;
        self.iconView.image = [UIImage imageNamed:@"carSource_publish_success"];
        self.titleLabel.text = msg.length?msg:@"";
        self.titleLabel.font = CYTBoldFontWithPixel(42.f);
    }else if (type == CYTCoinCardTypeExpiredDesc){
        self.iconView.image = [UIImage imageNamed:@"pic_explain_nor"];
        self.titleLabel.text = @"易车币过期说明";
        self.titleLabel.textColor = CYTHexColor(@"#B1A48A");
        self.titleLabel.font = CYTBoldFontWithPixel(40.f);
        [self.bgView addTapGestureRecognizerWithTap:nil];
        self.bgView.layer.cornerRadius = 6;
        self.bgView.layer.masksToBounds = YES;

        NSString *htmlString = [NSString stringWithFormat:@"<!DOCTYPE html><html lang=\"en\"><head><meta charset=\"UTF-8\"><title></title><style>body{padding: 0px;}img{width: 100%%;height: auto;}</style></head><body>%@</body></html>",@"<!DOCTYPE html><html><head><meta http-equiv='Content-Type' content='text/html; charset=utf-8' /><meta name='viewport' content='width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no'><title>Desc</title><style> ul li {color: #8D7951;} ul li span { color: #333; font-size: 15px;letter-spacing: -0.72px;}</style></head><body><ul> <li style='margin-bottom:32px;margin-top:40px;padding-right:10px'><span>您本年度获得的易车币，会在第二年结束时过期，请您及时使用。</span></li> </ul></body></html>"];
//        NSAttributedString *attriString = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType} documentAttributes:nil error:nil];
        [self.contentHtmlView loadHTMLString:htmlString baseURL:nil];
//        self.contentHtmlView.attributedText = attriString;
    }

}

- (void)makeSubConstrainsWithType:(CYTCoinCardType)type{
    if (type == CYTCoinCardTypeSignSuccess) {
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(CYTAutoLayoutV(322.f));
            make.left.equalTo(CYTAutoLayoutV(75.f));
            make.right.equalTo(-CYTAutoLayoutV(75.f));
            make.bottom.equalTo(self.removeBtn.mas_top).offset(-CYTMarginV);
        }];

        [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(CYTAutoLayoutV(600.f), CYTAutoLayoutV(420.f)));
            make.top.centerX.equalTo(self.bgView);
        }];

        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.iconView);
            make.bottom.equalTo(-CYTAutoLayoutV(35.f));
        }];

        [self.contentLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(CYTAutoLayoutV(436.f));
            make.centerX.equalTo(self.bgView);
        }];

        [self.contentLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentLabel1.mas_bottom).offset(CYTItemMarginV);
            make.centerX.equalTo(self.bgView);
        }];

        [self.contentLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentLabel2.mas_bottom).offset(CYTItemMarginV);
            make.centerX.equalTo(self.bgView);
        }];

        [self.contentLabel4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentLabel3.mas_bottom).offset(CYTItemMarginV);
            make.centerX.equalTo(self.bgView);
        }];
    }else if (type == CYTCoinCardTypeExchangeSuccess){
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(CYTAutoLayoutV(242.f));
            make.left.equalTo(CYTAutoLayoutV(75.f));
            make.right.equalTo(-CYTAutoLayoutV(75.f));
            make.bottom.equalTo(self.removeBtn.mas_top).offset(-CYTMarginV);
        }];

        [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(CYTAutoLayoutV(600.f), CYTAutoLayoutV(500.f)));
            make.top.centerX.equalTo(self.bgView);
        }];

        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.iconView);
            make.bottom.equalTo(self.iconView);
        }];

        [self.contentLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.bgView);
            make.top.equalTo(self.titleLabel.mas_bottom).offset(CYTAutoLayoutV(42.f));
        }];
    }else if (type == CYTCoinCardTypeGetSuccess){
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(CYTAutoLayoutV(322.f));
            make.left.equalTo(CYTAutoLayoutV(75.f));
            make.right.equalTo(-CYTAutoLayoutV(75.f));
            make.bottom.equalTo(self.removeBtn.mas_top).offset(-CYTMarginV);
        }];

        [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(CYTAutoLayoutV(600.f), CYTAutoLayoutV(420.f)));
            make.top.centerX.equalTo(self.bgView);
        }];

        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.iconView);
            make.bottom.equalTo(-CYTAutoLayoutV(35.f));
        }];

        [self.contentLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.iconView.mas_bottom).offset(CYTItemMarginV);
            make.centerX.equalTo(self.bgView);
        }];
    }else if (type == CYTCoinCardTypeTaskSpecification || type == CYTCoinCardTypeExpiredDesc){
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(CYTAutoLayoutV(317.f));
            make.left.equalTo(CYTAutoLayoutV(85.f));
            make.right.equalTo(-CYTAutoLayoutV(85.f));
            make.height.equalTo(CYTAutoLayoutV(530.f));
        }];

        [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(CYTAutoLayoutV(580.f), CYTAutoLayoutV(170.f)));
            make.top.centerX.equalTo(self.bgView);
        }];

         [self.contentBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.bgView);
            make.top.equalTo(self.iconView.mas_bottom).offset(-1.f);;
            make.bottom.equalTo(self.bgView);
         }];

        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.top.equalTo(self.contentBgView);
        }];

        [self.contentHtmlView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(CYTItemMarginV);
            make.left.right.equalTo(self.contentBgView);
            make.bottom.equalTo(-CYTItemMarginV);
        }];
    }else if (type == CYTCoinCardTypeTaskCompletion){
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(CYTAutoLayoutV(300.f));
            make.left.equalTo(CYTAutoLayoutV(75.f));
            make.right.equalTo(-CYTAutoLayoutV(75.f));
            make.bottom.equalTo(self.removeBtn.mas_top).offset(-CYTMarginV);
        }];

        [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(CYTAutoLayoutV(278.f), CYTAutoLayoutV(196.f)));
            make.centerX.equalTo(self.bgView);
            make.top.equalTo(CYTAutoLayoutV(100.f));
        }];

        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.iconView);
            make.top.equalTo(self.iconView.mas_bottom).offset(CYTAutoLayoutV(100.f));
        }];
    }
    [self.removeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(CYTAutoLayoutV(60.f));
        make.centerX.equalTo(self);
        make.bottom.equalTo(-CYTAutoLayoutV(197.f));
    }];
}

#pragma mark - 懒加载

- (UIView *)bgView{
    if (!_bgView) {
        _bgView = UIView.new;
        _bgView.backgroundColor = [UIColor clearColor];
        _bgView.clipsToBounds = YES;
    }
    return _bgView;
}
- (UIImageView *)iconView{
    if (!_iconView) {
        _iconView = UIImageView.new;
    }
    return _iconView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel labelWithTextColor:CYTHexColor(@"#FFFFFF") textAlignment:NSTextAlignmentCenter font:CYTBoldFontWithPixel(46.f) setContentPriority:NO];
    }
    return _titleLabel;
}

- (UILabel *)contentLabel1{
    if (!_contentLabel1) {
        _contentLabel1 = [UILabel labelWithTextColor:CYTHexColor(@"#FFFFFF") textAlignment:NSTextAlignmentCenter fontPixel:30.f setContentPriority:NO];
    }
    return _contentLabel1;
}
- (UILabel *)contentLabel2{
    if (!_contentLabel2) {
        _contentLabel2 = [UILabel labelWithTextColor:CYTHexColor(@"#FFFFFF") textAlignment:NSTextAlignmentCenter fontPixel:30.f setContentPriority:NO];
    }
    return _contentLabel2;
}
- (UILabel *)contentLabel3{
    if (!_contentLabel3) {
        _contentLabel3 = [UILabel labelWithTextColor:CYTHexColor(@"#FFFFFF") textAlignment:NSTextAlignmentCenter fontPixel:30.f setContentPriority:NO];
    }
    return _contentLabel3;
}
- (UILabel *)contentLabel4{
    if (!_contentLabel4) {
        _contentLabel4 = [UILabel labelWithText:@"中间断掉要重新来过哦~" textColor:CYTHexColor(@"#FFFFFF") textAlignment:NSTextAlignmentCenter fontPixel:30.f setContentPriority:NO];
    }
    return _contentLabel4;
}
- (UIView *)contentBgView{
    if (!_contentBgView) {
        _contentBgView = UIView.new;
        _contentBgView.backgroundColor = [UIColor whiteColor];
    }
    return _contentBgView;
}

- (UIWebView *)contentHtmlView{
    if(!_contentHtmlView){
        _contentHtmlView = [[UIWebView alloc] init];
        _contentHtmlView.scrollView.bounces = NO;
        _contentHtmlView.delegate = self;
        _contentHtmlView.opaque = NO;
        _contentHtmlView.backgroundColor = [UIColor clearColor];
        _contentHtmlView.scalesPageToFit = YES;
    }
    return _contentHtmlView;
}
- (UIButton *)removeBtn{
    if (!_removeBtn) {
        _removeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _removeBtn.hidden = YES;
        _removeBtn.enabled = NO;
        _removeBtn.adjustsImageWhenDisabled = NO;
        [_removeBtn setBackgroundImage:[UIImage imageNamed:@"btn_60delete_dl"] forState:UIControlStateNormal];
    }
    return _removeBtn;
}

#pragma mark - 其他配置
- (void)showAnimationWithView:(UIView *)view{
   CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = 0.5f;
    popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DIdentity]];
    popAnimation.keyTimes = @[@0.25f, @0.5f, @0.75f, @1.f];
    popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kAnimationDurationInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.removeBtn.hidden = NO;
    });
    [view.layer addAnimation:popAnimation forKey:nil];
}

- (void)dismissAnimationWithView:(UIView *)view complation:(void(^)())complation{
    self.removeBtn.alpha = 0.f;
    [UIView animateWithDuration:0.5f animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0f];
    }];
    CAKeyframeAnimation *hideAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    hideAnimation.duration = kAnimationDurationInterval;
    hideAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
                             [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0f, 1.0f, 1.0f)],
                             [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.8f, 0.8f, 1.0f)],
                             [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.00f, 0.00f, 0.00f)]];
    hideAnimation.keyTimes = @[@0.25f, @0.5f, @0.75f];
    hideAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                      [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                      [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                      [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    hideAnimation.delegate = self;
    [view.layer addAnimation:hideAnimation forKey:nil];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.contentHtmlView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    [self.contentHtmlView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
    NSString *meta = [NSString stringWithFormat:@"document.getElementsByName(\"viewport\")[0].content = \"width=%f, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no\"", webView.frame.size.width];
    [webView stringByEvaluatingJavaScriptFromString:meta];
}


- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    !self.completion?:self.completion();
    [self removeFromSuperview];
}

@end
