//
//  CYTContactMeCell.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/10/17.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTContactMeCell.h"
#import "CYTStarView.h"
#import "CYTGetContactedMeListModel.h"
#import "CYTContactRecordCarInfoModel.h"
#import "CYTDealer.h"

@interface CYTContactMeCell()

/** 顶部分割条 */
@property(strong, nonatomic) UIView *topBar;
/** 顶部信息条 */
@property(strong, nonatomic) UIView *topInfoView;
/** 绿色分割条 */
@property(strong, nonatomic) UIView *greenBar;
/** Ta看过我的 */
@property(strong, nonatomic) UILabel *readMeTipLabel;
/** Ta看过我的车型信息 */
@property(strong, nonatomic) UILabel *readMeCarNameLabel;
/** 车款指导价 */
@property(strong, nonatomic) UILabel *carReferPriceLabel;
/** Ta看过我的 时间 */
@property(strong, nonatomic) UILabel *readMeTimeLabel;
/** 分割线 */
@property(strong, nonatomic) UILabel *dividerLine;
/** Ta的头像 */
@property(strong, nonatomic) UIImageView *hisHeaderView;
/** Ta的名字 */
@property(strong, nonatomic) UILabel *hisNameLabel;
/** Ta的公司类型 */
@property(strong, nonatomic) UIButton *hisCompanyType;
/** Ta是否实体店认证 */
@property(copy, nonatomic) UIButton *hisAuthenTag;
/** 评价等级 */
@property(strong, nonatomic) CYTStarView *starView;
/** 公司 */
@property(strong, nonatomic) UILabel *companyTipLabel;
/** 公司内容 */
@property(strong, nonatomic) UILabel *companyLabel;
/** 主营 */
@property(strong, nonatomic) UILabel *manageTipLabel;
/** 主营内容 */
@property(strong, nonatomic) UILabel *manageLabel;
/** 箭头 */
@property(strong, nonatomic) UIImageView *arrrow;

@end

@implementation CYTContactMeCell

- (void)initSubComponents{
    [self.contentView addSubview:self.topBar];
    [self.contentView addSubview:self.topInfoView];
    [self.topInfoView addSubview:self.greenBar];
    [self.topInfoView addSubview:self.readMeTipLabel];
    [self.topInfoView addSubview:self.readMeCarNameLabel];
    [self.topInfoView addSubview:self.carReferPriceLabel];
    [self.topInfoView addSubview:self.readMeTimeLabel];
    [self.topInfoView addSubview:self.dividerLine];
    [self.contentView addSubview:self.hisHeaderView];
    [self.contentView addSubview:self.hisNameLabel];
    [self.contentView addSubview:self.hisCompanyType];
    [self.contentView addSubview:self.hisAuthenTag];
    [self.contentView addSubview:self.starView];
    [self.contentView addSubview:self.companyTipLabel];
    [self.contentView addSubview:self.companyLabel];
    [self.contentView addSubview:self.manageTipLabel];
    [self.contentView addSubview:self.manageLabel];
    [self.contentView addSubview:self.arrrow];
    
    
    //测试数据
//    self.readMeCarNameLabel.text = @"林肯 大陆 44.38万";
//    self.readMeTimeLabel.text = @"04:20";
//    self.hisNameLabel.text = @"张世杰";
//    [self.hisCompanyType setTitle:@"4S" forState:UIControlStateNormal];
//    self.starView.starValue = 3.f;
//    self.companyLabel.text = @"成都博越众创商贸有限责任公司";
//    self.manageLabel.text = @"广汽本田 上汽通用五菱 东风本田";
}

- (void)makeSubConstrains{
    [self.topBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
        make.height.equalTo(CYTItemMarginV);
    }];
    
    [self.topInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.topBar.mas_bottom);
        make.height.equalTo(CYTAutoLayoutV(70.f)).priorityMedium();
    }];
    
    [self.greenBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTItemMarginH);
        make.centerY.equalTo(self.topInfoView);
        make.size.equalTo(CGSizeMake(CYTAutoLayoutH(6.f), CYTAutoLayoutV(34.f)));
    }];
    
    [self.readMeTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.greenBar.mas_left).offset(CYTAutoLayoutH(14.f));
        make.centerY.equalTo(self.topInfoView);
    }];
    
    [self.readMeCarNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.readMeTipLabel.mas_right);
        make.centerY.equalTo(self.topInfoView);
        make.right.equalTo(self.carReferPriceLabel.mas_left).offset(-CYTAutoLayoutH(10.f));
        make.width.lessThanOrEqualTo(CYTAutoLayoutH(260.f));
    }];
    
    [self.carReferPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.topInfoView);
//        make.right.equalTo(self.readMeTimeLabel.mas_left).offset(-CYTAutoLayoutH(10));
    }];
    
    [self.readMeTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-CYTItemMarginH);
        make.centerY.equalTo(self.topInfoView);
    }];
    
    [self.dividerLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTItemMarginH);
        make.right.equalTo(-CYTItemMarginH);
        make.bottom.equalTo(self.topInfoView);
        make.height.equalTo(CYTDividerLineWH);
    }];
    
    [self.hisHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topInfoView.mas_bottom).offset(CYTMarginV);
        make.left.equalTo(CYTMarginH);
        make.width.height.equalTo(CYTAutoLayoutV(80.f));
        self.hisHeaderView.layer.cornerRadius = CYTAutoLayoutV(80.f)*0.5f;
        self.hisHeaderView.layer.masksToBounds = YES;
    }];
    
    [self.hisNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.hisHeaderView.mas_right).offset(CYTItemMarginH);
        make.top.equalTo(self.hisHeaderView);
        make.width.lessThanOrEqualTo(110.f);
    }];
    
    [self.hisCompanyType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.hisNameLabel);
        make.left.equalTo(self.hisNameLabel.mas_right).offset(CYTAutoLayoutH(10));
    }];
    
    [self.companyTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.hisNameLabel.mas_bottom).offset(CYTAutoLayoutV(15.f));
        make.left.equalTo(self.hisNameLabel);
    }];
    
    [self.companyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.companyTipLabel);
        make.left.equalTo(self.companyTipLabel.mas_right);
        make.right.equalTo(self.arrrow.mas_left).offset(-CYTItemMarginH);
    }];
    
    [self.manageTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.companyTipLabel.mas_bottom).offset(CYTAutoLayoutV(15.f));
        make.left.equalTo(self.companyTipLabel);
        make.bottom.equalTo(-CYTMarginV);
    }];
    
    [self.manageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.manageTipLabel);
        make.left.equalTo(self.manageTipLabel.mas_right);
        make.right.equalTo(self.arrrow.mas_left).offset(-CYTItemMarginH);
    }];
    
    [self.arrrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView).offset(CYTAutoLayoutV(45.f));
        make.right.equalTo(-CYTItemMarginH);
        make.width.height.equalTo(CYTAutoLayoutV(44.f));
    }];
    
}
#pragma mark - 懒加载

- (UIView *)topBar{
    if (!_topBar) {
        _topBar = UIView.new;
        _topBar.backgroundColor = kFFColor_bg_nor;
    }
    return _topBar;
}
- (UIView *)topInfoView{
    if (!_topInfoView) {
        _topInfoView = UIView.new;
        _topInfoView.backgroundColor = [UIColor whiteColor];
    }
    return _topInfoView;
}

- (UIView *)greenBar{
    if (!_greenBar) {
        _greenBar = UIView.new;
        _greenBar.backgroundColor = CYTGreenNormalColor;
    }
    return _greenBar;
}

- (UILabel *)readMeTipLabel{
    if (!_readMeTipLabel) {
        _readMeTipLabel = [UILabel labelWithText:@"TA看过我的：" textColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentLeft fontPixel:26.f setContentPriority:YES];
    }
    return _readMeTipLabel;
}

- (UILabel *)readMeCarNameLabel{
    if (!_readMeCarNameLabel) {
        _readMeCarNameLabel = [UILabel labelWithTextColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentLeft fontPixel:26.f setContentPriority:NO];
        [_readMeCarNameLabel sizeToFit];
    }
    return _readMeCarNameLabel;
}
- (UILabel *)carReferPriceLabel{
    if (!_carReferPriceLabel) {
        _carReferPriceLabel = [UILabel labelWithTextColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentLeft fontPixel:26.f setContentPriority:YES];
    }
    return _carReferPriceLabel;
}

- (UILabel *)readMeTimeLabel{
    if (!_readMeTimeLabel) {
        _readMeTimeLabel = [UILabel labelWithTextColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentRight fontPixel:24.f setContentPriority:YES];
    }
    return _readMeTimeLabel;
}

- (UILabel *)dividerLine{
    if (!_dividerLine) {
        _dividerLine = [UILabel dividerLineLabel];
    }
    return _dividerLine;
}
- (UIImageView *)hisHeaderView{
    if (!_hisHeaderView) {
        _hisHeaderView = UIImageView.new;
        _hisHeaderView.image = [UIImage imageWithColor:CYTLightGrayColor];
    }
    return _hisHeaderView;
}

- (UILabel *)hisNameLabel{
    if (!_hisNameLabel) {
        _hisNameLabel = [UILabel labelWithTextColor:CYTHexColor(@"#333333") textAlignment:NSTextAlignmentLeft fontPixel:32.f setContentPriority:NO];
    }
    return _hisNameLabel;
}

- (UIButton *)hisCompanyType{
    if (!_hisCompanyType) {
        _hisCompanyType = [UIButton tagButtonWithTextColor:[UIColor whiteColor] fontPixel:24.f cornerRadius:2.f backgroundColor:CYTHexColor(@"#3EC0FD")];
    }
    return _hisCompanyType;
}

- (UIButton *)hisAuthenTag{
    if (!_hisAuthenTag) {
        _hisAuthenTag = [UIButton tagButtonWithText:@"实" textColor:[UIColor whiteColor] fontPixel:24.f cornerRadius:2.f backgroundColor:CYTHexColor(@"#F43244")];
    }
    return _hisAuthenTag;
}

- (CYTStarView *)starView{
    if (!_starView) {
        _starView = [[CYTStarView alloc] init];
        _starView.starTotalNum = 5;
    }
    return _starView;
}

- (UILabel *)companyTipLabel{
    if (!_companyTipLabel) {
        _companyTipLabel = [UILabel labelWithText:@"公司：" textColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentLeft fontPixel:26.f setContentPriority:YES];
    }
    return _companyTipLabel;
}

- (UILabel *)companyLabel{
    if (!_companyLabel) {
        _companyLabel = [UILabel labelWithTextColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentLeft fontPixel:26.f setContentPriority:NO];
    }
    return _companyLabel;
}

- (UILabel *)manageTipLabel{
    if (!_manageTipLabel) {
        _manageTipLabel = [UILabel labelWithText:@"主营：" textColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentLeft fontPixel:26.f setContentPriority:YES];
    }
    return _manageTipLabel;
}

- (UILabel *)manageLabel{
    if (!_manageLabel) {
        _manageLabel = [UILabel labelWithTextColor:CYTHexColor(@"#666666") textAlignment:NSTextAlignmentLeft fontPixel:26.f setContentPriority:NO];
    }
    return _manageLabel;
}

- (UIImageView *)arrrow{
    if (!_arrrow) {
        _arrrow = [UIImageView ff_imageViewWithImageName:@"arrow_right"];
    }
    return _arrrow;
}

- (void)setGetContactedMeListModel:(CYTGetContactedMeListModel *)getContactedMeListModel{
    _getContactedMeListModel = getContactedMeListModel;
    [self defaultShowWithGetContactedMeListModel:getContactedMeListModel];
    CYTContactRecordCarInfoModel *carInfoModel = getContactedMeListModel.carInfo;
    CYTDealer *dealer = getContactedMeListModel.dealer;
    self.readMeCarNameLabel.text = carInfoModel.carDesc;
    self.carReferPriceLabel.text = ![carInfoModel.carReferPrice integerValue]?@"":[NSString stringWithFormat:@"%@万",carInfoModel.carReferPrice];
    self.readMeTimeLabel.text = carInfoModel.contactTime;
    self.hisNameLabel.text = dealer.userName.length?dealer.userName:@"\u3000\u3000";
    [self.hisCompanyType setTitle:dealer.businessModel forState:UIControlStateNormal];
    self.starView.starValue = dealer.starScore;
    self.companyLabel.text = dealer.companyName;
    self.manageLabel.text = dealer.carBrandName;
    self.hisAuthenTag.hidden = !dealer.isStoreAuth;
    [self.hisHeaderView sd_setImageWithURL:[NSURL URLWithString:dealer.avatar] placeholderImage:kPlaceholderHeaderImage];
    extern CGFloat starWidth;
    extern CGFloat starHeight;
    if (dealer.isStoreAuth) {
        [self.hisAuthenTag mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.hisNameLabel);
            make.left.equalTo(self.hisCompanyType.mas_right).offset(CYTAutoLayoutH(10));
        }];
        [self.starView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.hisNameLabel);
            make.left.equalTo(self.hisAuthenTag.mas_right).offset(CYTAutoLayoutH(10));
            make.size.equalTo(CGSizeMake(CYTAutoLayoutV(starWidth)*self.starView.starTotalNum, CYTAutoLayoutV(starHeight)));
        }];
    }else{
        [self.starView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.hisNameLabel);
            make.left.equalTo(self.hisCompanyType.mas_right).offset(CYTAutoLayoutH(10));
            make.size.equalTo(CGSizeMake(CYTAutoLayoutV(starWidth)*self.starView.starTotalNum, CYTAutoLayoutV(starHeight)));
        }];
    }
}

- (void)defaultShowWithGetContactedMeListModel:(CYTGetContactedMeListModel *)getContactedMeListModel{
    CYTContactRecordCarInfoModel *carInfoModel = getContactedMeListModel.carInfo;
    CYTDealer *dealer = getContactedMeListModel.dealer;
    self.carReferPriceLabel.hidden = !carInfoModel.carReferPrice.length;
    self.hisNameLabel.backgroundColor = dealer.userName.length?[UIColor clearColor]:CYTLightGrayColor;
    self.companyTipLabel.text = dealer.companyName.length?@"公司：":@"\u3000\u3000\u3000\u3000\u3000";
    self.companyTipLabel.backgroundColor = dealer.userName.length?[UIColor clearColor]:CYTLightGrayColor;
    self.manageTipLabel.text = dealer.carBrandName.length?@"主营：":@"\u3000\u3000\u3000\u3000\u3000";
    self.manageTipLabel.backgroundColor = dealer.carBrandName.length?[UIColor clearColor]:CYTLightGrayColor;
}

@end
