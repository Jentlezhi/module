//
//  CYTContactMeViewController.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/10/16.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTContactMeViewController.h"
#import "CYTContactMeTagView.h"
#import "ContactMeConfig.h"
#import "CYTContactMeSubViewController.h"


@interface CYTContactMeViewController ()<UIScrollViewDelegate>

/** 索引 */
@property(strong, nonatomic) CYTContactMeTagView *contactMeTagView;
/** 内容视图 */
@property(strong, nonatomic) UIScrollView *contentScrollview;
/** 内容视图子视图 */
@property(strong, nonatomic) NSMutableArray *contentSubViews;
/** 车源视图 */
@property(strong, nonatomic) UIView *carSourceView;
/** 寻车视图 */
@property(strong, nonatomic) UIView *seekCarView;

@end

@implementation CYTContactMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self contactMeBasicConfig];
    [self initContactMeComponents];
}
/**
 *  基本配置
 */
- (void)contactMeBasicConfig{
    [self createNavBarWithBackButtonAndTitle:@"联系我的"];
}
/**
 *  初始化子控件
 */
- (void)initContactMeComponents{
    [self.view addSubview:self.contactMeTagView];
    [self.view addSubview:self.contentScrollview];
    [self scrollViewDidEndDecelerating:self.contentScrollview];
}

#pragma mark - 懒加载
- (CYTContactMeTagView *)contactMeTagView{
    if (!_contactMeTagView) {
        _contactMeTagView = [[CYTContactMeTagView alloc] init];
        _contactMeTagView.frame = CGRectMake(0, CYTViewOriginY, kScreenWidth, CYTAutoLayoutV(kContactMeTagViewHeight));
        @weakify(self);
        _contactMeTagView.indicatorClicked = ^(NSInteger index) {
            @strongify(self);
            [self addSubviewWithIndex:index];
            self.contentScrollview.contentOffset = CGPointMake(index * kScreenWidth, 0);
        };
    }
    return  _contactMeTagView;
}
- (UIScrollView *)contentScrollview{
    if (!_contentScrollview) {
        _contentScrollview = [[UIScrollView alloc] init];
        CGFloat contentScrollviewY = CYTAutoLayoutV(kContactMeTagViewHeight) + CYTViewOriginY;
        _contentScrollview.frame = CGRectMake(0, contentScrollviewY, kScreenWidth, kScreenHeight - contentScrollviewY);
        _contentScrollview.pagingEnabled = YES;
        _contentScrollview.delegate = self;
        _contentScrollview.backgroundColor = [UIColor clearColor];
        _contentScrollview.showsHorizontalScrollIndicator = NO;
        _contentScrollview.contentSize = CGSizeMake(kScreenWidth*2, 0);
    }
    return _contentScrollview;
}

- (UIView *)carSourceView{
    if (!_carSourceView) {
        CYTContactMeSubViewController *carSourceVC = [CYTContactMeSubViewController subViewControllerWithType:CYTContactMeSubViewTypeCarSource];
        [self addChildViewController:carSourceVC];
        _carSourceView = carSourceVC.view;
    }
    return _carSourceView;
}
- (UIView *)seekCarView{
    if (!_seekCarView) {
        CYTContactMeSubViewController *seekCarVC = [CYTContactMeSubViewController subViewControllerWithType:CYTContactMeSubViewTypeSeekCar];
        [self addChildViewController:seekCarVC];
        _seekCarView = seekCarVC.view;
    }
    return _seekCarView;
}
- (NSMutableArray *)contentSubViews{
    if (!_contentSubViews) {
        _contentSubViews = [NSMutableArray array];
        [_contentSubViews addObject:self.carSourceView];
        [_contentSubViews addObject:self.seekCarView];
    }
    return _contentSubViews;
}
#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x/scrollView.frame.size.width;
    self.contactMeTagView.currentIndex = index;
    [self addSubviewWithIndex:index];
}
- (void)addSubviewWithIndex:(NSInteger)index{
    UIView *subView = self.contentSubViews[index];
    CGFloat subViewX = index*kScreenWidth;
    CGFloat subViewY = 0;
    CGFloat subViewW = kScreenWidth;
    CGFloat subViewH = self.contentScrollview.frame.size.height;
    subView.frame = CGRectMake(subViewX, subViewY, subViewW, subViewH);
    [self.contentScrollview addSubview:subView];
}
/**
 *  切换标签位置
 */
- (void)setTagIndex:(NSInteger)tagIndex{
    _tagIndex = tagIndex;
    if (tagIndex<0) return;
    self.contentScrollview.contentOffset = CGPointMake(kScreenWidth *tagIndex, 0);
    [self scrollViewDidEndDecelerating:self.contentScrollview];
}


@end
