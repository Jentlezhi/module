//
//  CYTPersonalCertificateView.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/3.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTPersonalCertificateView.h"
#import "CYTIdPhotoModel.h"
#import "CYTPersonalCertificateViewModel.h"
#import "CYTPersonalCertificateModel.h"
#import "CYTUserInfoModel.h"
#import "CYTCertificationImageView.h"
#import "CYTRefuseAuthenicateReason.h"
#import "CYTWaitCommitUserInfoModel.h"
#import "CYTInfoTipView.h"
#import "CYTIDCardTextField.h"
#import "CYTUserCertificationParameters.h"
#import "CYTRefuseAuthenicateParameters.h"
#import "CYTSignalImageUploadTool.h"
#import "CYTImageCompresser.h"

@interface CYTPersonalCertificateView()

/** 顶部提示信息 */
@property(weak, nonatomic) UILabel *upTipLabel;

/** 顶部分割条 */
@property(weak, nonatomic) UIView *topBar;

/** 姓名输入框 */
@property(weak, nonatomic) UITextField *nameTF;

/**身份证输入框 */
@property(weak, nonatomic) CYTIDCardTextField *identityCardTF;

/**身份证正面 */
@property(weak, nonatomic) CYTCertificationImageView *idFrontAddArea;

/**身份证反面 */
@property(weak, nonatomic) CYTCertificationImageView *idBackAddArea;

/**手持身份证正面 */
@property(weak, nonatomic) CYTCertificationImageView *idFrontHandAddArea;
/** 下一步按钮 */
@property(weak, nonatomic) UIButton *nextStepBtn;
/** 个人认证逻辑 */
@property(strong, nonatomic) CYTPersonalCertificateViewModel *personalCertificateViewModel;
/** 认证图片资源 */
@property(strong, nonatomic) NSMutableArray *certificatePhotos;
/** 用户填写资料模型 */
@property(strong, nonatomic) CYTPersonalCertificateModel *personalCertificateModel;
/** 数据模型 */
@property(strong, nonatomic) CYTUserInfoModel *userAuthenticateInfoModel;

/** 个人驳回原因 */
@property(copy, nonatomic) NSString *refuseReason;

/** 个人原因条数 */
@property(assign, nonatomic) NSUInteger personReasonline;

/** 企业原因条数 */
@property(assign, nonatomic) NSUInteger companyReasonline;

/** 企业驳回原因 */
@property(strong, nonatomic) NSMutableAttributedString *companyRefuseReason;

@end

@implementation CYTPersonalCertificateView
{
    //信息条
    CYTInfoTipView *_infoTipView;
    //上分割线
    UILabel *_upLineLabel;
    //姓名
    UILabel *_nameLabel;
    //中间分割线
    UILabel *_centerLineLabel;
    //身份证
    UILabel *_identityCardLabel;
    //底部分割线
    UILabel *_bottomLineLabel;
    //身份证添加区域
    UIView *_identityCardAddAreaView;
    //添加按钮
    UIButton *_addIdFrontBtn;
    //身份证正面
    UILabel *_idFrontLabel;
    //身份证反面添加按钮
    UIButton *_addIdBackBtn;
    //身份证反面
    UILabel *_idBackLabel;
    //手持身份证正面添加按钮
    UIButton *_addIdFrontHandBtn;
    //手持身份证正面
    UILabel *_idFrontHandLabel;
}

- (CYTPersonalCertificateViewModel *)personalCertificateViewModel{
    if (!_personalCertificateViewModel) {
        _personalCertificateViewModel = [[CYTPersonalCertificateViewModel alloc] init];
    }
    return _personalCertificateViewModel;
}

- (CYTPersonalCertificateModel *)personalCertificateModel{
    if (!_personalCertificateModel) {
        _personalCertificateModel = [[CYTPersonalCertificateModel alloc] init];
    }
    return _personalCertificateModel;
}

- (NSMutableArray *)certificatePhotos{
    if (!_certificatePhotos) {
        _certificatePhotos = [NSMutableArray array];
        [_certificatePhotos insertObject:@"" atIndex:0];
        [_certificatePhotos insertObject:@"" atIndex:1];
        [_certificatePhotos insertObject:@"" atIndex:2];
    }
    return _certificatePhotos;
}


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self personalCertificateBasicConfig];
        [self initPersonalCertificateComponents];
        [self makeConstraints];
        [self bindPersonalCertificateViewModel];
        [self handelTextFieldAndNextStepBtn];
        [self requestUserAuthenticateInfo];
    }
    return  self;
}
/**
 *  获取认证基本信息
 */
- (void)requestUserAuthenticateInfo{
    //获取用户认证信息
    CYTUserCertificationParameters *userCertificationParameters = [[CYTUserCertificationParameters alloc] init];
    userCertificationParameters.userID = CYTUserId;
    [CYTLoadingView showLoadingWithType:CYTLoadingViewTypeEditNavBar inView:self];
    [CYTNetworkManager POST:kURL.user_info_getUserAuthenticateInfo parameters:userCertificationParameters.mj_keyValues dataTask:nil showErrorTost:NO completion:^(CYTNetworkResponse *responseObject) {
        [CYTLoadingView hideLoadingView];
        if (responseObject.resultEffective) {
            CYTUserInfoModel *userAuthenticateInfoModel = [CYTUserInfoModel mj_objectWithKeyValues:responseObject.dataDictionary];
            //本地appmaager记录已填写参数
            CYTAppManager *appManager = [CYTAppManager sharedAppManager];
            appManager.IDCard = userAuthenticateInfoModel.idCard;
            //返回imageurl处理
            [self getLastComponentWithContent:userAuthenticateInfoModel.frontIdCardOriginalPic];
            appManager.FrontIDCardOriginalPic = [self getLastComponentWithContent:userAuthenticateInfoModel.frontIdCardOriginalPic];
            appManager.OppositeIDCardOriginalPic = [self getLastComponentWithContent:userAuthenticateInfoModel.oppositeIdCardOriginalPic];
            appManager.HoldIDCardOriginalPic = [self getLastComponentWithContent:userAuthenticateInfoModel.holdIdCardOriginalPic];
            appManager.BusinessLlicenseOriginalPic = [self getLastComponentWithContent:userAuthenticateInfoModel.businessLicenseOriginalPic];
            appManager.ExhibitOriginalPic = [self getLastComponentWithContent:userAuthenticateInfoModel.exhibitOriginalPic];
            appManager.CompanyName = userAuthenticateInfoModel.companyName;
            appManager.ProvinceID = userAuthenticateInfoModel.provinceId;
            appManager.ProvinceName = userAuthenticateInfoModel.provinceName;
            appManager.CityID = userAuthenticateInfoModel.cityId;
            appManager.CityName = userAuthenticateInfoModel.cityName;
            appManager.detailAddress = userAuthenticateInfoModel.registerAddress;
            appManager.LevelId = [userAuthenticateInfoModel.companyTypeId integerValue];
            appManager.LevelName = userAuthenticateInfoModel.companyType;
            appManager.manageBrandId = userAuthenticateInfoModel.carBrandIdStr;
            appManager.manageBrand = userAuthenticateInfoModel.carBrandStr;
            appManager.countryId = userAuthenticateInfoModel.countryId > 0?userAuthenticateInfoModel.countryId:userAuthenticateInfoModel.cityId;
            self.userAuthenticateInfoModel = userAuthenticateInfoModel;
            [CYTAccountManager sharedAccountManager].authStatus = userAuthenticateInfoModel.authStatus;
            if (userAuthenticateInfoModel.authStatus == -2) {
                [self requestRefuseDataWithAuthenticateID:userAuthenticateInfoModel.authenticateId];
            }
        }
    }];
}

- (NSString *)getLastComponentWithContent:(NSString *)content{
    NSArray *temp = [content componentsSeparatedByString:@"/"];
    return [temp lastObject];
}
/**
 *  获取驳回原因
 */
- (void)requestRefuseDataWithAuthenticateID:(NSString *)authenticateID{
    CYTRefuseAuthenicateParameters *refuseAuthenicateParameters = [[CYTRefuseAuthenicateParameters alloc] init];
    refuseAuthenicateParameters.authenticateID = authenticateID;
    [CYTLoadingView showLoadingWithType:CYTLoadingViewTypeEditNavBar];
    [CYTNetworkManager POST:kURL.user_info_getRefuseAuthenicateType parameters:refuseAuthenicateParameters.mj_keyValues dataTask:nil showErrorTost:NO completion:^(CYTNetworkResponse *responseObject) {
        [CYTLoadingView hideLoadingView];
        NSArray *resaonArray = [CYTRefuseAuthenicateReason mj_objectArrayWithKeyValuesArray:[responseObject.dataDictionary valueForKey:@"data"]];
        [self autolayoutRefuseResonLabelWithArray:resaonArray];
    }];
    
}
/**
 *  基本配置
 */
- (void)personalCertificateBasicConfig{
    self.backgroundColor = [UIColor whiteColor];
}

/**
 *  初始化子控件
 */
- (void)initPersonalCertificateComponents{
    CYTInfoTipView *infoTipView = [[CYTInfoTipView alloc] init];
    infoTipView.message = @"您上传的所有证件均仅用于车销通用户认证。";
    [self addSubview:infoTipView];
    _infoTipView = infoTipView;
    
    //顶部分割条
    UIView *topBar = [[UIView alloc] init];
    topBar.backgroundColor = kFFColor_bg_nor;
    [self addSubview:topBar];
    _topBar = topBar;

    //顶部提示信息
    UILabel *upTipLabel = [[UILabel alloc] init];
    upTipLabel.textAlignment = NSTextAlignmentCenter;
    upTipLabel.font = CYTFontWithPixel(24);
    upTipLabel.text = @"个人认证完成后，请继续企业认证";
    upTipLabel.textColor = [UIColor colorWithHexColor:@"#666666"];
    upTipLabel.numberOfLines = 0;
    [self addSubview:upTipLabel];
    _upTipLabel = upTipLabel;
    
    //顶部分割线
    UILabel *upLineLabel = [[UILabel alloc] init];
    upLineLabel.backgroundColor = [UIColor colorWithHexColor:@"#efefef"];
    [self addSubview:upLineLabel];
    _upLineLabel = upLineLabel;

    //姓名
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    nameLabel.font = CYTFontWithPixel(30);
    nameLabel.text = @"姓名";
    nameLabel.textColor = [UIColor colorWithHexColor:@"#333333"];
    [self addSubview:nameLabel];
    _nameLabel = nameLabel;

    //姓名输入框
    UITextField *nameTF = [[UITextField alloc] init];
    nameTF.placeholder = @"请输入您的姓名";
    nameTF.keyboardType = UIKeyboardTypeDefault;
    nameTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    //    codeTF.tintColor = CYTGrayColor(51);
    nameTF.textColor = [UIColor colorWithHexColor:@"#999999"];
    nameTF.font = CYTFontWithPixel(30);
    [self addSubview:nameTF];
    _nameTF = nameTF;

    
    //中间分割线
    UILabel *centerLineLabel = [[UILabel alloc] init];
    centerLineLabel.backgroundColor = [UIColor colorWithHexColor:@"#efefef"];
    [self addSubview:centerLineLabel];
    _centerLineLabel = centerLineLabel;

    //身份证
    UILabel *identityCardLabel = [[UILabel alloc] init];
    identityCardLabel.textAlignment = NSTextAlignmentLeft;
    identityCardLabel.font = CYTFontWithPixel(30);
    identityCardLabel.text = @"身份证号码";
    identityCardLabel.textColor = [UIColor colorWithHexColor:@"#333333"];
    [self addSubview:identityCardLabel];
    _identityCardLabel = identityCardLabel;

    //身份证输入框
    CYTIDCardTextField *identityCardTF = [[CYTIDCardTextField alloc] init];
    identityCardTF.placeholder = @"请输入您的身份证号码";
    identityCardTF.textColor = [UIColor colorWithHexColor:@"#999999"];
    identityCardTF.font = CYTFontWithPixel(30);
    [self addSubview:identityCardTF];
    _identityCardTF = identityCardTF;

    
    //底部分割线
    UILabel *bottomLineLabel = [[UILabel alloc] init];
    bottomLineLabel.backgroundColor = [UIColor colorWithHexColor:@"#efefef"];
    [self addSubview:bottomLineLabel];
    _bottomLineLabel = bottomLineLabel;

    
    //身份证添加区域
    UIView *identityCardAddAreaView = [[UIView alloc] init];
    //    identityCardAddAreaView.backgroundColor = [UIColor orangeColor];
    [self addSubview:identityCardAddAreaView];
    _identityCardAddAreaView = identityCardAddAreaView;
    
    //身份证正面添加区域
    CYTCertificationImageView *idFrontAddArea = [[CYTCertificationImageView alloc] init];
//    idFrontAddArea.backgroundColor = [UIColor redColor];
    idFrontAddArea.idType = CYTIdTypeFront;
    idFrontAddArea.userInteractionEnabled = YES;
    idFrontAddArea.contentMode =  UIViewContentModeScaleAspectFill;
    //    idFrontAddArea.backgroundColor = [UIColor orangeColor];
    idFrontAddArea.layer.borderWidth = 1.5f;
    idFrontAddArea.layer.borderColor = [UIColor colorWithHexColor:@"#999999"].CGColor;
    idFrontAddArea.layer.cornerRadius = 6;
    idFrontAddArea.layer.masksToBounds = YES;
    [identityCardAddAreaView addSubview:idFrontAddArea];
    _idFrontAddArea = idFrontAddArea;
    
    //添加点击事件
    UITapGestureRecognizer *idFrontAddAreaTap = [[UITapGestureRecognizer alloc] init];
    [[idFrontAddAreaTap rac_gestureSignal] subscribeNext:^(id x) {
        !self.identityCardFront?:self.identityCardFront();
    }];
    [idFrontAddArea addGestureRecognizer:idFrontAddAreaTap];

    
    //点击回调
    idFrontAddArea.identityCardFront = ^{
        !self.identityCardFront?:self.identityCardFront();
    };

    //添加按钮
    UIButton *addIdFrontBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addIdFrontBtn setBackgroundImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    addIdFrontBtn.adjustsImageWhenHighlighted = NO;
    [idFrontAddArea addSubview:addIdFrontBtn];
    _addIdFrontBtn = addIdFrontBtn;

    
    [[addIdFrontBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        !self.identityCardFront?:self.identityCardFront();
    }];
    //身份证正面
    UILabel *idFrontLabel = [[UILabel alloc] init];
    idFrontLabel.textColor = [UIColor colorWithHexColor:@"#999999"];
    idFrontLabel.textAlignment = NSTextAlignmentCenter;
    idFrontLabel.font = CYTFontWithPixel(22);
    idFrontLabel.text = @"身份证正面";
    [idFrontAddArea addSubview:idFrontLabel];
    _idFrontLabel = idFrontLabel;

    
    //身份证反面添加区域
    CYTCertificationImageView *idBackAddArea = [[CYTCertificationImageView alloc] init];
    idBackAddArea.idType = CYTIdTypeBack;
    idBackAddArea.userInteractionEnabled = YES;
    idBackAddArea.contentMode =  UIViewContentModeScaleAspectFill;
    idBackAddArea.layer.borderWidth = 1.5f;
    idBackAddArea.layer.borderColor = [UIColor colorWithHexColor:@"#999999"].CGColor;
    idBackAddArea.layer.cornerRadius = 6;
    idBackAddArea.layer.masksToBounds = YES;
    [identityCardAddAreaView addSubview:idBackAddArea];
    _idBackAddArea = idBackAddArea;
    
    //添加点击事件
    UITapGestureRecognizer *idBackAddAreaTap = [[UITapGestureRecognizer alloc] init];
    [[idBackAddAreaTap rac_gestureSignal] subscribeNext:^(id x) {
        !self.identityCardBack?:self.identityCardBack();
    }];
    [idBackAddArea addGestureRecognizer:idBackAddAreaTap];

    //点击回调
    idBackAddArea.identityCardBack = ^{
        !self.identityCardBack?:self.identityCardBack();
    };

    //身份证反面添加按钮
    UIButton *addIdBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addIdBackBtn setBackgroundImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    addIdBackBtn.adjustsImageWhenHighlighted = NO;
    [idBackAddArea addSubview:addIdBackBtn];
    _addIdBackBtn = addIdBackBtn;

    
    [[addIdBackBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        !self.identityCardBack?:self.identityCardBack();
    }];
    //身份证反面
    UILabel *idBackLabel = [[UILabel alloc] init];
    idBackLabel.textColor = [UIColor colorWithHexColor:@"#999999"];
    idBackLabel.textAlignment = NSTextAlignmentCenter;
    idBackLabel.font = CYTFontWithPixel(22);
    idBackLabel.text = @"身份证反面";
    [idBackAddArea addSubview:idBackLabel];
    _idBackLabel = idBackLabel;

    //手持身份证正面添加区域
    CYTCertificationImageView *idFrontHandAddArea = [[CYTCertificationImageView alloc] init];
    idFrontHandAddArea.idType = CYTIdTypeFrontWithHand;
    idFrontHandAddArea.userInteractionEnabled = YES;
    idFrontHandAddArea.contentMode =  UIViewContentModeScaleAspectFill;
    idFrontHandAddArea.layer.borderWidth = 1.5f;
    idFrontHandAddArea.layer.borderColor = [UIColor colorWithHexColor:@"#999999"].CGColor;
    idFrontHandAddArea.layer.cornerRadius = 6;
    idFrontHandAddArea.layer.masksToBounds = YES;
    [identityCardAddAreaView addSubview:idFrontHandAddArea];
    _idFrontHandAddArea = idFrontHandAddArea;
    
    //添加点击事件
    UITapGestureRecognizer *idFrontHandAddAreaTap = [[UITapGestureRecognizer alloc] init];
    [[idFrontHandAddAreaTap rac_gestureSignal] subscribeNext:^(id x) {
        !self.identityCardWithHand?:self.identityCardWithHand();
    }];
    [idFrontHandAddArea addGestureRecognizer:idFrontHandAddAreaTap];

    //点击回调
    idFrontHandAddArea.identityCardWithHand = ^{
        !self.identityCardWithHand?:self.identityCardWithHand();
    };

    //手持身份证正面添加按钮
    UIButton *addIdFrontHandBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addIdFrontHandBtn setBackgroundImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    addIdFrontHandBtn.adjustsImageWhenHighlighted = NO;
    [idFrontHandAddArea addSubview:addIdFrontHandBtn];
    _addIdFrontHandBtn= addIdFrontHandBtn;

    
    [[_addIdFrontHandBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        !self.identityCardWithHand?:self.identityCardWithHand();
    }];
    //手持身份证正面
    UILabel *idFrontHandLabel = [[UILabel alloc] init];
    idFrontHandLabel.textColor = [UIColor colorWithHexColor:@"#999999"];
    idFrontHandLabel.textAlignment = NSTextAlignmentCenter;
    idFrontHandLabel.font = CYTFontWithPixel(22);
    idFrontHandLabel.text = @"手持身份证正面照";
    [idFrontHandAddArea addSubview:idFrontHandLabel];
    _idFrontHandLabel = idFrontHandLabel;

    
    //下一步按钮
    UIButton *nextStepBtn = [UIButton buttonWithTitle:@"下一步" enabled:NO];
    [self addSubview:nextStepBtn];
    _nextStepBtn = nextStepBtn;
    CYTWeakSelf
    [[nextStepBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        nextStepBtn.enabled = NO;
        [[weakSelf.personalCertificateViewModel.netStepCommand execute:nil] subscribeNext:^(CYTPersonalCertificateModel *personalCertificateModel) {
            nextStepBtn.enabled = YES;
            if (!personalCertificateModel)return;
            !self.personalCertificateNextStep?:self.personalCertificateNextStep(personalCertificateModel,self.companyReasonline,self.companyRefuseReason);
        }];
        
    }];
    
}

- (void)makeConstraints{
    //重新布局
    CYTWeakSelf
    typeof(_topBar) weakTopBar = _topBar;
    _infoTipView.removeActionBlock = ^{
        [weakTopBar mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(CYTViewOriginY);
        }];
        
        [UIView animateWithDuration:0.2f animations:^{
            [weakSelf layoutIfNeeded];
        }];
    };
    
    [_infoTipView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(CYTViewOriginY);
        make.left.right.equalTo(weakSelf);
        make.height.equalTo(CYTAutoLayoutV(80.f));
    }];
    [_topBar mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_infoTipView.mas_bottom);
        make.left.right.equalTo(weakSelf);
        make.height.equalTo(CYTAutoLayoutV(22));
    }];

    [_upTipLabel remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topBar.mas_bottom).offset(CYTAutoLayoutV(30));
        make.centerX.equalTo(weakSelf);
        if (weakSelf.personReasonline) {
            make.height.equalTo((_upTipLabel.font.pointSize+2)*weakSelf.personReasonline+(weakSelf.personReasonline+1)*CYTAutoLayoutV(10));
        }else{
            make.height.equalTo(CYTAutoLayoutV(140));
        }
        
    }];
    
    [_upLineLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(CYTMarginH);
        make.right.equalTo(self).offset(-CYTMarginH);
        make.top.equalTo(_upTipLabel.mas_bottom).offset(CYTAutoLayoutV(20));
        make.height.equalTo(CYTDividerLineWH);
    }];
    
    [_nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(CYTMarginH);
        make.top.equalTo(_upLineLabel.mas_bottom).offset(CYTAutoLayoutV(32));
        make.size.equalTo(CGSizeMake(CYTAutoLayoutH(34*6), CYTAutoLayoutV(34)));
    }];
    
    [_nameTF mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel.mas_right);
        make.centerY.equalTo(_nameLabel);
        make.height.equalTo(CYTAutoLayoutV(34));
        make.right.equalTo(self).offset(-CYTMarginH);
    }];
    
    [_centerLineLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel);
        make.top.equalTo(_nameLabel.mas_bottom).offset(CYTAutoLayoutV(32));
        make.right.equalTo(_nameTF);
        make.height.equalTo(CYTDividerLineWH);
    }];

    [_identityCardLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel);
        make.top.equalTo(_centerLineLabel.mas_bottom).offset(CYTAutoLayoutV(32));
        make.size.equalTo(CGSizeMake(CYTAutoLayoutH(34*6), CYTAutoLayoutV(34)));
    }];
    
    [_identityCardTF remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_identityCardLabel.mas_right);
        make.centerY.equalTo(_identityCardLabel);
        make.height.equalTo(CYTAutoLayoutV(34));
        make.right.equalTo(_nameTF);
    }];
    
    [_bottomLineLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_identityCardLabel);
        make.top.equalTo(_identityCardLabel.mas_bottom).offset(CYTAutoLayoutV(32));
        make.right.equalTo(_identityCardTF);
        make.height.equalTo(CYTDividerLineWH);
    }];
    
    [_identityCardAddAreaView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bottomLineLabel.mas_bottom).offset(CYTAutoLayoutV(58));
        make.left.equalTo(self).offset(CYTAutoLayoutH(56));
        make.right.equalTo(self).offset(-CYTAutoLayoutH(56));
        make.height.equalTo(CYTAutoLayoutV(156*2+22));
    }];
    
    [_idFrontAddArea mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(_identityCardAddAreaView);
        make.size.equalTo(CGSizeMake(CYTAutoLayoutH(296), CYTAutoLayoutV(156)));
    }];

    [_addIdFrontBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_idFrontAddArea).offset(CYTAutoLayoutV(20));
        make.centerX.equalTo(_idFrontAddArea);
        make.size.equalTo(CGSizeMake(CYTAutoLayoutV(66), CYTAutoLayoutV(66)));
    }];
    
    [_idFrontLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_addIdFrontBtn.mas_bottom).offset(CYTAutoLayoutV(20));
        make.centerX.equalTo(_idFrontAddArea);
        make.height.equalTo(_idFrontLabel.font.pointSize);
    }];
    
    [_idBackAddArea mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(_identityCardAddAreaView);
        make.size.equalTo(CGSizeMake(CYTAutoLayoutH(296), CYTAutoLayoutV(156)));
    }];
    
    [_addIdBackBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_idBackAddArea).offset(CYTAutoLayoutV(20));
        make.centerX.equalTo(_idBackAddArea);
        make.size.equalTo(CGSizeMake(CYTAutoLayoutV(66), CYTAutoLayoutV(66)));
    }];
    
    [_idBackLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_addIdBackBtn.mas_bottom).offset(CYTAutoLayoutV(20));
        make.centerX.equalTo(_idBackAddArea);
        make.height.equalTo(_idBackLabel.font.pointSize);
    }];
    
    [_idFrontHandAddArea mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(_identityCardAddAreaView);
        make.size.equalTo(CGSizeMake(CYTAutoLayoutH(296), CYTAutoLayoutV(156)));
    }];
    
    [_addIdFrontHandBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_idFrontHandAddArea).offset(CYTAutoLayoutV(20));
        make.centerX.equalTo(_idFrontHandAddArea);
        make.size.equalTo(CGSizeMake(CYTAutoLayoutV(66), CYTAutoLayoutV(66)));
    }];
    
    [_idFrontHandLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_addIdFrontHandBtn.mas_bottom).offset(CYTAutoLayoutV(20));
        make.centerX.equalTo(_idFrontHandAddArea);
        make.height.equalTo(_idFrontHandLabel.font.pointSize);
    }];
    
    [_nextStepBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(CYTMarginH);
        make.right.equalTo(self).offset(-CYTMarginH);
        make.top.equalTo(_identityCardAddAreaView.mas_bottom).offset(CYTAutoLayoutV(58));
        make.height.equalTo(CYTAutoLayoutV(92));
    }];
}

- (void)setPhotoModel:(CYTIdPhotoModel *)photoModel{
    _photoModel = photoModel;
    //上传图片
    [self uploadwithImage:photoModel.selectedImage type:photoModel.idType];
    //参数赋值
    self.personalCertificateViewModel.personalCertificateModel = self.personalCertificateModel;
}

/**
 * 图片上传
 */
- (void)uploadwithImage:(UIImage *)image type:(CYTIdType)idType{
    CYTWeakSelf
    //图片压缩
//    UIImage *resultImage = [CYTImageCompresser compressImage:image];
    UIImage *resultImage = [image compressedToSize:kImageCompressedMaxSize];
    [CYTLoadingView showLoadingWithType:CYTLoadingViewTypeEditNavBar];
    [CYTSignalImageUploadTool uploadWithImage:resultImage parameters:nil url:kURL.user_file_userUpLoadImg success:^(CYTUploadImageResult *result) {
        CYTAppManager *appManager = [CYTAppManager sharedAppManager];
        CYTImageFileModel *fileModel = [CYTImageFileModel mj_objectWithKeyValues:result.data];
        if (!result.result) return;
        if (idType == CYTIdTypeFront) {
            if (fileModel.fileName.length) {//上传成功
                //隐藏按钮
                [_idFrontAddArea.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    obj.hidden = YES;
                }];
                appManager.FrontIDCardOriginalPic = fileModel.fileName;
                
                //图片框显示图片
                self.idFrontAddArea.image = resultImage;
                //添加水印
                [self.idFrontAddArea addWatermarkWithImageName:@"img_watermark_130x90_logo"];
                [weakSelf.certificatePhotos replaceObjectAtIndex:CYTIdTypeFront withObject:[NSNumber numberWithUnsignedInteger:CYTIdTypeFront]];
            }else{//上传失败
                
            }
            
        }else if (idType == CYTIdTypeBack){
            if (fileModel.fileName.length) {
                //隐藏按钮
                [_idBackAddArea.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    obj.hidden = YES;
                }];
                appManager.OppositeIDCardOriginalPic = fileModel.fileName;
                self.idBackAddArea.image = resultImage;
                //添加水印
                [self.idBackAddArea addWatermarkWithImageName:@"img_watermark_130x90_logo"];
                [weakSelf.certificatePhotos replaceObjectAtIndex:CYTIdTypeBack withObject:[NSNumber numberWithUnsignedInteger:CYTIdTypeBack]];
            }else{
                
            }
            
        }else{
            if (fileModel.fileName.length) {
                [_idFrontHandAddArea.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    obj.hidden = YES;
                }];
                appManager.HoldIDCardOriginalPic = fileModel.fileName;
                self.idFrontHandAddArea.image = image;
                //添加水印
                [self.idFrontHandAddArea addWatermarkWithImageName:@"img_watermark_130x90_logo"];
                [weakSelf.certificatePhotos replaceObjectAtIndex:CYTIdTypeFrontWithHand withObject:[NSNumber numberWithUnsignedInteger:CYTIdTypeFrontWithHand]];
            }
        }
        weakSelf.personalCertificateViewModel.certificatePhotos = weakSelf.certificatePhotos;
    } fail:nil];
}

- (void)setShowKeyboard:(BOOL)showKeyboard{
    _showKeyboard = showKeyboard;
    if (showKeyboard) {
        [self.nameTF becomeFirstResponder];
    }
    
}

/**
 *  绑定viewModel
 */
- (void)bindPersonalCertificateViewModel{
    RAC(self.personalCertificateViewModel,name) = _nameTF.rac_textSignal;
    RAC(self.personalCertificateViewModel,idCardNum) = _identityCardTF.rac_textSignal;
}
/**
 *  处理输入框和下一步按钮
 */
- (void)handelTextFieldAndNextStepBtn{
    //限制账号的输入位数
    [_nameTF.rac_textSignal subscribeNext:^(NSString *inputString) {
        if (inputString.length > CYTNameLengthMax) {
            _nameTF.text = [inputString substringToIndex:CYTNameLengthMax];
        }
    }];
    
    //身份证号码的输入位数
    [_identityCardTF.rac_textSignal subscribeNext:^(NSString *inputString) {
        if (inputString.length > CYTIdCardLengthMax) {
            _identityCardTF.text = [inputString substringToIndex:CYTIdCardLengthMax];
        }
    }];
    
    //登录按钮是否可点击
    RAC(_nextStepBtn,enabled) = self.personalCertificateViewModel.netStepEnableSiganl;
}

- (void)autolayoutRefuseResonLabelWithArray:(NSArray *)resaonArray{
    NSMutableArray *personalReasonArray = [NSMutableArray array];
    NSMutableArray *companyReasonArray = [NSMutableArray array];
    [resaonArray enumerateObjectsUsingBlock:^(CYTRefuseAuthenicateReason *item, NSUInteger idx, BOOL * _Nonnull stop) {
        if (item.refuseTypeID == 1) {//个人认证驳回
            if (item.refuseReason.length) {
                [personalReasonArray addObject:item.refuseReason];
            }
        }else{
            if (item.refuseReason.length) {
                [companyReasonArray addObject:item.refuseReason];
            }
        }
    }];
    
    _upTipLabel.textColor = [UIColor redColor];
    _upTipLabel.font = CYTFontWithPixel(30);
    if (personalReasonArray.count) {
        _upTipLabel.attributedText = [self attributedStringWithStringArray:personalReasonArray];
    }
    //布局驳回信息
    self.personReasonline = personalReasonArray.count;
    //更新约束
    [self makeConstraints];
    //传入企业认证的参数
    if (!companyReasonArray.count) return;
    self.companyReasonline = companyReasonArray.count;
    self.companyRefuseReason = [self attributedStringWithStringArray:companyReasonArray];
}

- (NSMutableAttributedString *)attributedStringWithStringArray:(NSArray *)stringArray{
    NSMutableAttributedString *mString = [[NSMutableAttributedString alloc] initWithString:[stringArray componentsJoinedByString:@"\n"]];
    CGFloat lineSpace = CYTAutoLayoutV(10);
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [mString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, mString.length)];
    return mString;
}

- (void)setUserAuthenticateInfoModel:(CYTUserInfoModel *)userAuthenticateInfoModel{
    _userAuthenticateInfoModel = userAuthenticateInfoModel;
    _nameTF.text = userAuthenticateInfoModel.userName;
    self.personalCertificateViewModel.name = userAuthenticateInfoModel.userName;
    _identityCardTF.text = userAuthenticateInfoModel.idCard;
    self.personalCertificateViewModel.idCardNum = userAuthenticateInfoModel.idCard;
    CYTSetSDWebImageHeader
    [_idFrontAddArea sd_setImageWithURL:[NSURL URLWithString:userAuthenticateInfoModel.frontIdCardOriginalPic] placeholderImage:nil];
    [_idBackAddArea sd_setImageWithURL:[NSURL URLWithString:userAuthenticateInfoModel.oppositeIdCardOriginalPic] placeholderImage:nil];
    [_idFrontHandAddArea sd_setImageWithURL:[NSURL URLWithString:userAuthenticateInfoModel.holdIdCardOriginalPic] placeholderImage:nil];
    
    if (userAuthenticateInfoModel.frontIdCardOriginalPic.length) {
        [_idFrontAddArea.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.hidden = YES;
        }];
        [self.certificatePhotos replaceObjectAtIndex:CYTIdTypeFront withObject:[NSNumber numberWithUnsignedInteger:CYTIdTypeFront]];
    }
    if (userAuthenticateInfoModel.oppositeIdCardOriginalPic.length){
        [_idBackAddArea.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.hidden = YES;
        }];
        [self.certificatePhotos replaceObjectAtIndex:CYTIdTypeBack withObject:[NSNumber numberWithUnsignedInteger:CYTIdTypeBack]];
    }
    if (userAuthenticateInfoModel.holdIdCardOriginalPic.length){
        [_idFrontHandAddArea.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.hidden = YES;
        }];
        [self.certificatePhotos replaceObjectAtIndex:CYTIdTypeFrontWithHand withObject:[NSNumber numberWithUnsignedInteger:CYTIdTypeFrontWithHand]];
    }
    
    self.personalCertificateViewModel.certificatePhotos = self.certificatePhotos;
}


@end
