//
//  CYTBasicViewController.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/1.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTBasicViewController.h"
#import "CYTNoNetworkView.h"
#import "CYTNoDataView.h"

#define kNavTitleFont      CYTFontWithPixel(34.f)
#define kNavItmeTitleFont  CYTFontWithPixel(28.f)

@interface CYTBasicViewController()
/** 导航栏图片 */
@property(strong, nonatomic) UIImageView *navTitleView;
/** 导航栏分割线 */
@property(strong, nonatomic) UILabel *dividerLine;
/** 无网络界面 */
@property(strong, nonatomic) CYTNoNetworkView *noNetworkView;
/** 无数据界面 */
@property(strong, nonatomic) CYTNoDataView *noDataView;
/** 返回按钮 */
@property(strong, nonatomic) UIButton *backButton;


@end

@implementation CYTBasicViewController

- (instancetype)init {
    return [self initWithViewModel:nil];
}

///增加初始化方法，传递基础参数
- (instancetype)initWithViewModel:(id)viewModel {
    if (self = [super init]) {
        
    }
    return self;
}

/**
 *  状态栏
 */
- (UIImageView *)statusBar{
    if (!_statusBar) {
        _statusBar = [[UIImageView alloc] init];
        _statusBar.userInteractionEnabled = YES;
        _statusBar.backgroundColor = kTranslucenceColor;
        _statusBar.frame = CGRectMake(0, 0, kScreenWidth, CYTStatusBarHeight);
    }
    return _statusBar;
}
/**
 *  导航栏
 */
- (UIImageView *)navigationBar{
    if (!_navigationBar) {
        _navigationBar = [[UIImageView alloc] init];
        _navigationBar.userInteractionEnabled = YES;
        _navigationBar.backgroundColor = kTranslucenceColor;
        _navigationBar.frame = CGRectMake(0, CGRectGetMaxY(self.statusBar.frame), kScreenWidth, CYTNavigationBarHeight);
    }
    return _navigationBar;
}
/**
 *  导航区域
 */
- (UIImageView *)navigationZone{
    if (!_navigationZone) {
        UIImageView *navigationZone = [[UIImageView alloc] init];
        navigationZone.userInteractionEnabled = YES;
        navigationZone.frame = CGRectMake(0, 0, kScreenWidth, 64);
        [self.view addSubview:navigationZone];
        _navigationZone = navigationZone;
    }
    return _navigationZone;
}
/**
 *  导航栏标题
 */
- (UILabel *)navTitleLabel{
    if (!_navTitleLabel) {
        _navTitleLabel = [[UILabel alloc] init];
        _navTitleLabel.userInteractionEnabled = YES;
        _navTitleLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
        _navTitleLabel.textAlignment = NSTextAlignmentCenter;
        _navTitleLabel.backgroundColor = [UIColor clearColor];
        _navTitleLabel.font = kNavTitleFont;
        _navTitleLabel.textColor = [UIColor blackColor];
        _navTitleLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
        CGFloat navTitleLabelX = kScreenWidth/3;
        CGFloat navTitleLabelY = 0;
        CGFloat navTitleLabelW = kScreenWidth/3;
        CGFloat navTitleLabelH = CYTNavigationBarHeight;
        _navTitleLabel.frame = CGRectMake(navTitleLabelX , navTitleLabelY, navTitleLabelW, navTitleLabelH);
        UITapGestureRecognizer *titleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleButtonClick:)];
        [_navTitleLabel addGestureRecognizer:titleTap];
    }
    return _navTitleLabel;
}
/**
 *  导航栏分割线
 */
- (UILabel *)dividerLine{
    if (!_dividerLine) {
        _dividerLine = [[UILabel alloc] init];
        _dividerLine.backgroundColor = CYTNavBarLineColor;
        CGFloat dividerLineW = kScreenWidth;
        CGFloat dividerLineH = CYTNavBarLineHeight;
        CGFloat dividerLineX = 0;
        CGFloat dividerLineY = CYTNavigationBarHeight-dividerLineH;
        _dividerLine.frame = CGRectMake(dividerLineX , dividerLineY, dividerLineW, dividerLineH);
    }
    return _dividerLine;
}
/**
 *  返回按钮
 */
- (UIButton *)backButton{
    if (!_backButton) {
        _backButton = [UIButton buttonWithNormalImage:[UIImage imageNamed:@"nav_back"] highlightImage:[UIImage imageNamed:@"nav_back"]];
        [_backButton setTitleColorWithNormalColor:CYTRGBColor(1, 1, 1) highlightColor:CYTRGBColor(251, 32, 36)];
        CGFloat backButtonW = 17;
        CGFloat backButtonH = 29;
        CGFloat backButtonX = CYTAutoLayoutH(20);
        CGFloat backButtonY = (CYTNavigationBarHeight - backButtonH)*0.5;
        _backButton.frame = CGRectMake(backButtonX , backButtonY, backButtonW, backButtonH);
        _backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    return _backButton;
}
/**
 *  导航栏右按钮
 */
- (UIButton *)rightItemButton{
    if (!_rightItemButton) {
        _rightItemButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightItemButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_rightItemButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _rightItemButton.titleLabel.font = kNavItmeTitleFont;
    }
    return _rightItemButton;
}
/**
 *  无网络显示视图
 */
- (CYTNoNetworkView *)noNetworkView{
    if (!_noNetworkView) {
        CYTWeakSelf
        _noNetworkView = [[CYTNoNetworkView alloc] init];
        _noNetworkView.reloadData = ^{
            [weakSelf reloadData];
        };
    }
    return _noNetworkView;
}
/**
 *  无网络显示视图
 */
- (CYTNoDataView *)noDataView{
    if (!_noDataView) {
        _noDataView = [[CYTNoDataView alloc] init];
    }
    return _noDataView;
}
/**
 *  导航栏右按钮
 */


- (void)viewDidLoad {
    [super viewDidLoad];
    [self baseBasicConfig];
    [self baseInitComponents];
    [self baseDefaultSetting];
}
/**
 *  手势返回的控制
 */
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]){
        self.navigationController.interactivePopGestureRecognizer.enabled = self.interactivePopGestureEnable;
    }
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]){
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
     self.navigationController.navigationBar.hidden = NO;
    
    //退出键盘
    [self.view endEditing:YES];
}

/**
 *  基本配置
 */
- (void)baseBasicConfig{
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
}
/**
 *  初始化子控件
 */
- (void)baseInitComponents{
    //默认开启手势返回操作
    self.interactivePopGestureEnable = YES;
    //导航区域
    [self.navigationZone setBackgroundColor:[UIColor clearColor]];
    //状态栏
    [self.navigationZone addSubview:self.statusBar];
    //导航栏
    [self.navigationZone addSubview:self.navigationBar];
    //导航栏分割线
    [self.navigationBar addSubview:self.dividerLine];
    
    
}
/**
 *  控件默认设置
 */
- (void)baseDefaultSetting{
    [self statusBarDefaultSetting];
    [self navigationBarDefaultSetting];
    [self navTitleDefaultSetting];
}

/**
 * statusBarColor的setter方法
 */
- (void)setStatusBarColor:(UIColor *)statusBarColor{
    _statusBarColor = statusBarColor;
    _statusBar.backgroundColor = statusBarColor;
}
/**
 * navigationBarColor的setter方法
 */
- (void)setNavigationBarColor:(UIColor *)navigationBarColor{
    _navigationBarColor = navigationBarColor;
    _navigationBar.backgroundColor = navigationBarColor;
}
/**
 * hiddenNavigationBarLine的setter方法
 */
- (void)setHiddenNavigationBarLine:(BOOL)hiddenNavigationBarLine{
    _dividerLine.hidden = hiddenNavigationBarLine;
}

/**
 *  状态栏默认设置
 */

- (void)navigationBarDefaultSetting{
    //    _navigationBar.image = [UIImage imageNamed:@"navigationbarBackgroundWhite"];
}

/**
 *  导航栏默认设置
 */

- (void)statusBarDefaultSetting{
    //    _statusBar.image = [UIImage imageNamed:@"navigationbarBackgroundWhite"];
}

/**
 *  导航栏标题默认设置
 */

- (void)navTitleDefaultSetting{
    [self settingNavTitleWithTitle:nil fontSize:17 textColor:[UIColor blackColor]];
}

- (void)settingNavTitleWithTitle:(NSString *)title fontSize:(CGFloat)fontSize textColor:(UIColor*)textColor{
    _navTitleLabel.text = title;
    _navTitleLabel.font = [UIFont boldSystemFontOfSize:fontSize];
    _navTitleLabel.textColor = textColor;
}
/**
 *  自定义标题导航栏
 *
 *  @param tittle           导航栏标题
 *  @param isShowBackButton 是否显示返回按钮
 *  @param rightButtonTitle 右按钮的标题（传空默认不显示）
 */
- (void)createNavBarWithTitle:(NSString *)tittle andShowBackButton:(BOOL)isShowBackButton showRightButtonWithTitle:(NSString *)rightButtonTitle{
    //导航栏标题
    if (tittle.length != 0) {
        self.navTitleLabel.text = tittle;
        [self.navigationBar addSubview:self.navTitleLabel];
    }
    if (isShowBackButton) {
        //返回按钮
        UIView *tapView = [[UIView alloc] init];
        tapView.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        tapView.frame = CGRectMake(0, 0, CYTNavigationBarHeight, CYTNavigationBarHeight);
        [tap addTarget:self action:@selector(backButtonClick:)];
        [tapView addGestureRecognizer:tap];
        [self.navigationBar addSubview:self.backButton];
        [self.navigationBar addSubview:tapView];
    }else{
        self.backButton.hidden = YES;
    }
    
    if (rightButtonTitle.length != 0) {
        //右按钮
        [self.navigationBar addSubview:self.rightItemButton];
        CGFloat rightButtonH = CYTNavigationBarHeight;
        CGFloat rightButtonW = [rightButtonTitle sizeWithFont:self.rightItemButton.titleLabel.font maxSize:CGSizeMake(CGFLOAT_MAX, rightButtonH)].width;
        CGFloat rightButtonX = kScreenWidth-CYTNavBarItemMarigin-rightButtonW;
        CGFloat rightButtonY = 0;
        self.rightItemButton.frame = CGRectMake(rightButtonX, rightButtonY,rightButtonW, rightButtonH);
        [self.rightItemButton setTitle:rightButtonTitle forState:UIControlStateNormal];
        
        UIView *tapView = [[UIView alloc] init];
        tapView.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        tapView.frame = CGRectMake(0, 0, rightButtonW+15.f, CYTNavigationBarHeight);
        tapView.center = self.rightItemButton.center;
        [tap addTarget:self action:@selector(rightButtonClick:)];
        [tapView addGestureRecognizer:tap];
        [self.navigationBar addSubview:tapView];
    }
}

/**
 *  创建隐藏左、右按钮的标题导航栏
 *
 *  @param tittle 导航栏标题
 */
- (void)createNavBarWithTitle:(NSString *)tittle{
    [self createNavBarWithTitle:tittle andShowBackButton:NO showRightButtonWithTitle:nil];
}

/**
 *  创建隐藏右按钮的标题导航栏
 *
 *  @param tittle 导航栏标题
 */
- (void)createNavBarWithBackButtonAndTitle:(NSString *)tittle{
    [self createNavBarWithTitle:tittle andShowBackButton:YES showRightButtonWithTitle:nil];
}
/**
 *  创建图片导航栏
 *
 *  @param tittleImage      导航栏图片
 *  @param isShowBackButton 是否显示返回按钮
 *  @param rightButtonTitle 右按钮标题（传空默认不显示）
 */
- (void)createNavBarWithTitleView:(UIImage *)tittleImage  andShowBackButton:(BOOL)isShowBackButton showRightButtonWithTitle:(NSString *)rightButtonTitle{
    [self createNavBarWithTitle:nil andShowBackButton:isShowBackButton showRightButtonWithTitle:rightButtonTitle];
    if (!tittleImage)return;
    UIImageView *titleView = [[UIImageView alloc] init];
    titleView.userInteractionEnabled = YES;
    titleView.image = [tittleImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITapGestureRecognizer *titleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleButtonClick:)];
    [titleView addGestureRecognizer:titleTap];
    [_navigationBar addSubview:titleView];
}

/**
 *  创建隐藏左、右按钮的图片导航栏
 *
 *  @param tittleImage 标题图片
 */
- (void)createNavBarWithTitleView:(UIImage *)tittleImage{
    [self createNavBarWithTitleView:tittleImage andShowBackButton:NO showRightButtonWithTitle:nil];
}
/**
 *  创建隐藏右按钮的图片导航栏
 *
 *  @param tittle 导航栏标题
 */
- (void)createNavBarWithBackButtonAndTitleView:(UIImage *)tittleImage{
    [self createNavBarWithTitleView:tittleImage andShowBackButton:YES showRightButtonWithTitle:nil];
}
/**
 *  创建自定义按钮的导航栏
 *
 *  @param leftButtons  左按钮
 *  @param titleButton 标题按钮
 *  @param rightButtons 右按钮
 */
- (void)createNavBarWithLeftButton:(UIButton *)leftButton titleView:(UIView *)titleView andRightButton:(UIButton *)rightButton{
    if (leftButton) {
        CGFloat leftButtonW = 0;
        CGFloat leftButtonH = 0;
        //左按钮frame
        if (leftButton.currentBackgroundImage) {
            leftButtonW = leftButton.currentBackgroundImage.size.width;
            leftButtonH = leftButton.currentBackgroundImage.size.height;
        }else{
            leftButtonW = leftButton.width;
            leftButtonH = leftButton.height;
        }
        CGFloat leftButtonX = CYTNavBarItemMarigin;
        CGFloat leftButtonY = (kScreenWidth - leftButtonH)*0.5;
        leftButton.frame = CGRectMake(leftButtonX , leftButtonY, leftButtonW, leftButtonH);
        [_navigationBar addSubview:leftButton];
        [leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    if (titleView) {
        //添加手势
        UITapGestureRecognizer *titleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleButtonClick:)];
        //标题按钮frame
        CGFloat titleButtonW = 0.f;
        CGFloat titleButtonH = 0.f;
        if ([titleView isKindOfClass:[UIButton class]]) {
            UIButton *titleButton = (UIButton *)titleView;
            titleButtonW = titleButton.currentBackgroundImage.size.width;
            titleButtonH = titleButton.currentBackgroundImage.size.height;
            [titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        }else if ([titleView isKindOfClass:[UILabel class]]){
            UILabel *titleButton = (UILabel *)titleView;
            titleButton.font = CYTNavTitleFont;
            titleButton.textColor = CYTRGBColor(1, 1, 1);
            titleButton.userInteractionEnabled = YES;
            titleButtonW = [titleButton.text sizeWithFont:titleButton.font maxSize:CGSizeMake(CGFLOAT_MAX, titleButtonH)].width;
            titleButtonH = titleButton.font.pointSize;
            [titleButton addGestureRecognizer:titleTap];
        }else if ([titleView isKindOfClass:[UIImageView class]]){
            UIImageView *titleButton = (UIImageView *)titleView;
            titleButton.userInteractionEnabled = YES;
            titleButtonW = titleButton.image.size.width;
            titleButtonH = titleButton.image.size.height;
            [titleButton addGestureRecognizer:titleTap];
        }
        
        CGFloat titleButtonX = (_navigationBar.width-titleButtonW)*0.5;
        CGFloat titleButtonY = (_navigationBar.height-titleButtonH)*0.5;
        titleView.frame = CGRectMake(titleButtonX , titleButtonY, titleButtonW, titleButtonH);
        [_navigationBar addSubview:titleView];
        
    }
    
    if (rightButton) {
        //右按钮frame
        CGFloat rightButtonW = 0.f;
        CGFloat rightButtonH = 0.f;
        if (rightButton.currentBackgroundImage) {
            rightButtonW = rightButton.currentBackgroundImage.size.width;
            rightButtonH = rightButton.currentBackgroundImage.size.height;
        }else{
            rightButtonW = rightButton.width;
            rightButtonH = rightButton.height;
        }
        
        CGFloat rightButtonX = kScreenWidth-rightButtonW-CYTNavigationBarHeight;
        CGFloat rightButtonY = (CYTNavigationBarHeight - rightButtonH)*0.5;
        rightButton.frame = CGRectMake(rightButtonX , rightButtonY, rightButtonW, rightButtonH);
        [_navigationBar addSubview:rightButton];
        [rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}

/**
 *  导航栏的显示与隐藏
 */
- (void)showOrHiddenNavigationBarWithAnimation:(BOOL)animation{
    CYTWeakSelf
    if (weakSelf.isHiddenNavigationBar) {//隐藏了
        [self showNavigationBarWithAnimation:animation];
    }else{
        [self hideNavigationBarWithAnimation:animation];
    }
}
/**
 *  显示导航栏的
 */
- (void)showNavigationBarWithAnimation:(BOOL)animation{
    CYTWeakSelf
    CGRect originF = weakSelf.navigationZone.frame;
    weakSelf.hiddeNnavigationBar = NO;
    originF.origin.y+=64;
    CGRect currentF = originF;
    if (animation) {
        [UIView animateWithDuration:0.35f animations:^{
            weakSelf.navigationZone.frame = currentF;
            [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
        }];
    }else{
        weakSelf.navigationZone.frame = currentF;
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    }
}
/**
 *  隐藏导航栏
 */
- (void)hideNavigationBarWithAnimation:(BOOL)animation{
    CYTWeakSelf
    CGRect originF = weakSelf.navigationZone.frame;
    weakSelf.hiddeNnavigationBar = YES;
    originF.origin.y-=64;
    CGRect currentF = originF;
    if (animation) {
        [UIView animateWithDuration:0.35f animations:^{
            weakSelf.navigationZone.frame = currentF;
            [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
        }];
    }else{
        weakSelf.navigationZone.frame = currentF;
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    }
}

/**
 *  返回按钮的点击
 */
- (void)backButtonClick:(UIButton *)backButton{
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 *  左边按钮的点击
 */
- (void)leftButtonClick:(UIButton *)rightButton{}

/**
 *  标题按钮的点击
 */
- (void)titleButtonClick:(UIButton *)rightButton{}

/**
 *  右边按钮的点击
 */
- (void)rightButtonClick:(UIButton *)rightButton{}
/**
 *  取消网络请求任务
 */
- (void)cancelRequest{
    [self.sessionDateTask cancel];
}
/**
 *  控制器销毁，取消所有请求
 */
- (void)dealloc{
    [self cancelRequest];
    //移除消息观察
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSString *className = [NSString stringWithUTF8String:object_getClassName(self)];
    CYTLog(@"%@已执行,%@",NSStringFromSelector(_cmd),className);
}
/**
 *  显示无网络界面
 */
- (void)showNoNetworkView{
    dispatch_async(dispatch_get_main_queue(), ^{
        UITableView *tableView = nil;
        for (UIView *itemView in self.view.subviews) {
            if ([itemView isKindOfClass:[UITableView class]]) {
                tableView = (UITableView *)itemView;
            }
        }
        if (tableView) {
            self.noNetworkView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-CYTViewOriginY);
            [tableView addSubview:self.noNetworkView];
        }else{
            self.noNetworkView.frame = CGRectMake(0, CYTViewOriginY, kScreenWidth, kScreenHeight-CYTViewOriginY);
            [self.view addSubview:self.noNetworkView];
        }
        
    });

}
/**
 *  显示无网络界面到指定界面
 */
- (void)showNoNetworkViewInView:(UIView *)view{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.noNetworkView.frame = CGRectMake(0, CYTViewOriginY, kScreenWidth, kScreenHeight-CYTViewOriginY);
        [view addSubview:self.noNetworkView];
    });
    
}
/**
 *  移除无网络界面
 */
- (void)dismissNoNetworkView{
    if (self.noNetworkView) {
        [self.noNetworkView removeFromSuperview];
        self.noNetworkView = nil;
    }

    
}
/**
 *  重新加载
 */
- (void)reloadData{}
/**
 *  显示无数据界面
 */
- (void)showNoDataView{
    dispatch_async(dispatch_get_main_queue(), ^{
        UITableView *tableView = nil;
        for (UIView *itemView in self.view.subviews) {
            if ([itemView isKindOfClass:[UITableView class]]) {
                tableView = (UITableView *)itemView;
            }
        }
        if (tableView) {
            CGRect noDataViewF = tableView.bounds;
            noDataViewF.size.height = kScreenHeight-CYTViewOriginY;
            self.noDataView.frame = noDataViewF;
            [tableView addSubview:self.noDataView];
        }else{
            self.noDataView.frame = CGRectMake(0, CYTViewOriginY, kScreenWidth, kScreenHeight-CYTViewOriginY);
            [self.view addSubview:self.noDataView];
        }
        
    });
}
/**
 *  移除无数据界面
 */
- (void)dismissNoDataView{
    if (self.noDataView) {
        [self.noDataView removeFromSuperview];
        self.noDataView = nil;
    }
    
    
}

@end
