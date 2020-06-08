//
//  FFTabControl.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/7/31.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFTabControl.h"

@interface FFTabControl ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, assign) BOOL useCustomSegment;
@property (nonatomic, strong) UIView *segmentBgView;
@property (nonatomic, assign) BOOL firstLoad;
@end

@implementation FFTabControl
@synthesize segmentView = _segmentView;

- (void)ff_initWithViewModel:(id)viewModel {
    [super ff_initWithViewModel:viewModel];
    _segmentHeight = 40;
    _firstLoad = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.firstLoad) {
        self.firstLoad = NO;
        self.segmentView.index = self.defaultIndex;
    }
}

- (void)handleSegmentSelect {
    @weakify(self);
    [_segmentView setIndexChangeBlock:^(NSInteger index) {
        @strongify(self);
        //回调数据
        _currentIndex = index;
        [self indexChangeWithIndex:index];
        
        //获取scrollView偏移量，判断是否需要进行滚动。
        float offsetX = self.scrollView.contentOffset.x;
        NSInteger scrollIndex = (offsetX/kFF_SCREEN_WIDTH);
        if (index != scrollIndex) {
            //滚动
            CGPoint offset = CGPointMake(index*kFF_SCREEN_WIDTH, 0);
            //animate=NO，回调方法是 scrollViewDidEndScrollingAnimation，滚动停止不会回调 scrollViewDidEndDecelerating，非常重要
            [self.scrollView setContentOffset:offset animated:NO];
        }
    }];
}

- (void)indexChangeWithIndex:(NSInteger)index {
    kFFLog_Debug(@"index = %ld",index);
}

- (void)pushViewController:(id)controller withAnimate:(BOOL)animate {
    if (controller && [controller isKindOfClass:[UIViewController class]]) {
        [self.navigationController pushViewController:controller animated:animate];
    }else {
        kFFLog_Debug(@"push异常");
    }
}

#pragma mark- delegate
//手动拖拽，停止滚动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //获取index
    float offsetX = scrollView.contentOffset.x;
    NSInteger index = (offsetX/kFF_SCREEN_WIDTH);
    self.segmentView.index = index;
}

//非手动造成滚动，停止的回调
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    //无需操作
}

#pragma mark- add

- (void)handleSegmentTitles {
    if (self.useCustomSegment) {
        return;
    }
    NSMutableArray *titleArray = [NSMutableArray array];
    for (int i=0; i<self.tabControllersArray.count; i++) {
        UIViewController *controller = self.tabControllersArray[i];
        NSString *title = (controller.navigationItem.title.length>0)?(controller.navigationItem.title):@"item";
        [titleArray addObject:title];
    }
    self.segmentView.titlesArray = titleArray;
}

- (void)handleScrollViewContent {
    UIView *contentView = [UIView new];
    [self.scrollView addSubview:contentView];
    [contentView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        make.height.equalTo(self.scrollView);
    }];
    
    UIView *lastView;
    for (int i=0; i<self.tabControllersArray.count; i++) {
        UIViewController *controller = [self.tabControllersArray objectAtIndex:i];
        UIView *itemView = controller.view;
        [contentView addSubview:itemView];
        [itemView makeConstraints:^(MASConstraintMaker *make) {
            if (lastView) {
                make.left.equalTo(lastView.right);
            }else {
                make.left.equalTo(0);
            }
            make.top.bottom.equalTo(contentView);
            make.width.equalTo(self.scrollView);
        }];
        lastView = itemView;
    }
    
    if (lastView) {
        [lastView makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(0);
        }];
    }
    
}

#pragma mark- set
//根据数组内容初始化segment和scrollview
- (void)setTabControllersArray:(NSArray *)tabControllersArray {
    _tabControllersArray = tabControllersArray;
    
    if (_segmentView) {
        [_segmentView removeFromSuperview];
    }
    
    if (_scrollView) {
        [_scrollView removeFromSuperview];
    }
    
    if (_segmentBgView) {
        [_segmentBgView removeFromSuperview];
    }
    
    [self handleSegmentTitles];
    [self handleScrollViewContent];
    
    [self.ffContentView addSubview:self.segmentBgView];
    [self.ffContentView addSubview:self.segmentView];
    [self.ffContentView addSubview:self.scrollView];
    
    [self.segmentBgView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.ffContentView);
        make.top.equalTo(self.ffContentView).offset(self.segmentTopMargin);
        make.height.equalTo(self.segmentHeight);
    }];
    [self.segmentView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ffContentView).offset(self.segmentTopMargin);
        make.left.equalTo(self.segmentLeftRightOffset);
        make.right.equalTo(-self.segmentLeftRightOffset);
        make.height.equalTo(self.segmentHeight-self.segmentBottomMargin);
    }];
    [self.scrollView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.ffContentView);
        make.top.equalTo(self.segmentBgView.bottom);
    }];
}

- (void)setSegmentView:(FFBasicSegmentView *)segmentView {
    _segmentView = segmentView;
    self.useCustomSegment = YES;
    [self handleSegmentSelect];
}

#pragma mark- get
- (FFBasicSegmentView *)segmentView {
    if (!_segmentView) {
        _segmentView = [FFBasicSegmentView new];
        [self handleSegmentSelect];
    }
    return _segmentView;
}

- (UIView *)segmentBgView {
    if (!_segmentBgView) {
        _segmentBgView = [UIView new];
        _segmentBgView.backgroundColor = [UIColor whiteColor];
    }
    return _segmentBgView;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [UIScrollView new];
        _scrollView.scrollEnabled = YES;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}

@end
