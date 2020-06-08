//
//  CYTCustomTabbarController.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/4/21.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCustomTabbarController.h"
#import "CYTPersonalHomeTableController.h"
#import "CYTPrestrainManager.h"
#import "CYTNavigationController.h"
#import "CYTHomeViewController.h"
#import "CYTCarSourceListViewController.h"
#import "CYTFindCarListViewController.h"
#import "CYTUpdateManager.h"
#import "AFNetworkReachabilityManager.h"
#import "CYTDiscoverTableController.h"
#import "CYTShakeViewController.h"

@interface CYTCustomTabbarController ()
@property (nonatomic, strong) CYTPrestrainManager *prestrainManager;

@end

@implementation CYTCustomTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self shakeSetting];
    //统一设置系统控件属性
    [self appearanceConfig];
    //创建tabbar
    [self createTabbarControllers];
    //检测更新
//    [CYTUpdateManager update];
    //app数据预加载
    [self.prestrainManager prestrainAppData];
    [self.prestrainManager updateTokenAndAuthInfo];
}


- (void)shakeSetting {
    if ([CYTURLManager shareManager].canChangeURLType) {
        // 设置允许摇一摇功能
        [UIApplication sharedApplication].applicationSupportsShakeToEdit = YES;
        // 并让自己成为第一响应者
        [self becomeFirstResponder];
    }
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (![CYTURLManager shareManager].canChangeURLType) {
        return;
    }
    
    if (event.subtype == UIEventSubtypeMotionShake) { // 判断是否是摇动结束
        if ([[FFCommonCode topViewController] isKindOfClass:[CYTShakeViewController class]]) {
            return;
        }
        
        CYTShakeViewController *shake = [CYTShakeViewController new];
        [[FFCommonCode topViewController].navigationController pushViewController:shake animated:YES];
    }
}

- (void)createTabbarControllers {
    NSArray *titleArray = @[@"首页",@"车源",@"寻车",@"发现",@"我"];
    NSArray *imageArray = @[@"btn_lab_1_",@"btn_lab_2_",@"btn_lab_3_",@"btn_lab_4_",@"btn_lab_5_"];
    
    [self createControllersWithTitleArray:titleArray];
    [self tabBarItemTitles:titleArray tabBarItemImages:imageArray];
}

//设置系统控件属性
- (void)appearanceConfig{
    // 通过appearance统一设置UITabBarItem的文字属性
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    attrs[NSForegroundColorAttributeName] = kFFColor_title_L3;
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    selectedAttrs[NSForegroundColorAttributeName] = kFFColor_green;
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

- (void)createControllersWithTitleArray:(NSArray *)titleArray{
    //首页
    CYTHomeViewController *homeCtr = [CYTHomeViewController new];
    CYTNavigationController *homeNav = [[CYTNavigationController alloc] initWithRootViewController:homeCtr];
    
    //车源
    CYTCarSourceListViewController *carSourceCtr = [CYTCarSourceListViewController new];
    CYTNavigationController * carSourceNav = [[CYTNavigationController alloc] initWithRootViewController:carSourceCtr];
    
    //寻车
    CYTFindCarListViewController *findCarCtr = [CYTFindCarListViewController new];
    CYTNavigationController *findCarNav = [[CYTNavigationController alloc] initWithRootViewController:findCarCtr];
    
    //发现
    CYTDiscoverTableController *discoverController = [CYTDiscoverTableController new];
    discoverController.ffTitle = titleArray[3];
    CYTNavigationController *discoverNav = [[CYTNavigationController alloc] initWithRootViewController:discoverController];
    
    //我
    CYTPersonalHomeTableController *meCtr = [CYTPersonalHomeTableController new];
    meCtr.title = titleArray[4];
    CYTNavigationController *meNav = [[CYTNavigationController alloc] initWithRootViewController:meCtr];
    
    self.viewControllers = @[homeNav,carSourceNav,findCarNav,discoverNav,meNav];
}

- (void)tabBarItemTitles:(NSArray *)tabBarItemTitles tabBarItemImages:(NSArray *)tabBarItemImages{
    NSArray *items = [[self tabBar] items];
    for (int i=0; i<items.count; i++) {
        UITabBarItem *item = items[i];
        NSString *selectImageName = [NSString stringWithFormat:@"%@press",[tabBarItemImages objectAtIndex:i]];
        UIImage *selectImage = [[UIImage imageNamed:selectImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        NSString *imageName = [NSString stringWithFormat:@"%@nor",[tabBarItemImages objectAtIndex:i]];
        UIImage *image = [UIImage imageNamed:imageName];
        NSString *title = tabBarItemTitles[i];
        
        item.title = title;
        item.image = image;
        item.selectedImage = selectImage;
    }
}

#pragma mark- get

- (CYTPrestrainManager *)prestrainManager {
    if (!_prestrainManager) {
        _prestrainManager = [CYTPrestrainManager new];
    }
    return _prestrainManager;
}

@end
