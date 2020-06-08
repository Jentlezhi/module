//
//  CYTEditCarContactsViewController.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/5/16.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTEditCarContactsViewController.h"
#import "CYTCarContactsModel.h"
#import "CYTIDCardTextField.h"
#import "CYTEditCarContactsParemeters.h"

#define kSelectImageName        @"selected"
#define kUnSelectImageName      @"unselected"

@interface CYTEditCarContactsViewController ()

/** 滚动视图 */
@property(strong, nonatomic) UITableView *mainView;

/** 身份证选择 */
@property(strong, nonatomic) UIImageView *IDCardIcon;
/** 护照选择 */
@property(strong, nonatomic) UIImageView *passportIcon;
/** 联系人 */
@property(strong, nonatomic) UITextField *contacterTF;
/** 联系电话 */
@property(strong, nonatomic) UITextField *contactPhoneTF;
/** 证件号码 */
@property(strong, nonatomic) CYTIDCardTextField *cerNumTF;
/** 修改或新增参数 */
@property(strong, nonatomic) CYTEditCarContactsParemeters *editCarContactsParemeters;

/** 修改/保存类型 */
@property(assign, nonatomic) int type;

@end

@implementation CYTEditCarContactsViewController
{
    UIView *_holderView;
    //联系人
    UIView *_contacterView;
    //联系电话
    UIView *_contactPhoneView;
    //证件类型
    UIView *_cerTypeView;
    //证件号码
    UIView *_cerNumView;
    //身份证
    UIView *_IDCardView;
    //护照
    UIView *_passportView;
    //证件类型选择
    UIView *_cerTypeBar;
    
}

- (UITableView *)mainView{
    if (!_mainView) {
        _mainView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        if (@available(iOS 11.0, *)) {
            _mainView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _mainView.estimatedSectionFooterHeight = 0;
            _mainView.estimatedSectionHeaderHeight = 0;
        }
    }
    return _mainView;
}

+ (instancetype)editCarContactsWithType:(CYTEditCarContactsType)editCarContactsType {
    CYTEditCarContactsViewController *editCarContactsViewController = [[CYTEditCarContactsViewController alloc] init];
    editCarContactsViewController.carContactsType = editCarContactsType;
    return editCarContactsViewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self editCarContactsBasicConfig];
    [self configmainView];
    [self initEditCarContactsComponents];
    [self makeConstrains];
}
/**
 *  基本配置
 */
- (void)editCarContactsBasicConfig{
    NSString *navTitle = [NSString string];
    NSString *rightTitle = [NSString string];
    switch (self.carContactsType) {
        case CYTEditCarContactsTypeReceiverSave:
        {
            navTitle = @"收车人信息";
            rightTitle = @"保存";
        }
            break;
        case CYTEditCarContactsTypeReceiverEdit:
        {
            navTitle = @"收车人信息";
            rightTitle = @"修改";
//            [self.rightItemButton setTitleColor:CYTGreenNormalColor forState:UIControlStateNormal];
        }
            break;
        case CYTEditCarContactsTypeSenderSave:
        {
            navTitle = @"发车人信息";
            rightTitle = @"保存";
        }
            break;
        case CYTEditCarContactsTypeSenderEdit:
        {
            navTitle = @"发车人信息";
            rightTitle = @"修改";
//            [self.rightItemButton setTitleColor:CYTGreenNormalColor forState:UIControlStateNormal];
        }
            break;
        default:
            break;
    }
    
    [self createNavBarWithTitle:navTitle andShowBackButton:YES showRightButtonWithTitle:rightTitle];
   
    //修改请求参数
    //修改
    if (self.carContactsType == CYTEditCarContactsTypeReceiverSave|| self.carContactsType == CYTEditCarContactsTypeSenderSave) {
        self.editCarContactsParemeters = [[CYTEditCarContactsParemeters alloc] init];
    }
    
}

/**
 *  配置表格
 */
- (void)configmainView{
    self.mainView.backgroundColor = CYTLightGrayColor;
    self.mainView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:self.mainView];
    
}

/**
 *  初始化子控件
 */
- (void)initEditCarContactsComponents{
    //holderView
    UIView *holderView = [[UIView alloc] init];
    holderView.backgroundColor = [UIColor clearColor];
    holderView.frame = CGRectMake(0, 0, kScreenWidth, CYTAutoLayoutV(90.f*4+20.f*2));
    [self.mainView addSubview:holderView];
    _holderView = holderView;
    
    //联系人
    UIView *contacterView = [self infoBarWithTitle:@"联系人" inputTF:^(UIView *inputTF) {
        _contacterTF = (UITextField *)inputTF;
        _contacterTF.text = _carContactsModel.name;
        //限制输入框输入字数
        [_contacterTF.rac_textSignal subscribeNext:^(NSString *inputString) {
            if (inputString.length > CYTNameLengthMax) {
                _contacterTF.text = [inputString substringToIndex:CYTNameLengthMax];
            }
        }];
    } showLine:YES placeholder:@"请输入联系人姓名" showTF:YES keyboardType:UIKeyboardTypeDefault];
    [holderView addSubview:contacterView];
    _contacterView = contacterView;
    
    //联系电话
    UIView *contactPhoneView = [self infoBarWithTitle:@"联系电话" inputTF:^(UIView *inputTF) {
        _contactPhoneTF = (UITextField *)inputTF;
        _contactPhoneTF.text = _carContactsModel.phone;
        //限制输入框输入字数
        [_contactPhoneTF.rac_textSignal subscribeNext:^(NSString *inputString) {
            if (inputString.length > CYTAccountLengthMax) {
                _contactPhoneTF.text = [inputString substringToIndex:CYTAccountLengthMax];
            }
        }];
    } showLine:NO placeholder:@"请输入11位手机号" showTF:YES keyboardType:UIKeyboardTypeNumberPad];
    [holderView addSubview:contactPhoneView];
    _contactPhoneView = contactPhoneView;
    
    //证件类型
    UIView *cerTypeView = [self infoBarWithTitle:@"证件类型" inputTF:^(UIView *inputTF) {
        _cerTypeBar = inputTF;
        //设置选项卡
        
        
        NSString *IDCardSeletedImageName = [NSString string];
        NSString *passportSeletedImageName = [NSString string];
        if (self.carContactsType == CYTEditCarContactsTypeReceiverEdit ||self.carContactsType == CYTEditCarContactsTypeSenderEdit) {
            if (_carContactsModel.cerTypeId == 1) {
                IDCardSeletedImageName = kSelectImageName;
                passportSeletedImageName = kUnSelectImageName;
            }else{
                IDCardSeletedImageName = kUnSelectImageName;
                passportSeletedImageName = kSelectImageName;
            }
        }else{
            IDCardSeletedImageName = kUnSelectImageName;
            passportSeletedImageName = kUnSelectImageName;
        }
        
        //身份证
        UIView *IDCardView = [self itemWithIconImageName:IDCardSeletedImageName tile:@"身份证" clickBack:^(UIImageView *icon){
            icon.image = [UIImage imageNamed:kSelectImageName];
            self.passportIcon.image = [UIImage imageNamed:kUnSelectImageName];
            self.editCarContactsParemeters.certificateType = 1;
        } iconBack:^(UIImageView *icon) {
            self.IDCardIcon = icon;
        } titleLabelBack:nil];
        
        [inputTF addSubview:IDCardView];
        _IDCardView = IDCardView;
        
        //护照
        UIView *passportView = [self itemWithIconImageName:passportSeletedImageName tile:@"护照" clickBack:^(UIImageView *icon){
            icon.image = [UIImage imageNamed:kSelectImageName];
            self.IDCardIcon.image = [UIImage imageNamed:kUnSelectImageName];
            self.editCarContactsParemeters.certificateType = 2;
        } iconBack:^(UIImageView *icon) {
            self.passportIcon = icon;
        } titleLabelBack:nil];
        [inputTF addSubview:passportView];
        _passportView = passportView;
    } showLine:YES placeholder:nil showTF:NO keyboardType:UIKeyboardTypeDefault];
    
    
    
    [holderView addSubview:cerTypeView];
    _cerTypeView = cerTypeView;
    
    //证件号码
    UIView *cerNumView = [self infoBarWithTitle:@"证件号码" inputTF:^(UIView *inputTF) {
        _cerNumTF = (CYTIDCardTextField *)inputTF;
        _cerNumTF.text = _carContactsModel.cerNumberAll;
        //限制输入框输入字数
        [_cerNumTF.rac_textSignal subscribeNext:^(NSString *inputString) {
            if (inputString.length > CYTIdCardLengthMax) {
                _cerNumTF.text = [inputString substringToIndex:CYTIdCardLengthMax];
            }
        }];
    } showLine:NO placeholder:@"请输入证件号" showTF:YES keyboardType:UIKeyboardTypeDefault];
    [holderView addSubview:cerNumView];
    _cerNumView = cerNumView;
}
/**
 *  布局子控件
 */
- (void)makeConstrains{
    [_mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view).offset(CYTViewOriginY);
    }];
    [_contacterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.mainView).offset(CYTAutoLayoutV(20.f));
        make.height.equalTo(CYTAutoLayoutV(90));
    }];
    
    [_contactPhoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contacterView.mas_bottom);
        make.left.right.height.equalTo(_contacterView);
        
    }];
    
    [_cerTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contactPhoneView.mas_bottom).offset(CYTAutoLayoutV(20.f));
        make.left.right.height.equalTo(_contacterView);
    }];
    
    [_cerNumView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_cerTypeView.mas_bottom);
        make.left.right.height.equalTo(_contacterView);
    }];

    [_passportView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.right.equalTo(_cerTypeBar);
        make.width.equalTo(13*3+CYTAutoLayoutH(12)+CYTAutoLayoutV(30));
        make.height.equalTo(CYTAutoLayoutV(40));
    }];
    
    [_IDCardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_cerTypeBar);
        make.right.equalTo(_passportView.mas_left).offset(-CYTAutoLayoutH(40.f));
        make.width.height.equalTo(_passportView);
    }];
}
/**
 *  信息条
 */
- (UIView *)infoBarWithTitle:(NSString *)title inputTF:(void(^)(UIView *inputTF))content showLine:(BOOL)showLine placeholder:(NSString *)placeholder showTF:(BOOL)showTF keyboardType:(UIKeyboardType)keyboardType{
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
        make.left.equalTo(CYTAutoLayoutH(30.f));
        make.top.bottom.equalTo(infoView);
        make.width.equalTo((titleLabel.font.pointSize+2)*5);
    }];
    
    //内容
    if (showTF) {
        UITextField *inputTF = [[UITextField alloc] init];
        if ([title isEqualToString:@"证件号码"]) {
            inputTF = [[CYTIDCardTextField alloc] init];
        }
        inputTF.placeholder = placeholder;
        inputTF.textAlignment = NSTextAlignmentRight;
        inputTF.keyboardType = keyboardType;
        inputTF.font = CYTFontWithPixel(26.f);
        inputTF.textColor = [UIColor colorWithHexColor:@"#666666"];
        [infoView addSubview:inputTF];
        [inputTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(titleLabel.mas_right).offset(CYTAutoLayoutH(30));
            make.top.bottom.equalTo(infoView);
            make.right.equalTo(infoView).offset(-CYTAutoLayoutH(30));
        }];
        
        //回调
        !content?:content(inputTF);
    }else{
        UIView *bgView = [[UIView alloc] init];
        [infoView addSubview:bgView];
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(titleLabel.mas_right).offset(CYTAutoLayoutH(30));
            make.top.bottom.equalTo(infoView);
            make.right.equalTo(infoView).offset(-CYTAutoLayoutH(30));
        }];
        
        //回调
        !content?:content(bgView);
    }

    
    //下分割线
    UILabel *dividerLineLabel = [[UILabel alloc] init];
    dividerLineLabel.hidden = !showLine;
    dividerLineLabel.backgroundColor = [UIColor colorWithHexColor:@"#efefef"];
    [infoView addSubview:dividerLineLabel];
    [dividerLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(-CYTDividerLineWH);
        make.left.equalTo(infoView).offset(CYTAutoLayoutH(30.f));
        make.right.equalTo(infoView).offset(-CYTAutoLayoutH(30.f));
        make.height.equalTo(CYTDividerLineWH);
    }];
    
    return infoView;
}
/**
 *  证件类似选择
 */
- (UIView *)itemWithIconImageName:(NSString *)iconName tile:(NSString *)title clickBack:(void(^)(UIImageView *icon))clickBlock iconBack:(void(^)(UIImageView *icon))icon titleLabelBack:(void(^)(UILabel *titleLabel))titleLabelBlock{
    UIView *itemView = [[UIView alloc] init];
    itemView.backgroundColor = [UIColor clearColor];
    //标识
    UIImageView *selectIcon = [[UIImageView alloc] init];
    !icon?:icon(selectIcon);
    selectIcon.image = [UIImage imageNamed:iconName];
    [itemView addSubview:selectIcon];
    [selectIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.centerY.equalTo(itemView);
        make.width.height.equalTo(CYTAutoLayoutV(40));
    }];
    //文字
    UILabel *defaultLabel = [[UILabel alloc] init];
    !titleLabelBlock?:titleLabelBlock(defaultLabel);
    defaultLabel.text = title;
    defaultLabel.textAlignment = NSTextAlignmentLeft;
    defaultLabel.font = CYTFontWithPixel(24);
    defaultLabel.textColor = [UIColor colorWithHexColor:@"#333333"];
    [itemView addSubview:defaultLabel];
    CGFloat defaultLabelH = defaultLabel.font.pointSize+1;
    NSUInteger textLength = title.length == 0 ? 5:title.length;
    [defaultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(selectIcon);
        make.left.equalTo(selectIcon.mas_right).offset(CYTAutoLayoutH(12));
        make.size.equalTo(CGSizeMake(defaultLabelH*textLength, defaultLabelH));
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [[tap rac_gestureSignal] subscribeNext:^(id x) {
        CYTLog(@"&&&");
        !clickBlock?:clickBlock(selectIcon);
    }];
    [itemView addGestureRecognizer:tap];
    return itemView;
}

- (void)setCarContactsModel:(CYTCarContactsModel *)carContactsModel{
    _carContactsModel = carContactsModel;
    _contacterTF.text = carContactsModel.name;
    //修改或添加联系人 请求参数
    self.editCarContactsParemeters = [[CYTEditCarContactsParemeters alloc] init];
    self.editCarContactsParemeters.certificateType = _carContactsModel.cerTypeId;
    self.editCarContactsParemeters.isDefault = _carContactsModel.isDefault;
    self.editCarContactsParemeters.contactId = _carContactsModel.contactId.intValue;
}
/**
 * 修改/保存
 */
- (void)rightButtonClick:(UIButton *)rightButton{
    
    self.editCarContactsParemeters.phone = _contactPhoneTF.text;
    self.editCarContactsParemeters.certificateNumber = _cerNumTF.text;
    self.editCarContactsParemeters.name = _contacterTF.text;
    self.editCarContactsParemeters.contactType = self.type;
    [CYTLoadingView showLoadingWithType:CYTLoadingViewTypeNotEditable];
    [CYTNetworkManager POST:kURL.user_contacts_addOrUpdate parameters:self.editCarContactsParemeters.mj_keyValues dataTask:^(NSURLSessionDataTask *dataTask) {
        self.sessionDataTask = dataTask;
    } showErrorTost:YES completion:^(CYTNetworkResponse *responseObject) {
        [CYTLoadingView hideLoadingView];
        if (responseObject.resultEffective) {
            [self.navigationController popViewControllerAnimated:YES];
            !self.editSuccess?:self.editSuccess();
        }
    }];

}
/**
 * 处理请求参数
 */
- (void)setCarContactsType:(CYTEditCarContactsType)carContactsType{
    _carContactsType = carContactsType;
    if (carContactsType == CYTEditCarContactsTypeReceiverSave||carContactsType == CYTEditCarContactsTypeReceiverEdit) {
        self.type = 0;
    }else{
        self.type = 1;
    }
}

@end
