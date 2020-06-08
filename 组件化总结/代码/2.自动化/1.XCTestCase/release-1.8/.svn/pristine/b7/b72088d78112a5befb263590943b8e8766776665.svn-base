//
//  CYTCompanyCertificateView.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/3.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCompanyCertificateView.h"
#import "CYTCompanyCertificateModel.h"
#import "CYTManageBrandModel.h"
#import "CYTCompanyCertificateViewModel.h"
#import "CYTImageFileModel.h"
#import "CYTPersonalCertificateModel.h"
#import "CYTManageTypeModel.h"
#import "CYTCommitCertificateResult.h"
#import "CYTUserInfoModel.h"
#import "CYTCertificationImageView.h"
#import "CYTRefuseAuthenicateReason.h"
#import "CYTSignalImageUploadTool.h"
#import "CYTImageCompresser.h"


@interface CYTCompanyCertificateView()

/** 顶部提示信息 */
@property(weak, nonatomic) UILabel *upTipLabel;

/** 公司名称输入框 */
@property(weak, nonatomic) UITextField *companyNameTF;

/** 注册地址输入框 */
@property(weak, nonatomic) UITextField *registerAddressTF;

/** 经营类型 */
@property(weak, nonatomic) UILabel *manageTypeLabel;

/** 主营品牌 */
@property(weak, nonatomic) UILabel *manageBrandLabel;

/** 营业执照 */
@property(weak, nonatomic) CYTCertificationImageView *businessLicense;

/** 展厅照片 */
@property(weak, nonatomic) CYTCertificationImageView *showroomPhoto;
/** 提交审核按钮 */
@property(strong, nonatomic) UIButton *commitBtn;

/** 企业认证逻辑 */
@property(strong, nonatomic) CYTCompanyCertificateViewModel *companyCertificateViewModel;
/** 认证图片资源 */
@property(strong, nonatomic) NSMutableArray *certificatePhotos;

@end

@implementation CYTCompanyCertificateView
{
    //顶部分割条
    UIView *_topBar;
    //上分割线
    UILabel *_upLineLabel;
    //公司名称
    UILabel *_companyNameLabel;
    //公司名称分割线
    UILabel *_companyLineLabel;
    //注册地址
    UILabel *_registerAddressTipLabel;
    //注册地址前往按钮
//    UIButton *_registerAddressGoNextBtn;
    //注册地址分割线
    UILabel *_registerAddressLineLabel;
//    //注册地址添加手势
//    UIView *_registerATapView;
    //经营类型
    UILabel *_manageTypeTipLabel;
    //经营类型前往按钮
    UIButton *_manageTypeGoNextBtn;
    //经营类型分割线
    UILabel *_manageTypeLineLabel;
    //经营类型添加手势
    UIView *_manageTypeTapView;
    //主营品牌
    UILabel *_manageBrandTipLabel;
    //主营品牌前往按钮
    UIButton *_manageBrandGoNextBtn;
    //主营品牌分割线
    UILabel *_manageBrandLineLabel;
    //主营品牌添加手势
    UIView *_manageBrandTapView;
    //营业执照添加区域
    UIView *_companyCertificateAddAreaView;
    //添加按钮
    UIButton *_addBusinessLicenseBtn;
    //营业执照
    UILabel *_businessLicenseLabel;
    //展厅照片添加按钮
    UIButton *_showroomPhotoBtn;
    //展厅照片
    UILabel *_showroomLabel;
    
    //所在地区父视图
    UIView *_areraView;
    //所在地区
    UILabel *_areraTipLabel;
    UILabel *_areraLabel;
    UILabel *_areraLineLabel;
    //箭头
    UIImageView *_areraArrow;
}

- (CYTCompanyCertificateViewModel *)companyCertificateViewModel{
    if (!_companyCertificateViewModel) {
        _companyCertificateViewModel = [[CYTCompanyCertificateViewModel alloc] init];
    }
    return _companyCertificateViewModel;
}

- (NSMutableArray *)certificatePhotos{
    if (!_certificatePhotos) {
        _certificatePhotos = [NSMutableArray array];
        [_certificatePhotos insertObject:@"" atIndex:0];
        [_certificatePhotos insertObject:@"" atIndex:1];
    }
    return _certificatePhotos;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self companyCertificateViewBasicConfig];
        [self initCompanyCertificateViewComponents];
        [self makeConstrains];
        [self bindCompanyCertificateeViewModel];
        [self handelTextFieldAndcommitBtn];
        [self handelCommitButton];
    }
    return  self;
}
/**
 *  基本配置
 */
- (void)companyCertificateViewBasicConfig{
    self.backgroundColor = [UIColor whiteColor];
}

/**
 *  处理提交按钮
 */
- (void)handelCommitButton{
    //设置显示提交按钮
    /*
     认证结果 备注：-2：认证被驳回；0：初始化（未填写认证信息）；1：已填写/提交认证信息；2：认证审核通过
     */
    NSInteger authStatus = [CYTAccountManager sharedAccountManager].authStatus;
    if (authStatus == 2 || authStatus == 1) {
        _commitBtn.hidden = YES;
    }else{
        _commitBtn.hidden = NO;
    }
}
/**
 *  添加约束
 */
- (void)makeConstrains{
    [_topBar remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(CYTViewOriginY);
        make.left.right.equalTo(self);
        make.height.equalTo(CYTAutoLayoutV(22));
    }];
    
    [_upTipLabel remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topBar.mas_bottom).offset(CYTAutoLayoutV(20));
        make.centerX.equalTo(self);
        if (self.reasonLine) {
            make.height.equalTo((_upTipLabel.font.pointSize+2)*self.reasonLine+(self.reasonLine+1)*CYTAutoLayoutV(10));
        }else{
            make.height.equalTo(CYTAutoLayoutV(180));
        }
        
    }];
    
    [_upLineLabel remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(CYTMarginH);
        make.right.equalTo(self).offset(-CYTMarginH);
        make.top.equalTo(_upTipLabel.mas_bottom).offset(CYTAutoLayoutV(20));
        make.height.equalTo(CYTDividerLineWH);
    }];
    
    [_companyNameLabel remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_upLineLabel);
        make.top.equalTo(_upLineLabel.mas_bottom).offset(CYTAutoLayoutV(32));
    }];
    
    [_companyNameTF remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_companyNameLabel.mas_right).offset(CYTItemMarginH);
        make.centerY.equalTo(_companyNameLabel);
        make.height.equalTo(CYTAutoLayoutV(34));
        make.right.equalTo(_upLineLabel);
    }];
    
    [_companyLineLabel remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(_upLineLabel);
        make.top.equalTo(_companyNameLabel.mas_bottom).offset(CYTAutoLayoutV(32));
    }];
    
    [_areraView remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(_companyLineLabel.mas_bottom);
        make.height.equalTo(CYTAutoLayoutV(90));
    }];
    
    [_areraLineLabel remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(_upLineLabel);
        make.top.equalTo(_areraView.mas_bottom).offset(CYTDividerLineWH);
        make.height.equalTo(CYTDividerLineWH);
    }];
    
    
    
    [_areraTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_companyNameLabel.mas_left);
        make.centerY.equalTo(_areraView);
        make.width.equalTo(_companyNameLabel);
    }];
    
    [_areraLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_areraTipLabel.mas_right).offset(CYTItemMarginH);
        make.centerY.equalTo(_areraView);
        make.right.equalTo(_areraView).offset(-CYTMarginH);
    }];
    [_areraArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-CYTMarginH);
        make.centerY.equalTo(_areraLabel);
    }];
    [_registerAddressTipLabel remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(CYTMarginH);
        make.top.equalTo(_areraView.mas_bottom).offset(CYTAutoLayoutV(32));
    }];
    
    [_registerAddressTF remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_registerAddressTipLabel.mas_right).offset(CYTItemMarginH);
        make.centerY.equalTo(_registerAddressTipLabel);
        make.height.equalTo(CYTAutoLayoutV(34));
        make.right.equalTo(_companyNameTF);
    }];
    
//    [_registerAddressGoNextBtn remakeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(_registerAddressTF);
//        make.centerY.equalTo(_registerAddressLabel);
//        make.size.equalTo(CGSizeMake(CYTAutoLayoutV(17), CYTAutoLayoutV(29)));
//    }];
    
    [_registerAddressLineLabel remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(_upLineLabel);
        make.top.equalTo(_registerAddressTF.mas_bottom).offset(CYTAutoLayoutV(32));
    }];
    
//    [_registerATapView remakeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(_upLineLabel);
//        make.top.equalTo(_areraView.mas_bottom);
//        make.bottom.equalTo(_registerAddressLineLabel.mas_top);
//    }];
    
    [_manageTypeTipLabel remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(CYTMarginH);
        make.top.equalTo(_registerAddressLineLabel.mas_bottom).offset(CYTAutoLayoutV(32));
    }];
    
    [_manageTypeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_manageTypeTipLabel.mas_right).offset(CYTItemMarginH);
        make.centerY.equalTo(_manageTypeTipLabel);
        make.height.equalTo(CYTAutoLayoutV(34));
        make.right.equalTo(_companyNameTF);
    }];
    
    [_manageTypeGoNextBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_manageTypeLabel);
        make.centerY.equalTo(_manageTypeLabel);
        make.size.equalTo(CGSizeMake(CYTAutoLayoutV(17), CYTAutoLayoutV(29)));
    }];
    
    [_manageTypeLineLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(_upLineLabel);
        make.top.equalTo(_manageTypeTipLabel.mas_bottom).offset(CYTAutoLayoutV(32));
    }];
    
    [_manageTypeTapView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_upLineLabel);
        make.top.equalTo(_registerAddressLineLabel.mas_bottom);
        make.bottom.equalTo(_manageTypeLineLabel.mas_top);
    }];
    
    [_manageBrandTipLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(CYTMarginH);
        make.top.equalTo(_manageTypeLineLabel.mas_bottom).offset(CYTAutoLayoutV(32));
    }];
    
    [_manageBrandLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_manageBrandTipLabel.mas_right).offset(CYTItemMarginH);
        make.centerY.equalTo(_manageBrandTipLabel);
        make.height.equalTo(CYTAutoLayoutV(34));
        make.right.equalTo(_companyNameTF);
    }];
    
    [_manageBrandGoNextBtn makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_manageBrandLabel);
        make.centerY.equalTo(_manageBrandTipLabel);
        make.size.equalTo(CGSizeMake(CYTAutoLayoutV(17), CYTAutoLayoutV(29)));
    }];
    
    [_manageBrandLineLabel remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(_upLineLabel);
        make.top.equalTo(_manageBrandTipLabel.mas_bottom).offset(CYTAutoLayoutV(32));
    }];
    
    [_manageBrandTapView remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_upLineLabel);
        make.top.equalTo(_manageTypeLineLabel.mas_bottom);
        make.bottom.equalTo(_manageBrandLineLabel.mas_top);
    }];
    
    [_companyCertificateAddAreaView remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_manageBrandLineLabel.mas_bottom).offset(CYTAutoLayoutV(58));
        make.left.equalTo(self).offset(CYTAutoLayoutH(56));
        make.right.equalTo(self).offset(-CYTAutoLayoutH(56));
        make.height.equalTo(CYTAutoLayoutV(160));
    }];
    
    [_businessLicense remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(_companyCertificateAddAreaView);
        make.size.equalTo(CGSizeMake(CYTAutoLayoutH(300), CYTAutoLayoutV(160)));
    }];
    
    [_addBusinessLicenseBtn remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_businessLicense).offset(CYTAutoLayoutV(20));
        make.centerX.equalTo(_businessLicense);
        make.size.equalTo(CGSizeMake(CYTAutoLayoutV(66), CYTAutoLayoutV(66)));
    }];
    
    [_businessLicenseLabel remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_addBusinessLicenseBtn.mas_bottom).offset(CYTAutoLayoutV(18));
        make.centerX.equalTo(_businessLicense);
        make.height.equalTo(_businessLicenseLabel.font.pointSize);
    }];
    
    [_showroomPhoto remakeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(_companyCertificateAddAreaView);
        make.size.equalTo(CGSizeMake(CYTAutoLayoutH(296), CYTAutoLayoutV(156)));
    }];
    
    [_showroomPhotoBtn remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_showroomPhoto).offset(CYTAutoLayoutV(20));
        make.centerX.equalTo(_showroomPhoto);
        make.size.equalTo(CGSizeMake(CYTAutoLayoutV(66), CYTAutoLayoutV(66)));
    }];
    
    [_showroomLabel remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_showroomPhotoBtn.mas_bottom).offset(CYTAutoLayoutV(18));
        make.centerX.equalTo(_showroomPhoto);
        make.height.equalTo(_showroomLabel.font.pointSize);
    }];
    
    [_commitBtn remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(CYTMarginH);
        make.right.equalTo(self).offset(-CYTMarginH);
        make.top.equalTo(_companyCertificateAddAreaView.mas_bottom).offset(CYTAutoLayoutV(58));
        make.height.equalTo(CYTAutoLayoutV(92));
    }];
    
}

/**
 *  初始化子控件
 */
- (void)initCompanyCertificateViewComponents{
    CYTWeakSelf
    //顶部分割条
    UIView *topBar = [[UIView alloc] init];
    topBar.backgroundColor = kFFColor_bg_nor;
    [self addSubview:topBar];
    _topBar = topBar;

    //顶部提示信息
    UILabel *upTipLabel = [[UILabel alloc] init];
    upTipLabel.textAlignment = NSTextAlignmentCenter;
    upTipLabel.font = CYTFontWithPixel(24);
    upTipLabel.text = @"企业认证完成后将可以使用所有功能";
    upTipLabel.numberOfLines = 0;
    upTipLabel.textColor = [UIColor colorWithHexColor:@"#666666"];
    [self addSubview:upTipLabel];
    _upTipLabel = upTipLabel;
    
    //上分割线
    UILabel *upLineLabel = [[UILabel alloc] init];
    upLineLabel.backgroundColor = [UIColor colorWithHexColor:@"#efefef"];
    [self addSubview:upLineLabel];
    _upLineLabel = upLineLabel;

    //公司名称
    UILabel *companyNameLabel = [UILabel labelWithText:@"公司名称" textColor:CYTHexColor(@"#333333") textAlignment:NSTextAlignmentLeft fontPixel:30.f setContentPriority:YES];
    [self addSubview:companyNameLabel];
    _companyNameLabel = companyNameLabel;

    //公司名称
    UITextField *companyNameTF = [[UITextField alloc] init];
    companyNameTF.placeholder = @"请输入公司名称";
    [companyNameTF setValue:CYTHexColor(@"#999999") forKeyPath:@"_placeholderLabel.textColor"];
    companyNameTF.keyboardType = UIKeyboardTypeDefault;
//    companyNameTF.secureTextEntry = YES;
    //    codeTF.tintColor = CYTGrayColor(51);
    companyNameTF.textColor = [UIColor colorWithHexColor:@"#999999"];
    companyNameTF.font = CYTFontWithPixel(30);
    [self addSubview:companyNameTF];
    _companyNameTF = companyNameTF;

    
    //公司名称分割线
    UILabel *companyLineLabel = [[UILabel alloc] init];
    companyLineLabel.backgroundColor = [UIColor colorWithHexColor:@"#efefef"];
    [self addSubview:companyLineLabel];
    _companyLineLabel = companyLineLabel;
    
    //所在地区父视图
    UIView *areraView = [[UIView alloc] init];
    areraView.backgroundColor = [UIColor clearColor];
    [self addSubview:areraView];
    _areraView  = areraView;
    
    //所在地区的回调
    [areraView addTapGestureRecognizerWithTap:^(UITapGestureRecognizer *tap) {
        !weakSelf.registerAddressBack?:weakSelf.registerAddressBack();
    }];
    
    //所在地区
    UILabel *areraTipLabel = [UILabel labelWithText:@"所在地区" textColor:CYTHexColor(@"#333333") textAlignment:NSTextAlignmentLeft fontPixel:30.f setContentPriority:YES];
    [areraView addSubview:areraTipLabel];
    _areraTipLabel = areraTipLabel;
    
    UILabel *areraLabel = [UILabel labelWithTextColor:CYTHexColor(@"#999999") textAlignment:NSTextAlignmentLeft fontPixel:30.f setContentPriority:NO];
    areraLabel.text = @"请输入所在地区";
    [areraView addSubview:areraLabel];
    _areraLabel = areraLabel;
    
    UILabel *areraLineLabel = [[UILabel alloc] init];
    areraLineLabel.backgroundColor = [UIColor colorWithHexColor:@"#efefef"];
    [areraView addSubview:areraLineLabel];
    _areraLineLabel = areraLineLabel;
    
    //箭头
    UIImageView *areraArrow = [UIImageView imageViewWithImageName:@"go_next"];
    [areraView addSubview:areraArrow];
    _areraArrow = areraArrow;
    

    //详细地址
    UILabel *registerAddressTipLabel = [UILabel labelWithText:@"详细地址" textColor:CYTHexColor(@"#333333") textAlignment:NSTextAlignmentLeft fontPixel:30.f setContentPriority:YES];
    [self addSubview:registerAddressTipLabel];
    _registerAddressTipLabel = registerAddressTipLabel;

    //注册地址输入框
    UITextField *registerAddressTF = [UITextField textFieldWithTextColor:CYTHexColor(@"#999999") fontPixel:30.f textAlignment:NSTextAlignmentLeft keyboardType:UIKeyboardTypeDefault clearButtonMode:UITextFieldViewModeNever placeholder:@"请输入您的详细地址"];
    [registerAddressTF setValue:CYTHexColor(@"#999999") forKeyPath:@"_placeholderLabel.textColor"];
    [self addSubview:registerAddressTF];
    _registerAddressTF = registerAddressTF;


//    //注册地址前往按钮
//    UIButton *registerAddressGoNextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [registerAddressGoNextBtn setBackgroundImage:[UIImage imageNamed:@"go_next"] forState:UIControlStateNormal];
//    [self addSubview:registerAddressGoNextBtn];
//    _registerAddressGoNextBtn = registerAddressGoNextBtn;

    
//    [[registerAddressGoNextBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
//        !self.registerAddressBack?:self.registerAddressBack();
//    }];
    
    //注册地址分割线
    UILabel *registerAddressLineLabel = [[UILabel alloc] init];
    registerAddressLineLabel.backgroundColor = [UIColor colorWithHexColor:@"#efefef"];
    [self addSubview:registerAddressLineLabel];
    _registerAddressLineLabel = registerAddressLineLabel;

    
    //注册地址添加手势
//    UIView *registerATapView = [[UIView alloc] init];
//    registerATapView.backgroundColor = [UIColor clearColor];
//    [self addSubview:registerATapView];
//    _registerATapView = registerATapView;
//
//    UITapGestureRecognizer *registerATap = [[UITapGestureRecognizer alloc] init];
//    [[registerATap rac_gestureSignal] subscribeNext:^(id x) {
//        !self.registerAddressBack?:self.registerAddressBack();
//    }];
//    [registerATapView addGestureRecognizer:registerATap];
    
    
    //经营类型
    UILabel *manageTypeTipLabel = [UILabel labelWithText:@"公司类型" textColor:CYTHexColor(@"#333333") textAlignment:NSTextAlignmentLeft fontPixel:30.f setContentPriority:YES];
    [self addSubview:manageTypeTipLabel];
    _manageTypeTipLabel = manageTypeTipLabel;

    //经营类型
    UILabel *manageTypeLabel = [[UILabel alloc] init];
    manageTypeLabel.userInteractionEnabled = YES;
    manageTypeLabel.text = @"请选择您的经营类型";
    manageTypeLabel.textColor = [UIColor colorWithHexColor:@"#999999"];
    manageTypeLabel.font = CYTFontWithPixel(30);
    [self addSubview:manageTypeLabel];
    _manageTypeLabel = manageTypeLabel;

    
    //经营类型前往按钮
    UIButton *manageTypeGoNextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [manageTypeGoNextBtn setBackgroundImage:[UIImage imageNamed:@"go_next"] forState:UIControlStateNormal];
    [self addSubview:manageTypeGoNextBtn];
    _manageTypeGoNextBtn = manageTypeGoNextBtn;
    
    [[manageTypeGoNextBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        !self.manageType?:self.manageType();
    }];
    
    //经营类型分割线
    UILabel *manageTypeLineLabel = [[UILabel alloc] init];
    manageTypeLineLabel.backgroundColor = [UIColor colorWithHexColor:@"#efefef"];
    [self addSubview:manageTypeLineLabel];
    _manageTypeLineLabel = manageTypeLineLabel;

    
    //经营类型添加手势
    UIView *manageTypeTapView = [[UIView alloc] init];
    manageTypeTapView.backgroundColor = [UIColor clearColor];
    [self addSubview:manageTypeTapView];
    _manageTypeTapView = manageTypeTapView;
    
    UITapGestureRecognizer *manageTypeTap = [[UITapGestureRecognizer alloc] init];
    [[manageTypeTap rac_gestureSignal] subscribeNext:^(id x) {
        !self.manageType?:self.manageType();
    }];
    [manageTypeTapView addGestureRecognizer:manageTypeTap];

    
    //主营品牌
    UILabel *manageBrandTipLabel = [UILabel labelWithText:@"主营品牌" textColor:CYTHexColor(@"#333333") textAlignment:NSTextAlignmentLeft fontPixel:30.f setContentPriority:YES];
    manageBrandTipLabel.userInteractionEnabled = YES;
    [self addSubview:manageBrandTipLabel];
    _manageBrandTipLabel = manageBrandTipLabel;

    //主营品牌输入框
    UILabel *manageBrandLabel = [[UILabel alloc] init];
    manageTypeLabel.userInteractionEnabled = YES;
    manageBrandLabel.text = @"请选择您的主营品牌，最多可选择8个";
    manageBrandLabel.textColor = [UIColor colorWithHexColor:@"#999999"];
    manageBrandLabel.font = CYTFontWithPixel(30);
    [self addSubview:manageBrandLabel];
    _manageBrandLabel = manageBrandLabel;

    
    //主营品牌前往按钮
    UIButton *manageBrandGoNextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [manageBrandGoNextBtn setBackgroundImage:[UIImage imageNamed:@"go_next"] forState:UIControlStateNormal];
    [self addSubview:manageBrandGoNextBtn];
    _manageBrandGoNextBtn = manageBrandGoNextBtn;
    
    [[manageBrandGoNextBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        !self.manageBrand?:self.manageBrand();
    }];
    
    //主营品牌分割线
    UILabel *manageBrandLineLabel = [[UILabel alloc] init];
    manageBrandLineLabel.backgroundColor = [UIColor colorWithHexColor:@"#efefef"];
    [self addSubview:manageBrandLineLabel];
    _manageBrandLineLabel = manageBrandLineLabel;
    
    //主营品牌添加手势
    UIView *manageBrandTapView = [[UIView alloc] init];
    manageBrandTapView.backgroundColor = [UIColor clearColor];
    [self addSubview:manageBrandTapView];
    _manageBrandTapView = manageBrandTapView;

    
    UITapGestureRecognizer *manageBrandTap = [[UITapGestureRecognizer alloc] init];
    [[manageBrandTap rac_gestureSignal] subscribeNext:^(id x) {
        !self.manageBrand?:self.manageBrand();
    }];
    [manageBrandTapView addGestureRecognizer:manageBrandTap];
    
    //营业执照添加区域
    UIView *companyCertificateAddAreaView = [[UIView alloc] init];
    //    identityCardAddAreaView.backgroundColor = [UIColor orangeColor];
    [self addSubview:companyCertificateAddAreaView];
    _companyCertificateAddAreaView = companyCertificateAddAreaView;

    //营业执照添加区域
    CYTCertificationImageView *businessLicense = [[CYTCertificationImageView alloc] init];
    businessLicense.idType = CYTIdTypeBusLen;
    businessLicense.userInteractionEnabled = YES;
    businessLicense.contentMode = UIViewContentModeScaleAspectFill;
    //    idFrontAddArea.backgroundColor = [UIColor orangeColor];
    businessLicense.layer.borderWidth = 1.5f;
    businessLicense.layer.borderColor = [UIColor colorWithHexColor:@"#999999"].CGColor;
    businessLicense.layer.cornerRadius = 6;
    businessLicense.layer.masksToBounds = YES;
    [companyCertificateAddAreaView addSubview:businessLicense];
    _businessLicense = businessLicense;

    //添加点击事件
    UITapGestureRecognizer *sbusinessLicenseTap = [[UITapGestureRecognizer alloc] init];
    [[sbusinessLicenseTap rac_gestureSignal] subscribeNext:^(id x) {
        !self.addBusinessLicenseBack?:self.addBusinessLicenseBack();
    }];
    [businessLicense addGestureRecognizer:sbusinessLicenseTap];
    //点击回调
    businessLicense.addBusinessLicenseBack = ^{
        !self.addBusinessLicenseBack?:self.addBusinessLicenseBack();
    };
    
    //添加按钮
    UIButton *addBusinessLicenseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBusinessLicenseBtn setBackgroundImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    addBusinessLicenseBtn.adjustsImageWhenHighlighted = NO;
    [businessLicense addSubview:addBusinessLicenseBtn];
    _addBusinessLicenseBtn = addBusinessLicenseBtn;
    
    [[addBusinessLicenseBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        !self.addBusinessLicenseBack?:self.addBusinessLicenseBack();
    }];
    //营业执照
    UILabel *businessLicenseLabel = [[UILabel alloc] init];
    businessLicenseLabel.textColor = [UIColor colorWithHexColor:@"#999999"];
    businessLicenseLabel.textAlignment = NSTextAlignmentCenter;
    businessLicenseLabel.font = CYTFontWithPixel(22);
    businessLicenseLabel.text = @"营业执照";
    [businessLicense addSubview:businessLicenseLabel];
    _businessLicenseLabel = businessLicenseLabel;
    
    //展厅照片
    CYTCertificationImageView *showroomPhoto = [[CYTCertificationImageView alloc] init];
    showroomPhoto.idType = CYTIdTypeShrom;
    showroomPhoto.userInteractionEnabled = YES;
    showroomPhoto.contentMode = UIViewContentModeScaleAspectFill;
    showroomPhoto.layer.borderWidth = 1.5f;
    showroomPhoto.layer.borderColor = [UIColor colorWithHexColor:@"#999999"].CGColor;
    showroomPhoto.layer.cornerRadius = 6;
    showroomPhoto.layer.masksToBounds = YES;
    [companyCertificateAddAreaView addSubview:showroomPhoto];
    _showroomPhoto = showroomPhoto;
    
    //添加点击事件
    UITapGestureRecognizer *showroomPhotoTap = [[UITapGestureRecognizer alloc] init];
    [[showroomPhotoTap rac_gestureSignal] subscribeNext:^(id x) {
        !self.addShrowroomBack?:self.addShrowroomBack();
    }];
    [showroomPhoto addGestureRecognizer:showroomPhotoTap];
    
    //点击回调
    showroomPhoto.addShrowroomBack = ^{
        !self.addShrowroomBack?:self.addShrowroomBack();
    };

    //展厅照片添加按钮
    UIButton *showroomPhotoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [showroomPhotoBtn setBackgroundImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    showroomPhotoBtn.adjustsImageWhenHighlighted = NO;
    [showroomPhoto addSubview:showroomPhotoBtn];
    _showroomPhotoBtn = showroomPhotoBtn;
    
    [[showroomPhotoBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        !self.addShrowroomBack?:self.addShrowroomBack();
    }];
    //展厅照片
    UILabel *showroomLabel = [[UILabel alloc] init];
    showroomLabel.textColor = [UIColor colorWithHexColor:@"#999999"];
    showroomLabel.textAlignment = NSTextAlignmentCenter;
    showroomLabel.font = CYTFontWithPixel(22);
    showroomLabel.text = @"展厅照片";
    [showroomPhoto addSubview:showroomLabel];
    _showroomLabel = showroomLabel;
    
    //提交审核按钮
    UIButton *commitBtn = [UIButton buttonWithTitle:@"提交审核" enabled:NO];
    [self addSubview:commitBtn];
    _commitBtn = commitBtn;
    
    [[commitBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        commitBtn.enabled = NO;
        [[self.companyCertificateViewModel.netStepCommand execute:nil] subscribeNext:^(CYTNetworkResponse *networkResponse) {
            commitBtn.enabled = YES;
            if (networkResponse.resultEffective) {
                //认证提交通过
                [[NSNotificationCenter defaultCenter] postNotificationName:kCommitCertificationSuccessKey object:nil];
                ///请求经销商信息
                [[CYTAuthManager manager] getUserDealerInfoFromLocal:NO result:^(CYTUserInfoModel *model) {}];
                !self.companyCertificateNextStep?:self.companyCertificateNextStep(networkResponse.resultMessage);
            }else{
                [CYTToast errorToastWithMessage:networkResponse.resultMessage];
            }
        }];
        
    }];

}

- (void)setShowKeyboard:(BOOL)showKeyboard{
    _showKeyboard = showKeyboard;
    if (showKeyboard) {
        [self.companyNameTF becomeFirstResponder];
    }
    
}

- (void)setCompanyCertificateModel:(CYTCompanyCertificateModel *)companyCertificateModel{
    _companyCertificateModel = companyCertificateModel;
    //上传图片
    [self uploadwithImage:companyCertificateModel.selectedImage type:companyCertificateModel.certificateType];
}
/**
 *  图片上传
 */
- (void)uploadwithImage:(UIImage *)image type:(CYTCompanyCertificateType)certificateType{
    CYTWeakSelf
//    UIImage *resultImage = [CYTImageCompresser compressImage:image];
    UIImage *resultImage = [image compressedToSize:kImageCompressedMaxSize];
    [CYTLoadingView showLoadingWithType:CYTLoadingViewTypeEditNavBar];
    [CYTSignalImageUploadTool uploadWithImage:resultImage parameters:nil url:kURL.user_file_userUpLoadImg success:^(CYTUploadImageResult *result) {
        if (!result.result) return;
        CYTAppManager *appManager = [CYTAppManager sharedAppManager];
        CYTImageFileModel *fileUrl = [CYTImageFileModel mj_objectWithKeyValues:result.data];
        if (certificateType == CYTCompanyCertificateTypeBusLen) {
            if (fileUrl.fileName.length) {
                //隐藏按钮
                [_businessLicense.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    obj.hidden = YES;
                }];
                appManager.BusinessLlicenseOriginalPic = fileUrl.fileName;
                _businessLicense.image = image;
                //添加图片
                [_businessLicense addWatermarkWithImageName:@"img_watermark_130x90_logo"];
                [weakSelf.certificatePhotos replaceObjectAtIndex:(CYTIdTypeBusLen-3) withObject:[NSNumber numberWithUnsignedInteger:(CYTIdTypeBusLen-3)]];
            }
            
        }else{
            if (fileUrl.fileName.length) {
                [_showroomPhoto.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    obj.hidden = YES;
                }];
                appManager.ExhibitOriginalPic = fileUrl.fileName;
                _showroomPhoto.image = image;
                //添加图片
                [_showroomPhoto addWatermarkWithImageName:@"img_watermark_130x90_logo"];
                [weakSelf.certificatePhotos replaceObjectAtIndex:(CYTIdTypeShrom-3) withObject:[NSNumber numberWithUnsignedInteger:(CYTIdTypeShrom-3)]];
            }
            
        }
        weakSelf.companyCertificateViewModel.certificatePhotos = weakSelf.certificatePhotos;
        
    } fail:nil];
}

- (void)setManageBrands:(NSMutableArray *)manageBrands{
    _manageBrands = manageBrands;
    NSMutableArray *tempBrandNameArray = [NSMutableArray array];
    NSMutableArray *tempBrandIdArray = [NSMutableArray array];
    for (CYTManageBrandModel *item in manageBrands) {
        [tempBrandNameArray addObject:item.brandName];
        [tempBrandIdArray addObject:item.brandId];
    }
    NSString *manageBrandString = [tempBrandNameArray componentsJoinedByString:@","];
    NSString *manageBrandId =     [tempBrandIdArray componentsJoinedByString:@","];
    if (manageBrandString.length) {
        _manageBrandLabel.text = [manageBrandString stringByReplacingOccurrencesOfString:@"," withString:@"、"];
        CYTAppManager *appManager = [CYTAppManager sharedAppManager];
        appManager.manageBrand = manageBrandString;
        appManager.manageBrandId = manageBrandId;
    }
   
}

/**
 *  绑定viewModel
 */
- (void)bindCompanyCertificateeViewModel{
    RAC(self.companyCertificateViewModel,companyName) = _companyNameTF.rac_textSignal;
    RAC(self.companyCertificateViewModel,registerAddress) = _registerAddressTF.rac_textSignal;
}
/**
 *  处理输入框和下一步按钮
 */
- (void)handelTextFieldAndcommitBtn{
    //公司名称的输入位数
    [_companyNameTF.rac_textSignal subscribeNext:^(NSString *inputString) {
        if (inputString.length > CYTCompanyNameLengthMax) {
            _companyNameTF.text = [inputString substringToIndex:CYTCompanyNameLengthMax];
        }
    }];
    
    [_registerAddressTF.rac_textSignal subscribeNext:^(NSString *inputString) {
        if (inputString.length > CYTCompanyNameLengthMax) {
            _registerAddressTF.text = [inputString substringToIndex:CYTCompanyNameLengthMax];
        }
    }];
    
    //登录按钮是否可点击
    RAC(_commitBtn,enabled) = self.companyCertificateViewModel.netStepEnableSiganl;
}

- (void)setManageTypeModel:(CYTManageTypeModel *)manageTypeModel{
    _manageTypeModel = manageTypeModel;
    _manageTypeLabel.text = manageTypeModel.levelName;
}

/**
 * 个人认证传入 模型数据
 */

- (void)setUserAuthenticateInfoModel:(CYTUserInfoModel *)userAuthenticateInfoModel{
    _userAuthenticateInfoModel = userAuthenticateInfoModel;
    CYTAppManager *appManager = [CYTAppManager sharedAppManager];
    _companyNameTF.text = userAuthenticateInfoModel.companyName;
    self.companyCertificateViewModel.companyName = userAuthenticateInfoModel.companyName;
    NSString *provinceN = userAuthenticateInfoModel.provinceName.length?userAuthenticateInfoModel.provinceName:@"";
    NSString *cityN = userAuthenticateInfoModel.cityName.length?userAuthenticateInfoModel.cityName:@"";
    NSString *yName = userAuthenticateInfoModel.countryName.length?userAuthenticateInfoModel.countryName:@"";
    _areraLabel.text = [NSString stringWithFormat:@"%@ %@ %@",provinceN,cityN,yName];
//    _registerAddressLabel.text = [NSString stringWithFormat:@"%@ %@ %@",userAuthenticateInfoModel.ProvinceName,userAuthenticateInfoModel.CityName,userAuthenticateInfoModel.RegisterAddress];
//    _areraTipLabel.text = 
    appManager.detailAddress = userAuthenticateInfoModel.registerAddress;
    NSString *registerAddress = userAuthenticateInfoModel.registerAddress.length?userAuthenticateInfoModel.registerAddress:@"";
    _registerAddressTF.text = registerAddress;
    self.companyCertificateViewModel.registerAddress = registerAddress;
    _manageTypeLabel.text = userAuthenticateInfoModel.companyType;
    appManager.LevelName = userAuthenticateInfoModel.companyTypeId;
    _manageBrandLabel.text = userAuthenticateInfoModel.carBrandStr;
    appManager.manageBrand = userAuthenticateInfoModel.carBrandStr;
    CYTSetSDWebImageHeader;
    [_businessLicense sd_setImageWithURL:[NSURL URLWithString:userAuthenticateInfoModel.businessLicenseOriginalPic]];
    [_showroomPhoto sd_setImageWithURL:[NSURL URLWithString:userAuthenticateInfoModel.exhibitOriginalPic]];
    
    if (userAuthenticateInfoModel.businessLicenseOriginalPic.length){
        [_businessLicense.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.hidden = YES;
        }];
        [self.certificatePhotos replaceObjectAtIndex:(CYTIdTypeBusLen-3) withObject:[NSNumber numberWithUnsignedInteger:(CYTIdTypeBusLen-3)]];
    }
    if (userAuthenticateInfoModel.exhibitOriginalPic.length){
        [_showroomPhoto.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.hidden = YES;
        }];
        [self.certificatePhotos replaceObjectAtIndex:(CYTIdTypeShrom-3) withObject:[NSNumber numberWithUnsignedInteger:(CYTIdTypeShrom-3)]];
    }
    
    self.companyCertificateViewModel.certificatePhotos = self.certificatePhotos;
    
}
/**
 *  驳回原因显示
 */
- (void)setRefuseReason:(NSMutableAttributedString *)refuseReason{
    _refuseReason = refuseReason;
    if (!refuseReason||!refuseReason.length) {
       _upTipLabel.text = @"企业认证完成后将可以使用所有功能";
        return;
    }
    //设置驳回原因
    _upTipLabel.textColor = [UIColor redColor];
    _upTipLabel.font = CYTFontWithPixel(30);
    _upTipLabel.attributedText = refuseReason;

    //测试
//    NSArray *stringArray = @[@"1234567",@"1234567",@"1234567",@"1234567"];
//    NSMutableAttributedString *mString = [[NSMutableAttributedString alloc] initWithString:[stringArray componentsJoinedByString:@"\n"]];
//    CGFloat lineSpace = CYTAutoLayoutV(10);
//    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//    [paragraphStyle setLineSpacing:lineSpace];
//    [mString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, mString.length)];
//    _upTipLabel.attributedText = mString;
    [self makeConstrains];

}


@end
