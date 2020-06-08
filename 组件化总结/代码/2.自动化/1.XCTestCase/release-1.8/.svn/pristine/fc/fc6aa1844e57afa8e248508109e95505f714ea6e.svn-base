//
//  CYTNoNetworkView.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/5/9.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTNoNetworkView.h"

@interface CYTNoNetworkView()

/** 重新加载按钮 */
@property(strong, nonatomic) UIButton *reLoadBtn;
/** wifi图标 */
@property(strong, nonatomic) UIImageView *noWifiIcon;
/** 文字提示 */
@property(strong, nonatomic) UILabel *tipLabel;

@end

@implementation CYTNoNetworkView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self noNetworkViewBasicConfig];
        [self initNoNetworkViewComponents];
        [self makeConstrains];
    }
    return  self;
}

/**
 *  基本配置
 */
- (void)noNetworkViewBasicConfig{
    self.backgroundColor = CYTLightGrayColor;
    self.userInteractionEnabled = YES;
}

/**
 *  初始化子控件
 */
- (void)initNoNetworkViewComponents{
    [self addSubview:self.noWifiIcon];
    [self addSubview:self.tipLabel];
    [self addSubview:self.reLoadBtn];
}
/**
 *  文字富文本
 */
- (NSMutableAttributedString *)attributedStringWithString:(NSString *)content{
    NSMutableAttributedString *mString = [[NSMutableAttributedString alloc] initWithString:content];
    CGFloat lineSpace = CYTAutoLayoutV(10);
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [mString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, mString.length)];
    return mString;
}
/**
 *  布局子控件
 */
- (void)makeConstrains{
    [self.noWifiIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(CYTAutoLayoutV(240.f));
        make.width.equalTo(CYTAutoLayoutV(140.f));
        make.height.equalTo(CYTAutoLayoutV(120.f));
        make.centerX.equalTo(self);
    }];
    
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_noWifiIcon.mas_bottom).offset(CYTItemMarginV);
        make.centerX.equalTo(self);
        make.height.equalTo((self.tipLabel.font.pointSize+2)*2+CYTAutoLayoutV(10)+CYTAutoLayoutV(35.f));
    }];
    
    [self.reLoadBtn makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(CYTAutoLayoutH(180), CYTAutoLayoutV(64)));
        make.top.equalTo(self.tipLabel.mas_bottom).offset(CYTAutoLayoutV(40));
        make.centerX.equalTo(self);
    }];
}

#pragma mark - 懒加载

- (UIImageView *)noWifiIcon{
    if (!_noWifiIcon) {
        _noWifiIcon = [[UIImageView alloc] init];
        _noWifiIcon.image = [UIImage imageNamed:@"img_nonetwork_hl"];
    }
    return _noWifiIcon;
}
- (UILabel *)tipLabel{
    if (!_tipLabel) {
        _tipLabel = [UILabel labelWithTextColor:CYTHexColor(@"#B6B6B6") textAlignment:NSTextAlignmentCenter fontPixel:28.f setContentPriority:YES];
        _tipLabel.numberOfLines = 0;
        NSString *content = @"Sorry 网络出问题了\n - 请稍后再试吧 -";
        _tipLabel.attributedText = [self attributedStringWithString:content];
    }
    return _tipLabel;
}

- (UIButton *)reLoadBtn{
    if (!_reLoadBtn) {
        _reLoadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _reLoadBtn.adjustsImageWhenHighlighted = NO;
        [_reLoadBtn setTitle:@"点击加载" forState:UIControlStateNormal];
        [_reLoadBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_reLoadBtn setBackgroundImage:[UIImage imageWithColor:CYTGreenNormalColor] forState:UIControlStateNormal];
        _reLoadBtn.layer.cornerRadius = 4;
        _reLoadBtn.layer.masksToBounds = YES;
        _reLoadBtn.titleLabel.font = CYTFontWithPixel(30.f);
        CGFloat margin = CYTAutoLayoutV(8.f);
        _reLoadBtn.contentEdgeInsets = UIEdgeInsetsMake(margin, margin, margin, margin);
        [[_reLoadBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            !self.reloadData?:self.reloadData();
        }];
    }
    return _reLoadBtn;
}

- (void)setHomeLayout:(BOOL)homeLayout{
    _homeLayout = homeLayout;
    if (homeLayout) {
        self.tipLabel.font = CYTFontWithPixel(24.f);
        self.reLoadBtn.titleLabel.font = CYTFontWithPixel(24.f);
        [self.noWifiIcon mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(CYTAutoLayoutV(50.f));
            make.width.equalTo(CYTAutoLayoutV(140.f)*0.8f);
            make.height.equalTo(CYTAutoLayoutV(120.f)*0.8f);
            make.centerX.equalTo(self);
        }];
        
        [self.tipLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_noWifiIcon.mas_bottom).offset(CYTAutoLayoutV(20.f)*0.5f);
            make.centerX.equalTo(self);
            make.height.equalTo((self.tipLabel.font.pointSize+2)*2+CYTAutoLayoutV(10)+CYTAutoLayoutV(35.f));
        }];
        
        [self.reLoadBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.tipLabel.mas_bottom).offset(CYTAutoLayoutV(10.f));
            make.centerX.equalTo(self);
        }];
    }
}

@end
