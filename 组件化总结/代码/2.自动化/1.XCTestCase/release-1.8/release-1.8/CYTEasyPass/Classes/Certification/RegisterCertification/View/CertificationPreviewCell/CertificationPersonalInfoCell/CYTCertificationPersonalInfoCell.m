//
//  CYTCertificationPersonalInfoCell.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/5/4.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCertificationPersonalInfoCell.h"
#import "CYTUserInfoModel.h"

@interface CYTCertificationPersonalInfoCell()

/** 姓名 */
@property(weak, nonatomic) UILabel *nameLabel;

/** 身份证号码 */
@property(weak, nonatomic) UILabel *idCardNumLabel;

/** 身份证正面照 */
@property(weak, nonatomic) UIImageView *idCardFrontImageView;

/** 身份证反面照 */
@property(weak, nonatomic) UIImageView *idCardBackImageView;

/** 手持身份证正面照 */
@property(weak, nonatomic) UIImageView *idCardFrontWithHandImageView;


@end

@implementation CYTCertificationPersonalInfoCell
{
    //姓名
    UIView *_userNameView;
    //身份证号
    UIView *_idCardView;
    //身份证显示区域
    UIView *_idCardShowView;
    //营业执照显示区域
    UIView *_businessLicenseShowView;
    //企业信息
    UIView *_companyInfoView;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self certificationPersonalInfoBasicConfig];
        [self initCertificationPersonalInfooComponents];
        [self makeConstrains];
    }
    return self;
}
/**
 *  基本配置
 */
- (void)certificationPersonalInfoBasicConfig{
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

/**
 *  初始化子控件
 */
- (void)initCertificationPersonalInfooComponents{
    //姓名
    UIView *userNameView = [self infoBarWithTitle:@"姓名" contentlabel:^(UILabel *contentLabel) {
        _nameLabel = contentLabel;
    }];
    [self.contentView addSubview:userNameView];
    _userNameView = userNameView;
    
    //身份证号码
    UIView *idCardView = [self infoBarWithTitle:@"身份证号码" contentlabel:^(UILabel *contentLabel) {
        _idCardNumLabel = contentLabel;
    }];
    [self.contentView addSubview:idCardView];
    _idCardView = idCardView;
    
    //身份证显示区域
    UIView *idCardShowView = [[UIView alloc] init];
    idCardShowView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:idCardShowView];
    _idCardShowView = idCardShowView;
    
    //身份证正面照
    UIImageView *idCardFrontImageView = [self showImageViewWithTap:^{
        !self.picClickBack?:self.picClickBack(0);
    }];
    idCardFrontImageView.backgroundColor = [UIColor clearColor];
    [idCardShowView addSubview:idCardFrontImageView];
    _idCardFrontImageView = idCardFrontImageView;
    
    //身份证反面面照
    UIImageView *idCardBackImageView = [self showImageViewWithTap:^{
        !self.picClickBack?:self.picClickBack(1);
    }];
    [idCardShowView addSubview:idCardBackImageView];
    _idCardBackImageView = idCardBackImageView;
    
    //手持身份证正面照
    UIImageView *idCardFrontWithHandImageView = [self showImageViewWithTap:^{
        !self.picClickBack?:self.picClickBack(2);
    }];
    [idCardShowView addSubview:idCardFrontWithHandImageView];
    _idCardFrontWithHandImageView = idCardFrontWithHandImageView;
}

/**
 *  布局控件
 */
- (void)makeConstrains{
    [_userNameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.right.equalTo(self.contentView);
    }];
    
    [_idCardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_userNameView.mas_bottom);
        make.left.right.equalTo(self.contentView);
    }];
    
    [_idCardShowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_idCardView.mas_bottom);
        make.left.right.equalTo(self.contentView);
        make.height.equalTo(CYTAutoLayoutV(50*2+190*2+40));
        make.bottom.equalTo(self.contentView);
    }];
    
    [_idCardFrontImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_idCardShowView).offset(CYTAutoLayoutV(50.f));
        make.left.equalTo(self).offset(CYTAutoLayoutH(65.f));
        make.width.equalTo(CYTAutoLayoutH(290.f));
        make.height.equalTo(CYTAutoLayoutV(190.f));
    }];
    
    [_idCardBackImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.width.height.equalTo(_idCardFrontImageView);
        make.right.equalTo(_idCardShowView).offset(-CYTAutoLayoutH(65));
    }];
    
    [_idCardFrontWithHandImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_idCardFrontImageView.mas_bottom).offset(CYTAutoLayoutV(40.f));
        make.width.height.equalTo(_idCardFrontImageView);
        make.left.equalTo(_idCardShowView).offset(CYTAutoLayoutH(65));
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
        make.right.equalTo(-CYTMarginV);
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

+ (instancetype)certificationPersonalInfoCelllForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"CYTCertificationPersonalInfoCell";
    CYTCertificationPersonalInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell){
        cell = [[CYTCertificationPersonalInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (void)setUserAuthenticateInfoModel:(CYTUserInfoModel *)userAuthenticateInfoModel{
    _userAuthenticateInfoModel = userAuthenticateInfoModel;
    _nameLabel.text = userAuthenticateInfoModel.userName;
    _idCardNumLabel.text = userAuthenticateInfoModel.idCard;
    CYTSetSDWebImageHeader
    [_idCardFrontImageView sd_setImageWithURL:[NSURL URLWithString:userAuthenticateInfoModel.frontIdCardOriginalPic] placeholderImage:kPlaceholderImage];
    [_idCardBackImageView sd_setImageWithURL:[NSURL URLWithString:userAuthenticateInfoModel.oppositeIdCardOriginalPic] placeholderImage:kPlaceholderImage];
    [_idCardFrontWithHandImageView sd_setImageWithURL:[NSURL URLWithString:userAuthenticateInfoModel.holdIdCardOriginalPic] placeholderImage:kPlaceholderImage];
}

@end
