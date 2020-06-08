//
//  CYTCertificationCompanyInfoCell.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/5/4.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCertificationCompanyInfoCell.h"
#import "CYTUserInfoModel.h"

@interface CYTCertificationCompanyInfoCell()

/** 公司名称 */
@property(weak, nonatomic) UILabel *companyNameLabel;

/** 注册地址 */
@property(weak, nonatomic) UILabel *registerAddressLabel;

/** 经营类型 */
@property(weak, nonatomic) UILabel *manageTypeLabel;

/** 主营品牌 */
@property(weak, nonatomic) UILabel *manageBrandLabel;

/** 营业执照 */
@property(weak, nonatomic) UIImageView *businessLicenseImageView;

/** 展厅照 */
@property(weak, nonatomic) UIImageView *showRoomImageView;

@end

@implementation CYTCertificationCompanyInfoCell
{
    //公司名称
    UIView *_companyNameView;
    //注册地址
    UIView *_registerAddressView;
    //经营类型
    UIView *_manageTypeView;
    //主营品牌
    UIView *_manageBrandView;
    //企业照片显示区域
    UIView *_companyShowView;

}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self certificationCompanyInfoBasicConfig];
        [self initCertificationCompanyInfoComponents];
        [self makeConstrains];
    }
    return self;
}
/**
 *  基本配置
 */
- (void)certificationCompanyInfoBasicConfig{
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

/**
 *  初始化子控件
 */
- (void)initCertificationCompanyInfoComponents{
    //公司名称
    UIView *companyNameView = [self infoBarWithTitle:@"公司名称" contentlabel:^(UILabel *contentLabel) {
        _companyNameLabel = contentLabel;
    }];
    [self.contentView addSubview:companyNameView];
    _companyNameView = companyNameView;
    
    //注册地址
    UIView *registerAddressView = [self infoBarWithTitle:@"注册地址" contentlabel:^(UILabel *contentLabel) {
        _registerAddressLabel = contentLabel;
    }];
    [self.contentView addSubview:registerAddressView];
    _registerAddressView = registerAddressView;
    
    //经营类型
    UIView *manageTypeView = [self infoBarWithTitle:@"经营类型" contentlabel:^(UILabel *contentLabel) {
        _manageTypeLabel = contentLabel;
    }];
    [self.contentView addSubview:manageTypeView];
    _manageTypeView = manageTypeView;
    
    //主营品牌
    UIView *manageBrandView = [self infoBarWithTitle:@"主营品牌" contentlabel:^(UILabel *contentLabel) {
        _manageBrandLabel = contentLabel;
    }];
    [self.contentView addSubview:manageBrandView];
    _manageBrandView = manageBrandView;
    
    //企业照片显示区域
    UIView *companyShowView = [[UIView alloc] init];
    companyShowView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:companyShowView];
    _companyShowView = companyShowView;
    
    //营业执照
    UIImageView *businessLicenseImageView = [self showImageViewWithTap:^{
        !self.picClickBack?:self.picClickBack(3);
    }];
    [companyShowView addSubview:businessLicenseImageView];
    _businessLicenseImageView = businessLicenseImageView;
    
    //展厅照
    UIImageView *showRoomImageView = [self showImageViewWithTap:^{
        !self.picClickBack?:self.picClickBack(4);
    }];
    [companyShowView addSubview:showRoomImageView];
    _showRoomImageView = showRoomImageView;
}

/**
 *  布局控件
 */
- (void)makeConstrains{
    [_companyNameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.right.equalTo(self.contentView);
    }];
    
    [_registerAddressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_companyNameView.mas_bottom);
        make.left.right.equalTo(self.contentView);
    }];
    
    [_manageTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_registerAddressView.mas_bottom);
        make.left.right.equalTo(self.contentView);
    }];
    
    [_manageBrandView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_manageTypeView.mas_bottom);
        make.left.right.equalTo(self.contentView);
    }];
    
    [_companyShowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_manageBrandView.mas_bottom);
        make.left.right.equalTo(self.contentView);
        make.height.equalTo(CYTAutoLayoutV(50*2+190));
        make.bottom.equalTo(self.contentView);
    }];
    
    [_businessLicenseImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(CYTAutoLayoutH(290.f));
        make.height.equalTo(CYTAutoLayoutV(190.f));
        make.top.equalTo(_companyShowView).offset(CYTAutoLayoutV(50.f));
        make.left.equalTo(self.contentView).offset(CYTAutoLayoutH(65.f));
    }];
    
    [_showRoomImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(_businessLicenseImageView);
        make.top.equalTo(_businessLicenseImageView);
        make.right.equalTo(self.contentView).offset(-CYTAutoLayoutH(65.f));
    }];
}

/**
 *  信息条
 */
- (UIView *)infoBarWithTitle:(NSString *)title contentlabel:(void(^)(UILabel *contentLabel))content{
    
    UIView *infoView = [[UIView alloc] init];
    infoView.backgroundColor = [UIColor whiteColor];
    //标题文字
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.font = CYTFontWithPixel(28.f);
    titleLabel.text = title;
    titleLabel.textColor = [UIColor colorWithHexColor:@"#333333"];
    [infoView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTMarginH);
        make.top.equalTo(CYTMarginV);
        make.width.equalTo((titleLabel.font.pointSize+2)*5);
    }];
    
    //内容
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.numberOfLines = 0;
    contentLabel.textAlignment = NSTextAlignmentRight;
    contentLabel.font = CYTFontWithPixel(26.f);
    contentLabel.textColor = [UIColor colorWithHexColor:@"#666666"];
    [infoView addSubview:contentLabel];
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLabel.mas_right).offset(CYTItemMarginH);
        make.top.equalTo(titleLabel);
        make.right.equalTo(-CYTMarginH);
        make.bottom.equalTo(-CYTMarginV);
    }];
    
    //回调内容控件
    if (content) {
        content(contentLabel);
    }
    
    //下分割线
    UILabel *dividerLineLabel = [UILabel dividerLineLabel];
    [infoView addSubview:dividerLineLabel];
    [dividerLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentLabel.mas_bottom).offset(CYTMarginV-CYTDividerLineWH);
        make.left.equalTo(CYTMarginH);
        make.right.equalTo(-CYTMarginH);
        make.height.equalTo(CYTDividerLineWH);
    }];
    return infoView;
}

/**
 * 展示图片
 */
- (UIImageView *)showImageViewWithTap:(void(^)())tapClick{
    UIImageView *aImageView = [[UIImageView alloc] init];
    aImageView.contentMode = UIViewContentModeScaleAspectFill;
    aImageView.userInteractionEnabled = YES;
    aImageView.layer.cornerRadius = CYTAutoLayoutH(8.f);
    aImageView.layer.masksToBounds = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [aImageView addGestureRecognizer:tap];
    [[tap rac_gestureSignal] subscribeNext:^(id x) {
        if (tapClick) {
            tapClick();
        }
    }];
    return aImageView;
}

+ (instancetype)certificationCompanyInfoCellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"CYTCertificationCompanyInfoCell";
    CYTCertificationCompanyInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell){
        cell = [[CYTCertificationCompanyInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (void)setUserAuthenticateInfoModel:(CYTUserInfoModel *)userAuthenticateInfoModel{
    _userAuthenticateInfoModel = userAuthenticateInfoModel;
    _companyNameLabel.text = userAuthenticateInfoModel.companyName;
    if (userAuthenticateInfoModel.provinceName.length && userAuthenticateInfoModel.cityName.length && userAuthenticateInfoModel.registerAddress.length) {
        _registerAddressLabel.text = [NSString stringWithFormat:@"%@ %@ %@ %@",userAuthenticateInfoModel.provinceName,userAuthenticateInfoModel.cityName,userAuthenticateInfoModel.countryName,userAuthenticateInfoModel.registerAddress];
    }
    _manageTypeLabel.text = userAuthenticateInfoModel.companyType;
    _manageBrandLabel.text = userAuthenticateInfoModel.carBrandStr;

    [_businessLicenseImageView sd_setImageWithURL:[NSURL URLWithString:userAuthenticateInfoModel.businessLicenseOriginalPic] placeholderImage:kPlaceholderImage];
    //展厅照片
    if (!userAuthenticateInfoModel.exhibitOriginalPic.length) {
        _showRoomImageView.hidden = YES;
        return;
    }
    _showRoomImageView.hidden = NO;
    [_showRoomImageView sd_setImageWithURL:[NSURL URLWithString:userAuthenticateInfoModel.exhibitOriginalPic] placeholderImage:kPlaceholderImage];
}


@end
