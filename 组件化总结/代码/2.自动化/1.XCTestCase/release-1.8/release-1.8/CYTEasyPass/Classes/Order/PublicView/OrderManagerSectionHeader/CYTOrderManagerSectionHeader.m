//
//  CYTCancelOrderSetionHeader.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/17.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTOrderManagerSectionHeader.h"
#import "CYTOrderExtendSectionModel.h"

@interface CYTOrderManagerSectionHeader()
/** 分组标题 */
@property(weak, nonatomic) UILabel *sectionTitleLabel;

@end

@implementation CYTOrderManagerSectionHeader
{
    
    //分割条
    UIView *_topBar;
    //绿色分隔条
    UIView *_dividerBar;
    //分割线
    UILabel *_lineLabel;

}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self orderManagerBasicConfig];
        [self initOrderManagerComponents];
        [self makeConstrains];
    }
    return  self;
}
/**
 *  基本配置
 */
- (void)orderManagerBasicConfig{
    self.backgroundColor = [UIColor whiteColor];
}

/**
 *  初始化子控件
 */
- (void)initOrderManagerComponents{
    //分割条
    UIView *topBar = [[UIView alloc] init];
    topBar.backgroundColor = kFFColor_bg_nor;
    [self addSubview:topBar];
    _topBar = topBar;
    //绿色分隔条
    UIView *dividerBar = [[UIView alloc] init];
    dividerBar.backgroundColor = CYTHexColor(@"#2cb73f");
    [self addSubview:dividerBar];
    _dividerBar = dividerBar;
    
    //内容
    UILabel *sectionTitleLabel = [[UILabel alloc] init];
    sectionTitleLabel.textColor = [UIColor colorWithHexColor:@"#333333"];
    sectionTitleLabel.font = CYTFontWithPixel(28.f);
    sectionTitleLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:sectionTitleLabel];
    _sectionTitleLabel = sectionTitleLabel;

    
    //分割线
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.backgroundColor = [UIColor colorWithHexColor:@"#efefef"];
    [self addSubview:lineLabel];
    _lineLabel = lineLabel;
}

/**
 *  布局子控件
 */
- (void)makeConstrains{
    [_topBar makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.equalTo(CYTAutoLayoutV(20));
    }];
    [_dividerBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTMarginH);
        make.width.equalTo(CYTAutoLayoutH(6));
        make.top.equalTo(_topBar.mas_bottom).offset(CYTAutoLayoutV(18.f));
        make.bottom.equalTo(-CYTAutoLayoutV(18.f));
    }];
    
    [_sectionTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_dividerBar.mas_right).offset(CYTAutoLayoutH(14.f));
        make.right.equalTo(CYTItemMarginV);
        make.centerY.equalTo(_dividerBar);
    }];
    
    [_lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTMarginH);
        make.right.equalTo(-CYTMarginH);
        make.bottom.equalTo(self);
        make.height.equalTo(CYTDividerLineWH);
    }];
}
- (void)setConfirmSendCarSectionModel:(CYTOrderExtendSectionModel *)confirmSendCarSectionModel{
    _confirmSendCarSectionModel = confirmSendCarSectionModel;
    [self setValueWithConfirmSendCarSectionModel:confirmSendCarSectionModel];
    [self layoutWithConfirmSendCarSectionModel:confirmSendCarSectionModel];
}

- (void)setValueWithConfirmSendCarSectionModel:(CYTOrderExtendSectionModel *)confirmSendCarSectionModel{
    _sectionTitleLabel.text = confirmSendCarSectionModel.sectionTitle;
}

- (void)layoutWithConfirmSendCarSectionModel:(CYTOrderExtendSectionModel *)confirmSendCarSectionModel{
    if (confirmSendCarSectionModel.showInfoBar) {
        _dividerBar.hidden = NO;
        [_sectionTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_dividerBar.mas_right).offset(CYTAutoLayoutH(14.f));
            make.right.equalTo(CYTItemMarginV);
            make.centerY.equalTo(_dividerBar);
        }];
    }else{
        _dividerBar.hidden = YES;
        [_sectionTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(CYTMarginH);
            make.right.equalTo(CYTItemMarginV);
            make.centerY.equalTo(_dividerBar);
        }];
    }
}

@end
