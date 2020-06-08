//
//  FFBasicViewController.m
//  FFBasicProject
//
//  Created by xujunquan on 2017/5/7.
//  Copyright © 2017年 ian. All rights reserved.
//

#import "FFBasicViewController.h"

@interface FFBasicViewController ()
@property (nonatomic, strong) id priViewModel;

@end

@implementation FFBasicViewController

- (instancetype)init {
    if (self = [super init]) {
        [self ff_initWithViewModel:_priViewModel];
    }
    return self;
}

- (instancetype)initWithViewModel:(FFExtendViewModel *)viewModel {
    _priViewModel = viewModel;
    return [self init];
}

- (void)ff_initWithViewModel:(id)viewModel {
    self.interactivePopGestureEnable = YES;
    _showNavigationView = YES;
}

- (void)ff_bindViewModel {
    
}

- (void)ff_addSubViewAndConstraints {
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    if (self.showNavigationView) {
        [self.view addSubview:self.ffNavigationView];
    }
    [self.view insertSubview:self.ffContentView atIndex:0];
    
    if (self.showNavigationView) {
        [self.ffNavigationView makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.view);
            make.height.equalTo(kFFNavigationBarHeight+kFFStatusBarHeight);
        }];
    }
    [self.ffContentView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        if (@available(iOS 11.0, *)) {
            make.bottom.equalTo(self.view.safeAreaLayoutGuideBottom);
        }else {
            make.bottom.equalTo(self.view);
        }
        if (self.showNavigationView) {
            make.top.equalTo(self.ffNavigationView.bottom);
        }else {
            make.top.equalTo(0);
        }
    }];
}

#pragma mark-
- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self ff_bindViewModel];
    [self ff_addSubViewAndConstraints];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    ///开启手势返回
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    //退出键盘
    [self.view endEditing:YES];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //设置当前页面右滑返回手势是否有效
    self.navigationController.interactivePopGestureRecognizer.enabled = self.interactivePopGestureEnable;
    //设置状态栏样式
    self.statusBarStyle = UIStatusBarStyleDefault;
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
}

- (void)dealloc {
    NSString *className = [NSString stringWithUTF8String:object_getClassName(self)];
    kFFLog_Debug(@"%@已执行----------->>>>,%@",NSStringFromSelector(_cmd),className);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark- 导航点击方法
- (void)ff_leftClicked:(FFNavigationItemView *)backView {
    if (self.navigationController.viewControllers.count>1) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)ff_titleClicked:(FFNavigationItemView *)titleView {
    
}

- (void)ff_rightClicked:(FFNavigationItemView *)rightView {
    
}

#pragma mark- 处理空数据和加载失败情况
- (void)showResultViewWithType:(DZNViewType)type andInsets:(UIEdgeInsets)insets{
    self.ffDZNControl.dznType = type;
    [self.ffDZNControl ff_showSupernatantView];
}

- (void)hideResultView {
    [self.ffDZNControl ff_hideSupernatantView];
}

#pragma mark- set
- (void)setStatusBarStyle:(UIStatusBarStyle)statusBarStyle {
    _statusBarStyle = statusBarStyle;
    [[UIApplication sharedApplication] setStatusBarStyle:statusBarStyle animated:NO];
}

- (void)setFfTitle:(NSString *)ffTitle {
    _ffTitle = ffTitle;
    self.ffNavigationView.contentView.titleView.title = ffTitle;
}

- (void)setShowNavigationView:(BOOL)showNavigationView {
    _showNavigationView = showNavigationView;
    
    float height = (showNavigationView)?kFFNavigationBarHeight+kFFStatusBarHeight:0;
    [self.ffNavigationView updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(height);
    }];
    
    [UIView animateWithDuration:kFFAnimationDuration animations:^{
        [self.view layoutIfNeeded];
        self.ffNavigationView.contentView.alpha = (showNavigationView)?1:0;
    }];
    
    //当导航不显示时候，设置line不显示
    if (!showNavigationView) {
        self.showNavigationBottomLine = showNavigationView;
    }
}

- (void)setShowNavigationBottomLine:(BOOL)showNavigationBottomLine {
    _showNavigationBottomLine = showNavigationBottomLine;
    self.ffNavigationView.bottomLineView.hidden = !showNavigationBottomLine;
}

#pragma mark- get
- (FFNavigationView *)ffNavigationView {
    if (!_ffNavigationView) {
        _ffNavigationView = [FFNavigationView new];
        @weakify(self);
        [_ffNavigationView setLeftClickBlock:^(FFNavigationItemView *leftView) {
            @strongify(self);
            [self ff_leftClicked:leftView];
        }];
        [_ffNavigationView setTitleClickBlock:^(FFNavigationItemView *titleView) {
            @strongify(self);
            [self ff_titleClicked:titleView];
        }];
        [_ffNavigationView setRightClickBlock:^(FFNavigationItemView *rightView) {
            @strongify(self);
            [self ff_rightClicked:rightView];
        }];
    }
    return _ffNavigationView;
}

- (FFExtendView *)ffContentView {
    if (!_ffContentView) {
        _ffContentView = [FFExtendView new];
#ifdef DEBUG
#ifdef kFFDebug
        [_ffContentView radius:8 borderWidth:0.5 borderColor:kFFDebugViewColor];
#endif
#endif
    }
    return _ffContentView;
}

- (FFDZNSupernatant *)ffDZNControl {
    if (!_ffDZNControl) {
        FFBasicSupernatantViewModel *vm = [FFBasicSupernatantViewModel new];
        vm.sourceView = self.view;
        _ffDZNControl = [[FFDZNSupernatant alloc] initWithViewModel:vm];
    }
    return _ffDZNControl;
}

@end
