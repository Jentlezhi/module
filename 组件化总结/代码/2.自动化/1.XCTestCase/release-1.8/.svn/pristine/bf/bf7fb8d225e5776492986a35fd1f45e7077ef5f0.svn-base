//
//  CGDZNCustomView.m
//  Pcms
//
//  Created by xujunquan on 16/10/20.
//  Copyright © 2016年 cig. All rights reserved.
//

#import "FFDZNCustomView.h"
#import "FFDZNCustomViewModel.h"

@interface FFDZNCustomView ()
@property (nonatomic, strong) FFDZNCustomViewModel *viewModel;

@end

@implementation FFDZNCustomView
@synthesize loadingView = _loadingView;
@synthesize emptyView = _emptyView;
@synthesize reloadView = _reloadView;

- (void)ff_addSubViewAndConstraints {
    self.backgroundColor = [UIColor clearColor];
}

- (void)ff_initWithViewModel:(id)viewModel {
    self.viewModel = viewModel;
}

- (void)setType:(DZNViewType)type {
    _type = type;
    
    [self.loadingView removeFromSuperview];
    [self.emptyView removeFromSuperview];
    [self.reloadView removeFromSuperview];
    
    if (type == DZNViewTypeEmpty) {
        [self addSubview:self.emptyView];
        [self.emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }else if (type == DZNViewTypeReload) {
        [self addSubview:self.reloadView];
        [self.reloadView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }else if (type == DZNViewTypeLoading) {
        [self addSubview:self.loadingView];
        [self.loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
}

#pragma mark- set/get
- (FFDZNLoadingView *)loadingView {
    if (!_loadingView) {
        _loadingView = [FFDZNLoadingView new];
        _loadingView.contentText = @"努力加载中..";
        _loadingView.contentImage = @"dzn_loading";
    }
    return _loadingView;
}

- (void)setLoadingView:(FFDZNLoadingView *)loadingView {
    [_loadingView removeFromSuperview];
    _loadingView = loadingView;
}

- (FFDZNEmptyView *)emptyView {
    if (!_emptyView) {
        _emptyView = [FFDZNEmptyView new];
        _emptyView.dznLabel.text = @"暂无数据";
        _emptyView.dznImageView.image = [UIImage imageNamed:@"dzn_empty_2"];
    }
    return _emptyView;
}

- (void)setEmptyView:(FFDZNEmptyView *)emptyView {
    //先将之前的删除，然后设置新的自定义view，必须这样做
    //原因分析：如果几次自定义的emptyView的类型不同（子类和父类也是不同的）则会add多次，所以先删除之前的，然后定义新的。
    [_emptyView removeFromSuperview];
    _emptyView = emptyView;
}

- (FFDZNReloadView *)reloadView {
    if (!_reloadView) {
        _reloadView = [FFDZNReloadView new];
        _reloadView.contentText = @"网络请求失败";
        _reloadView.contentSubText = @"请检查您的网络";
        _reloadView.contentImage = @"dzn_netError";
        
        @weakify(self);
        [_reloadView setButtonClickedBlock:^(UIButton *button) {
            @strongify(self);
            [self.viewModel.requestAgainSubject sendNext:button];
        }];
    }
    return _reloadView;
}

- (void)setReloadView:(FFDZNReloadView *)reloadView {
    [_reloadView removeFromSuperview];
    _reloadView = reloadView;
    
    @weakify(self);
    [_reloadView setButtonClickedBlock:^(UIButton *button) {
        @strongify(self);
        [self.viewModel.requestAgainSubject sendNext:button];
    }];
}

@end
