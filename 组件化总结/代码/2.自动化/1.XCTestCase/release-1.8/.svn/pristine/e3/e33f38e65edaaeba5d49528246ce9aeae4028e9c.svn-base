//
//  CYTOtherHeaderView.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/8/8.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTOtherHeaderView.h"
#import "CYTStarView.h"
#import "CYTDealer.h"

@implementation CYTOtherHeaderView
{
    //顶部分割条
    UIView *_topBar;
    //用户头像
    UIImageView *_userheaderImageView;
    //姓名
    UILabel *_nameLabel;
    //公司类型
    UIButton *_companyTypeLabel;
    //实体店执照认证情况
    UIButton *_realStoreAuthenLabel;
    //评价
    CYTStarView *_startView;
    //箭头
    UIImageView *_arrowImageView;
    //认证公司
    UILabel *_companyNameTipLabel;
    UILabel *_companyNameLabel;
    //主营品牌
    UILabel *_manageTypeTipLabel;
    UILabel *_manageTypeLabel;
}


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self otherHeaderViewBasicConfig];
        [self initOtherHeaderViewComponents];
        [self makeConstrains];
    }
    return  self;
}
/**
 *  基本配置
 */
- (void)otherHeaderViewBasicConfig{
    self.backgroundColor = [UIColor clearColor];
}
/**
 *  初始化子控件
 */
- (void)initOtherHeaderViewComponents{
    //顶部分割条
    UIView *topBar = [[UIView alloc] init];
    topBar.backgroundColor = kFFColor_bg_nor;
    [self addSubview:topBar];
    _topBar = topBar;

    //用户头像
    UIImageView *userheaderImageView = [[UIImageView alloc] init];
    userheaderImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:userheaderImageView];
    _userheaderImageView = userheaderImageView;
    
    //姓名
    UILabel *nameLabel = [UILabel labelWithTextColor:CYTHexColor(@"#333333") textAlignment:NSTextAlignmentLeft fontPixel:32.f setContentPriority:NO];
    [self addSubview:nameLabel];
    _nameLabel = nameLabel;
    
    //公司类型
    UIButton *companyTypeLabel = [UIButton tagButtonWithTextColor:[UIColor whiteColor] fontPixel:24.f cornerRadius:2.f backgroundColor:CYTHexColor(@"#3EC0FD")];
    [self addSubview:companyTypeLabel];
    _companyTypeLabel = companyTypeLabel;
    
    //实体店认证情况
    UIButton *realStoreAuthenLabel = [UIButton tagButtonWithText:@"实" textColor:[UIColor whiteColor] fontPixel:24.f cornerRadius:2.f backgroundColor:CYTHexColor(@"#F43244")];
    [self addSubview:realStoreAuthenLabel];
    _realStoreAuthenLabel = realStoreAuthenLabel;
    //评价
    CYTStarView *startView = [[CYTStarView alloc] init];
    startView.starTotalNum = 5;
    [self addSubview:startView];
    _startView = startView;
    
    //箭头
    UIImageView *arrowImageView = [UIImageView ff_imageViewWithImageName:@"arrow_right"];
    [self addSubview:arrowImageView];
    _arrowImageView = arrowImageView;
    
    //公司名称
    UILabel *companyNameTipLabel = [UILabel labelWithText:@"公司：" textColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentLeft fontPixel:26.f setContentPriority:YES];
    [self addSubview:companyNameTipLabel];
    _companyNameTipLabel = companyNameTipLabel;
    
    UILabel *companyNameLabel = [UILabel labelWithTextColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentLeft fontPixel:26.f setContentPriority:NO];
    [self addSubview:companyNameLabel];
    _companyNameLabel = companyNameLabel;
    
    //主营品牌
    UILabel *manageTypeTipLabel = [UILabel labelWithText:@"主营：" textColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentLeft fontPixel:26.f setContentPriority:YES];
    [self addSubview:manageTypeTipLabel];
    _manageTypeTipLabel = manageTypeTipLabel;
    
    UILabel *manageTypeLabel = [UILabel labelWithTextColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentLeft fontPixel:26.f setContentPriority:NO];
    [self addSubview:manageTypeLabel];
    _manageTypeLabel = manageTypeLabel;
    
    //测试数据
//    userheaderImageView.image = [UIImage imageWithColor:CYTGreenNormalColor];
//    nameLabel.text = @"摔了个帅帅帅帅";
//    [companyTypeLabel setTitle:@"4S" forState:UIControlStateNormal];
//    companyNameLabel.text = @"北京比特易湃信息技术有限公司";
//    manageTypeLabel.text = @"福特 现代 大众 奥迪";
//    startView.starValue = 1.5f;
}

- (UILabel *)tagLabelWithTitle:(NSString *)title{
    return [UILabel tagLabelWithText:title textColor:[UIColor whiteColor] fontPixel:24.f cornerRadius:2.f backgroundColor:CYTRedColor];
}
/**
 *  布局子控件
 */
- (void)makeConstrains{
    
    [_topBar makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.right.equalTo(self);
        make.height.equalTo(CYTItemMarginV);
    }];
    
    CGFloat userheaderWH = CYTAutoLayoutV(80.f);
    [_userheaderImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(userheaderWH);
        make.left.equalTo(CYTMarginH);
        make.top.equalTo(_topBar.mas_bottom).offset(CYTMarginV);
        _userheaderImageView.layer.cornerRadius = userheaderWH*0.5;
        _userheaderImageView.layer.masksToBounds = YES;
    }];
    
    CGFloat nameLabelWorldW = _nameLabel.font.pointSize + 2;
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_userheaderImageView.mas_right).offset(CYTItemMarginH);
        make.top.equalTo(_userheaderImageView);
        make.width.lessThanOrEqualTo(nameLabelWorldW*5);
    }];
    
    CGFloat tagMargin = CYTAutoLayoutH(10.f);
    [_companyTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_nameLabel);
        make.left.equalTo(_nameLabel.mas_right).offset(tagMargin);
    }];
    
    [_arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(CYTAutoLayoutV(44.f));
        make.centerY.equalTo(self);
        make.right.equalTo(-CYTMarginH);
    }];

    [_companyNameTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel);
        make.top.equalTo(_nameLabel.mas_bottom).offset(CYTItemMarginV);
    }];

    [_companyNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_companyNameTipLabel.mas_right);
        make.top.equalTo(_nameLabel.mas_bottom).offset(CYTItemMarginV);
        make.right.equalTo(_arrowImageView.mas_left).offset(-CYTItemMarginH);
    }];
    
    [_manageTypeTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel);
        make.top.equalTo(_companyNameTipLabel.mas_bottom).offset(CYTAutoLayoutV(15.f));
    }];

    [_manageTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_manageTypeTipLabel);
        make.left.equalTo(_manageTypeTipLabel.mas_right);
        make.right.equalTo(_arrowImageView.mas_left).offset(-CYTItemMarginH);
        make.bottom.equalTo(-CYTMarginV);
    }];

}

- (void)setCarSourceFindCarDealerModel:(CYTDealer *)carSourceFindCarDealerModel{
//    carSourceFindCarDealerModel.IsStoreAuth = YES;
    _carSourceFindCarDealerModel = carSourceFindCarDealerModel;
    [self setVlaueWithCarSourceFindCarDealerModel:carSourceFindCarDealerModel];
    [self layoutWithCarSourceFindCarDealerModel:carSourceFindCarDealerModel];
}

- (void)setVlaueWithCarSourceFindCarDealerModel:(CYTDealer *)carSourceFindCarDealerModel{
    //头像
    [_userheaderImageView sd_setImageWithURL:[NSURL URLWithString:carSourceFindCarDealerModel.avatar] placeholderImage:kPlaceholderHeaderImage];
    //姓名
    NSString *nameContent = carSourceFindCarDealerModel.userName.length?carSourceFindCarDealerModel.userName:@"";
    _nameLabel.text = nameContent;
    //类型
    NSString *typeContent = carSourceFindCarDealerModel.businessModel.length?carSourceFindCarDealerModel.businessModel:@"";
    [_companyTypeLabel setTitle:typeContent forState:UIControlStateNormal];
    //评价
    _startView.starValue = carSourceFindCarDealerModel.starScore;
    //公司名称
    NSString *companyNameContent = carSourceFindCarDealerModel.companyName.length?carSourceFindCarDealerModel.companyName:@"";
    _companyNameLabel.text = companyNameContent;
    //经营类型
    NSString *companyTypeContent = carSourceFindCarDealerModel.carBrandName.length?carSourceFindCarDealerModel.carBrandName:@"";
    _manageTypeLabel.text = companyTypeContent;
}

- (void)layoutWithCarSourceFindCarDealerModel:(CYTDealer *)carSourceFindCarDealerMode{
    if (carSourceFindCarDealerMode.isStoreAuth) {
        _realStoreAuthenLabel.hidden = NO;
        CGFloat tagMargin = CYTAutoLayoutH(10.f);
        [_realStoreAuthenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_companyTypeLabel);
            make.left.equalTo(_companyTypeLabel.mas_right).offset(tagMargin);
        }];
    }else{
        _realStoreAuthenLabel.hidden = YES;
    }
    extern CGFloat starWidth;
    extern CGFloat starHeight;
    [_startView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_nameLabel);
        if (carSourceFindCarDealerMode.isStoreAuth) {
           make.left.equalTo(_realStoreAuthenLabel.mas_right).offset(CYTAutoLayoutH(10));
        }else{
            make.left.equalTo(_companyTypeLabel.mas_right).offset(CYTAutoLayoutH(10));
        }
        make.size.equalTo(CGSizeMake(CYTAutoLayoutV(starWidth)*_startView.starTotalNum, CYTAutoLayoutV(starHeight)));
    }];
}

@end
