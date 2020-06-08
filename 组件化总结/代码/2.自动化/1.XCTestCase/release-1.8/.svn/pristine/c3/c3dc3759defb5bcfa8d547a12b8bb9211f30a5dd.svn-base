//
//  CYTCarSourceDetailCell_route_view.m
//  CYTEasyPass
//
//  Created by xujunquan on 2017/11/10.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCarSourceDetailCell_route_view.h"

@interface CYTCarSourceDetailCell_route_view ()
@property (nonatomic, strong) NSArray *routeArray;

@end

@implementation CYTCarSourceDetailCell_route_view

#pragma mark- flow control
- (void)ff_initWithViewModel:(id)viewModel {
    [super ff_initWithViewModel:viewModel];
}

- (void)ff_bindViewModel {
    [super ff_bindViewModel];
}

- (void)ff_addSubViewAndConstraints {
    [super ff_addSubViewAndConstraints];
    
    [self addSubview:self.scrollView];
    [self.scrollView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
        make.width.equalTo(self);
        make.height.equalTo(self);
    }];
    
    [self.scrollView addSubview:self.contentView];
    [self.contentView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        make.height.equalTo(self.scrollView);
    }];
}

#pragma mark- api

#pragma mark- method
- (void)updateRouteItemWithArray:(NSArray *)routeArray {
    NSArray *subviews = self.contentView.subviews;
    for (UIView *item in subviews) {
        [item removeFromSuperview];
    }
    
    float width = kScreenWidth/3.0;
    CYTCarSourceDetailRouteItemView *lastView;
    for (int i=0; i<routeArray.count; i++) {
        CYTCarSourceDetailRouteItemView *item = [CYTCarSourceDetailRouteItemView new];
        item.model = routeArray[i];
        item.line.hidden = NO;
        [self.contentView addSubview:item];
        [item makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(0);
            if (lastView) {
                make.left.equalTo(lastView.right);
            }else {
                make.left.equalTo(0);
            }
            make.width.equalTo(width);
        }];
        lastView = item;
    }
    
    if (lastView) {
        lastView.line.hidden = YES;
        [lastView updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView);
        }];
    }
}

#pragma mark- set
- (void)setModel:(CarSourceDetailItemModel *)model {
    _model = model;
    
    if (![self.routeArray isEqual:model.routeArray]) {
        self.routeArray = [model.routeArray copy];
        [self updateRouteItemWithArray:model.routeArray];
    }
}
#pragma mark- get
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [UIScrollView new];
    }
    return _scrollView;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [UIView new];
    }
    return _contentView;
}


@end
