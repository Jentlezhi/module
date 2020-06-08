//
//  FFDZNSupernatant.m
//  CYTEasyPass
//
//  Created by xujunquan on 2017/11/17.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFDZNSupernatant.h"

@implementation FFDZNSupernatant

#pragma mark- flow control
- (void)ff_initWithViewModel:(id)viewModel {
    [super ff_initWithViewModel:viewModel];
}

- (void)ff_bindViewModel {
    [super ff_bindViewModel];
    
    @weakify(self);
    [self.dznCustomViewModel.requestAgainSubject subscribeNext:^(id x) {
        @strongify(self);
        !self.requestAgainBlock?:self.requestAgainBlock();
    }];
}

- (void)ff_addSubViewAndConstraints {
    [super ff_addSubViewAndConstraints];
    
    self.backgroundColor = [UIColor whiteColor];
    self.bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.dznCustomView];
    [self.dznCustomView makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(0);
        make.top.greaterThanOrEqualTo(0);
        make.left.greaterThanOrEqualTo(0);
        make.right.lessThanOrEqualTo(0);
        make.bottom.lessThanOrEqualTo(0);
    }];
}

#pragma mark- api

#pragma mark- method

#pragma mark- set
- (void)setDznType:(DZNViewType)dznType {
    self.dznCustomView.type = dznType;
}

#pragma mark- get
- (FFDZNCustomView *)dznCustomView {
    if (!_dznCustomView) {
        _dznCustomView = [[FFDZNCustomView alloc] initWithViewModel:self.dznCustomViewModel];
        _dznCustomView.type = DZNViewTypeEmpty;
    }
    return _dznCustomView;
}

- (FFDZNCustomViewModel *)dznCustomViewModel {
    if (!_dznCustomViewModel) {
        _dznCustomViewModel = [[FFDZNCustomViewModel alloc] init];
    }
    return _dznCustomViewModel;
}

@end
