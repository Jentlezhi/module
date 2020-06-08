//
//  CYTUserHeaderView.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/8/8.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTUserHeaderView.h"
#import "CYTStarView.h"
#import "CYTAccountStateModel.h"
#import "CYTUserInfoModel.h"

@implementation CYTUserHeaderView
{
    //用户头像
    UIImageView *_userheaderImageView;
    //姓名
    UILabel *_nameLabel;
    //身份证认证情况
    UIButton *_IDCardAuthenLabel;
    //营业执照认证情况
    UIButton *_businessLicenseAuthenLabel;
    //实体店执照认证情况
    UIButton *_realStoreAuthenLabel;
    //认证描述
    UILabel *_authenDecLabel;
    //评价
    CYTStarView *_startView;
    //箭头
    UIImageView *_arrowImageView;
    //公司类型
    UIButton *_companyTypeLabel;
    //认证公司
    UILabel *_companyNameLabel;
    //主营品牌
    UILabel *_manageTypeTipLabel;
    UILabel *_manageTypeLabel;
    //地址
    UILabel *_addressTipLabel;
    UILabel *_addressLabel;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self userHeaderBasicConfig];
        [self initUserHeaderComponents];
        [self makeConstrains];
    }
    return  self;
}
/**
 *  基本配置
 */
- (void)userHeaderBasicConfig{
    self.backgroundColor = [UIColor clearColor];
}
/**
 *  初始化子控件
 */
- (void)initUserHeaderComponents{
    //用户头像
    UIImageView *userheaderImageView = [[UIImageView alloc] init];
    userheaderImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:userheaderImageView];
    _userheaderImageView = userheaderImageView;
    
    //姓名
    UILabel *nameLabel = [UILabel labelWithText:@"姓名" textColor:CYTHexColor(@"#333333") textAlignment:NSTextAlignmentLeft fontPixel:34.f setContentPriority:NO];
    [self addSubview:nameLabel];
    _nameLabel = nameLabel;
    
    //身份证认证情况
    UIButton *IDCardAuthenLabel = [self tagWithTitle:@"身"];
    [IDCardAuthenLabel sizeToFit];
    [self addSubview:IDCardAuthenLabel];
    _IDCardAuthenLabel = IDCardAuthenLabel;
    
    //营业执照认证情况
    UIButton *businessLicenseAuthenLabel = [self tagWithTitle:@"营"];
    [businessLicenseAuthenLabel sizeToFit];
    [self addSubview:businessLicenseAuthenLabel];
    _businessLicenseAuthenLabel = businessLicenseAuthenLabel;
    
    //实体店执照认证情况
    UIButton *realStoreAuthenLabel = [self tagWithTitle:@"实"];
    [realStoreAuthenLabel sizeToFit];
    [self addSubview:realStoreAuthenLabel];
    _realStoreAuthenLabel = realStoreAuthenLabel;
    
    //认证描述
    UILabel *authenDecLabel = [UILabel labelWithTextColor:CYTHexColor(@"#F43244") textAlignment:NSTextAlignmentLeft fontPixel:26.f setContentPriority:NO];
    [self addSubview:authenDecLabel];
    _authenDecLabel = authenDecLabel;
    
    //评价
    CYTStarView *startView = [[CYTStarView alloc] init];
    startView.starTotalNum = 5;
    [self addSubview:startView];
    _startView = startView;
    
    //箭头
    UIImageView *arrowImageView = [UIImageView ff_imageViewWithImageName:@"arrow_right"];
    [self addSubview:arrowImageView];
    _arrowImageView = arrowImageView;
    
    //公司类型
    UIButton *companyTypeLabel = [UIButton tagButtonWithTextColor:[UIColor whiteColor] fontPixel:24.f cornerRadius:2.f backgroundColor:CYTHexColor(@"#3EC0FD")];
    [companyTypeLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [companyTypeLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self addSubview:companyTypeLabel];
    _companyTypeLabel = companyTypeLabel;
    
    //公司名称
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
    
    //地址
    UILabel *addressTipLabel = [UILabel labelWithText:@"地址：" textColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentLeft fontPixel:26.f setContentPriority:YES];
    [self addSubview:addressTipLabel];
    _addressTipLabel = addressTipLabel;
    
    UILabel *addressLabel = [UILabel labelWithTextColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentLeft fontPixel:26.f setContentPriority:NO];
    [self addSubview:addressLabel];
    _addressLabel = addressLabel;
    
    
    //测试数据
    userheaderImageView.image = [UIImage imageWithColor:CYTGreenNormalColor];
    nameLabel.text = @"摔了个帅帅帅帅";
    authenDecLabel.text = @"去认证";
    [companyTypeLabel setTitle:@"4S" forState:UIControlStateNormal];
    companyNameLabel.text = @"北京比特易湃信息技术有限公司";
    manageTypeLabel.text = @"福特 现代 大众 奥迪";
    addressLabel.text = @"石家庄市区 东路22号";
    startView.starValue = 1.5f;
}

- (UIButton *)tagWithTitle:(NSString *)title{
    return [UIButton tagButtonWithText:title textColor:[UIColor whiteColor] fontPixel:24.f cornerRadius:2.f backgroundColor:CYTHexColor(@"#D2D2D2")];
}
/**
 *  布局子控件
 */
- (void)makeConstrains{
    CGFloat userheaderWH = CYTAutoLayoutV(120.f);
    [_userheaderImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(userheaderWH);
        make.left.equalTo(CYTAutoLayoutH(40.f));
        make.top.equalTo(self);
        _userheaderImageView.layer.cornerRadius = userheaderWH*0.5;
        _userheaderImageView.layer.masksToBounds = YES;
    }];
    
    CGFloat nameLabelWorldW = _nameLabel.font.pointSize + 2;
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_userheaderImageView.mas_right).offset(CYTItemMarginH);
        make.top.equalTo(CYTItemMarginV);
        make.width.lessThanOrEqualTo(nameLabelWorldW*5);
    }];
    
    CGFloat tagMargin = CYTAutoLayoutH(10.f);
    
    [_IDCardAuthenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_nameLabel);
        make.left.equalTo(_nameLabel.mas_right).offset(tagMargin);
    }];
    
    [_businessLicenseAuthenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_IDCardAuthenLabel);
        make.left.equalTo(_IDCardAuthenLabel.mas_right).offset(tagMargin);
    }];
    
    [_realStoreAuthenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_businessLicenseAuthenLabel);
        make.left.equalTo(_businessLicenseAuthenLabel.mas_right).offset(tagMargin);
    }];

    [_authenDecLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_realStoreAuthenLabel.mas_right).offset(CYTItemMarginH);
        make.right.lessThanOrEqualTo(_arrowImageView.mas_left).offset(-CYTMarginH);
        make.centerY.equalTo(_nameLabel);
    }];

    [_arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(CYTAutoLayoutV(44.f));
        make.centerY.equalTo(self);
        make.right.equalTo(-CYTMarginH);
    }];

    [_companyNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel);
        make.top.equalTo(_nameLabel.mas_bottom).offset(CYTItemMarginV);
    }];
    
    [_companyTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_companyNameLabel);
        make.left.equalTo(_companyNameLabel.mas_right).offset(CYTAutoLayoutH(10));
        make.right.lessThanOrEqualTo(_arrowImageView.mas_left).offset(-CYTItemMarginH);
    }];
    
    [_manageTypeTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel);
        make.top.equalTo(_companyNameLabel.mas_bottom).offset(CYTAutoLayoutV(15.f));
    }];
    
    [_manageTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_manageTypeTipLabel);
        make.left.equalTo(_manageTypeTipLabel.mas_right);
        make.right.equalTo(_arrowImageView.mas_left).offset(-CYTItemMarginH);
    }];
    
    [_addressTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel);
        make.top.equalTo(_manageTypeTipLabel.mas_bottom).offset(CYTAutoLayoutV(15.f));
        make.bottom.equalTo(-CYTMarginV);
    }];
    
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_addressTipLabel);
        make.left.equalTo(_addressTipLabel.mas_right);
        make.right.equalTo(_manageTypeLabel);
    }];
    
    extern CGFloat starWidth;
    extern CGFloat starHeight;
    [_startView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_nameLabel);
        make.left.equalTo(_realStoreAuthenLabel.mas_right).offset(CYTAutoLayoutH(10.f));
        make.size.equalTo(CGSizeMake(CYTAutoLayoutV(starWidth)*_startView.starTotalNum, CYTAutoLayoutV(starHeight)));
    }];
}

/**
 *  v1.6新
 */
- (void)setUserInfoModel:(CYTUserInfoModel *)userInfoModel{
    _userInfoModel = userInfoModel;
    CYTAccountStateModel *accountStateModel = [self authStatus];
    accountStateModel.userInfoModel = userInfoModel;
    [self setValueWithAccountStateModel:accountStateModel];
}

- (void)setValueWithAccountStateModel:(CYTAccountStateModel *)accountStateModel{
    CYTUserInfoModel *userInfoModel = accountStateModel.userInfoModel;
    //头像
    [_userheaderImageView sd_setImageWithURL:[NSURL URLWithString:userInfoModel.avatar] placeholderImage:kPlaceholderHeaderImage];
    NSString *nameContent = userInfoModel.userName.length?userInfoModel.userName:@"姓名";
    _nameLabel.text = nameContent;
    
    //实名认证
    UIColor *IDCardAuthenColor = userInfoModel.isIdCardAuth? CYTHexColor(@"#FAC529"):CYTHexColor(@"#D2D2D2");
    [_IDCardAuthenLabel setBackgroundImage:[UIImage imageWithColor:IDCardAuthenColor] forState:UIControlStateNormal];
    
    //营业执照
    UIColor *businessLicenseAuthenColor = userInfoModel.isBusinessLicenseAuth? CYTHexColor(@"#00C34D"):CYTHexColor(@"#D2D2D2");
    [_businessLicenseAuthenLabel setBackgroundImage:[UIImage imageWithColor:businessLicenseAuthenColor] forState:UIControlStateNormal];
    //实店认证
    UIColor *realStoreAuthenColor = userInfoModel.isStoreAuth? CYTHexColor(@"#F43244"):CYTHexColor(@"#D2D2D2");
    [_realStoreAuthenLabel setBackgroundImage:[UIImage imageWithColor:realStoreAuthenColor] forState:UIControlStateNormal];
    
    NSString *authenDecContent = accountStateModel.authDec.length?accountStateModel.authDec:@"";
    _authenDecLabel.text = authenDecContent;
    _authenDecLabel.textColor = accountStateModel.authDecColor;
    _startView.hidden = !accountStateModel.isShowStarView;
    _authenDecLabel.hidden = !_startView.isHidden;
    
    //评价
    _startView.starValue = userInfoModel.starScore;
    
//    userDealerInfoModel.CompanyName = nil;
    NSString *companyNameContent = userInfoModel.companyName.length ? userInfoModel.companyName:@"公司：暂无";
    NSString *companyTypeContent = userInfoModel.companyType.length ? userInfoModel.companyType:@"";
    _companyNameLabel.text = companyNameContent;
    [_companyTypeLabel setTitle:companyTypeContent forState:UIControlStateNormal];
    _companyTypeLabel.hidden = !userInfoModel.companyName.length;
//    userDealerInfoModel.CarBrandNameStr = nil;
    NSString *manageTypeContent = userInfoModel.carBrandStr.length ? userInfoModel.carBrandStr:@"暂无";
    _manageTypeLabel.text = manageTypeContent;
//    userDealerInfoModel.ProvinceName = nil;
    NSString *addressContent = userInfoModel.registerAddress.length?userInfoModel.registerAddress:@"暂无";
    _addressLabel.text = addressContent;
    
}

#pragma mark - 配置

/**
 * 认证状态描述以及颜色
 */
- (CYTAccountStateModel *)authStatus{
    AccountState state = [CYTAccountManager sharedAccountManager].authStatus;
//    state = AccountStateAuthenticateFailed;
    CYTAccountStateModel *accountStateModel = [[CYTAccountStateModel alloc] init];
    accountStateModel.showStarView = NO;
    accountStateModel.state = state;
    switch (state) {
        case AccountStateLoginNotAuthenticationed://未认证
        {
            accountStateModel.authDec = @"去认证";
            accountStateModel.authDecColor = CYTRedColor;
        }
            break;
        case AccountStateAuthenticationed://已认证
        {
            accountStateModel.showStarView = YES;
        }
            break;
        case AccountStateAuthenticating://认证中
        {
            accountStateModel.authDec = @"审核中";
            accountStateModel.authDecColor = CYTRedColor;
        }
            break;
        case AccountStateAuthenticateFailed://认证失败
        {
            accountStateModel.authDec = @"请修改";
            accountStateModel.authDecColor = CYTRedColor;
        }
            break;
        default:
        {
            accountStateModel.authDec = @"去认证";
            accountStateModel.authDecColor = CYTGreenNormalColor;
        }
            break;
    }
    return accountStateModel;
}


@end
