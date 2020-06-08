//
//  CYTStoreCertificationViewController.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/11/21.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTStoreCertificationViewController.h"
#import "CYTCoinCardView.h"

static const NSString *unsel = @"pic_shi_sel";
static const NSString *sel = @"pic_shi_unsel";

@interface CYTStoreCertificationViewController ()
/** 背景 */
@property(strong, nonatomic) UITableView *basicBgView;
/** 背景 */
@property(strong, nonatomic) UIView *bgView;
/** 内容背景 */
@property(strong, nonatomic) UIImageView *contentbasicBgView;
/** 申请按钮 */
@property(strong, nonatomic) UIButton *applyBtn;
@end

@implementation CYTStoreCertificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self storeCertificationBasicConfig];
    [self initStoreCertificationComponents];
    [self makeSubConstrains];
    [self getstoreauthapplystatus];
}
/**
 *  基本配置
 */
- (void)storeCertificationBasicConfig{
    [self createNavBarWithBackButtonAndTitle:@"实体店认证申请"];
    self.view.backgroundColor = CYTLightGrayColor;
}
/**
 *  初始化子控件
 */
- (void)initStoreCertificationComponents{
    [self.view addSubview:self.basicbasicBgView];
    [self.basicBgView addSubview:self.bgView];
    [self.bgView addSubview:self.contentbasicBgView];
    [self.bgView addSubview:self.applyBtn];
}
- (void)makeSubConstrains{
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(CYTItemMarginV);
        make.centerX.equalTo(self.basicBgView);
        make.size.equalTo(CGSizeMake(CYTAutoLayoutV(710.f), CYTAutoLayoutV(970.f)));
    }];
    [self.contentbasicBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.centerX.equalTo(self.bgView);
        make.size.equalTo(CGSizeMake(CYTAutoLayoutV(710.f), CYTAutoLayoutV(780.f)));
    }];
    [self.applyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentbasicBgView.mas_bottom).offset(CYTAutoLayoutV(43.f));
        make.centerX.equalTo(self.bgView);
        make.size.equalTo(CGSizeMake(CYTAutoLayoutV(520.f), CYTAutoLayoutV(89.f)));
    }];

}
#pragma mark - 懒加载
- (UIScrollView *)basicbasicBgView{
    if(!_basicBgView){
        CGRect frame = CGRectMake(0, CYTViewOriginY, kScreenWidth, kScreenHeight-CYTViewOriginY);
        _basicBgView = [[UITableView alloc] initWithFrame:frame];
        _basicBgView.tableFooterView = UIView.new;
        _basicBgView.backgroundColor = [UIColor clearColor];
    }
    return _basicBgView;
}
- (UIImageView *)contentbasicBgView{
    if(!_contentbasicBgView){
        _contentbasicBgView = [UIImageView imageViewWithImageName:unsel];
    }
    return _contentbasicBgView;
}

- (UIView *)bgView{
    if(!_bgView){
        _bgView = UIView.new;
        _bgView.layer.cornerRadius = 4.f;
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.masksToBounds = YES;
    }
    return _bgView;
}
- (UIButton *)applyBtn{
    if (!_applyBtn) {
        _applyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _applyBtn.enabled = NO;
        [_applyBtn setBackgroundImage:[UIImage imageNamed:@"btn_shenqing_dl"] forState:UIControlStateNormal];
        [_applyBtn setBackgroundImage:[UIImage imageNamed:@"btn_shenqing_unsel"] forState:UIControlStateDisabled];
        _applyBtn.titleLabel.font = CYTFontWithPixel(30.f);
        [_applyBtn setTitleColor:CYTHexColor(@"#FFFFFF") forState:UIControlStateNormal];
        [_applyBtn setTitle:@"申请认证" forState:UIControlStateNormal];
        [[_applyBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            [self poststoreauthapply];
        }];
    }
    return _applyBtn;
}

/**
 *  刷新
 */
- (void)reloadData{
  [self getstoreauthapplystatus];
}

/**
 *  获取认证申请状态
 */
- (void)getstoreauthapplystatus{
    [CYTLoadingView showLoadingWithType:CYTLoadingViewTypeEditNavBar];
    [CYTNetworkManager GET:kURL.user_authorization_getstoreauthapplystatus parameters:nil dataTask:^(NSURLSessionDataTask *dataTask) {
        self.sessionDataTask = dataTask;
    } showErrorTost:NO completion:^(CYTNetworkResponse *responseObject) {
        [CYTLoadingView hideLoadingView];
        if (!responseObject.resultEffective){
            [self showNoNetworkView];
            return;
        }
        [self dismissNoNetworkView];
        BOOL isApply = [responseObject.dataDictionary[@"isApply"] boolValue];
        if (!isApply) {
        [self.applyBtn setTitle:@"已申请" forState:UIControlStateDisabled];
        self.contentbasicBgView.image = [UIImage imageNamed:sel];
        }else{
            self.applyBtn.enabled = YES;
        }
    }];
}
/**
 *  提交申请
 */
- (void)poststoreauthapply{
    [CYTLoadingView showLoadingWithType:CYTLoadingViewTypeEditNavBar];
    [CYTNetworkManager POST:kURL.user_authorization_poststoreauthapply parameters:nil dataTask:^(NSURLSessionDataTask *dataTask) {
        self.sessionDataTask = dataTask;
    } showErrorTost:YES completion:^(CYTNetworkResponse *responseObject) {
        [CYTLoadingView hideLoadingView];
        if (!responseObject.resultEffective) return;
        [CYTCoinCardView showSuccessWithType:CYTCoinCardTypeTaskCompletion model:@"申请成功"];
        [self.applyBtn setTitle:@"已申请" forState:UIControlStateDisabled];
        self.applyBtn.enabled = NO;
        self.contentbasicBgView.image = [UIImage imageNamed:sel];
    }];
}


@end
