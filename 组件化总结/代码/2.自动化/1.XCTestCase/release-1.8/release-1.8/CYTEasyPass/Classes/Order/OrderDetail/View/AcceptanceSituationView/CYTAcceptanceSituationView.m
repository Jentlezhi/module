//
//  CYTAcceptanceSituationView.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/9/6.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTAcceptanceSituationView.h"
#import "CYTOrderModel.h"

@interface CYTAcceptanceSituationView()

/** 分割条 */
@property(strong, nonatomic) UIView *topBar;
/** 绿色分隔条 */
@property(strong, nonatomic) UIView *dividerBar;
/** 标题 */
@property(strong, nonatomic) UILabel *contentLabel;

@end

@implementation CYTAcceptanceSituationView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self acceptanceSituationBasicConfig];
        [self addAcceptanceSituationComponents];
        [self makeConstrains];
    }
    return  self;
}

#pragma mark - 懒加载

- (UIView *)topBar{
    if (!_topBar) {
        _topBar = [[UIView alloc] init];
        _topBar.backgroundColor = kFFColor_bg_nor;
    }
    return _topBar;
}
- (UIView *)dividerBar{
    if (!_dividerBar) {
        _dividerBar = [[UIView alloc] init];
        _dividerBar.backgroundColor = CYTHexColor(@"#2CB63E");
    }
    return _dividerBar;
}
- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [UILabel labelWithTextColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentLeft fontPixel:28.f setContentPriority:YES];
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}
/**
 *  基本配置
 */
- (void)acceptanceSituationBasicConfig{
    self.backgroundColor = [UIColor whiteColor];
}

/**
 *  添加子控件
 */
- (void)addAcceptanceSituationComponents{
    [self addSubview:self.topBar];
    [self addSubview:self.dividerBar];
    [self addSubview:self.contentLabel];
}
/**
 *  布局子控件
 */
- (void)makeConstrains{
    [self.topBar makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.equalTo(CYTAutoLayoutV(20));
    }];
    
    [self.dividerBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTMarginH);
        make.width.equalTo(CYTAutoLayoutH(6));
        make.top.equalTo(_topBar.mas_bottom).offset(CYTAutoLayoutV(23.f));
        make.height.equalTo(CYTAutoLayoutV(40.f));
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_dividerBar.mas_right).offset(CYTAutoLayoutH(14.f));
        make.top.equalTo(_topBar.mas_bottom).offset(CYTAutoLayoutV(26.f));
        make.right.equalTo(-CYTMarginH);
        make.bottom.equalTo(self).offset(-CYTAutoLayoutV(26.f));
    }];
}


- (void)setOrderModel:(CYTOrderModel *)orderModel{
    _orderModel = orderModel;
    self.contentLabel.text = orderModel.additionalDesc;
}

@end
