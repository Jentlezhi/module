//
//  CYTUnenableSearchViewWithBorder.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/5/25.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTUnenableSearchViewWithBorder.h"

@implementation CYTUnenableSearchViewWithBorder

- (void)ff_addSubViewAndConstraints {
    self.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.searchView];
    [self.searchView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTMarginH);
        make.right.equalTo((-CYTMarginH));
        make.centerY.equalTo(self);
        make.height.equalTo(self.searchView.viewHeight);
    }];
}

#pragma mark- get
- (CYTUnenableSearchView *)searchView {
    if (!_searchView) {
        _searchView = [CYTUnenableSearchView new];
        @weakify(self);
        [_searchView setSearchBlock:^{
            @strongify(self);
            if (self.searchBlock) {
                self.searchBlock();
            }
        }];
    }
    return _searchView;
}

@end
