//
//  LogisticsHomeHeadView.m
//  CYTEasyPass
//
//  Created by xujunquan on 2017/10/9.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "LogisticsHomeHeadView.h"

@implementation LogisticsHomeHeadView

- (void)ff_addSubViewAndConstraints {

    [self addSubview:self.bannerView];
    [self addSubview:self.publishView];
    [self addSubview:self.needView];
    [self addSubview:self.orderView];
    
    [self.bannerView makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.equalTo(CYTAutoLayoutV(210));
    }];
    [self.publishView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTMarginH);
        make.top.equalTo(self.bannerView.bottom).offset(CYTItemMarginV);
        make.right.equalTo(-CYTMarginH);
        make.height.equalTo(CYTAutoLayoutV(160));
    }];
    [self.needView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTMarginH);
        make.top.equalTo(self.publishView.bottom).offset(CYTItemMarginV);
        make.height.equalTo(CYTAutoLayoutV(160));
        make.width.equalTo(CYTAutoLayoutH(335));
    }];
    [self.orderView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.needView.right).offset(CYTItemMarginH);
        make.top.equalTo(self.needView);
        make.width.equalTo(self.needView);
        make.right.equalTo(-CYTMarginH);
        make.bottom.equalTo(-CYTItemMarginV);
    }];
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    if (self.bannerBlock) {
        self.bannerBlock(index);
    }
}

#pragma mark- get
- (SDCycleScrollView *)bannerView {
    if (!_bannerView) {
        _bannerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, CYTAutoLayoutV(210)) delegate:self placeholderImage:nil];
        _bannerView.currentPageDotImage = [UIImage imageNamed:@"home_pageControl_cur"];
        _bannerView.pageDotImage = [UIImage imageNamed:@"home_pageControl_nor"];
        _bannerView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        _bannerView.placeholderImage = [UIImage imageNamed:@"img_logistic_banner"];
        _bannerView.hidesForSinglePage = YES;
        _bannerView.pageControlBottomOffset = -CYTAutoLayoutV(10);
    }
    return _bannerView;
}

- (LogisticsHomeHeadItem *)publishView {
    if (!_publishView) {
        _publishView = [LogisticsHomeHeadItem new];
        _publishView.imageView.image = [UIImage imageNamed:@"logistics_home_pub"];
        @weakify(self);
        [_publishView setClickedBlock:^(id view) {
            @strongify(self);
            if (self.clickedBlock) {
                self.clickedBlock(100);
            }
        }];
    }
    return _publishView;
}

- (LogisticsHomeHeadItem *)needView {
    if (!_needView) {
        _needView = [LogisticsHomeHeadItem new];
        _needView.imageView.image = [UIImage imageNamed:@"logistics_home_need"];
        @weakify(self);
        [_needView setClickedBlock:^(id view) {
            @strongify(self);
            if (self.clickedBlock) {
                self.clickedBlock(200);
            }
        }];
    }
    return _needView;
}

- (LogisticsHomeHeadItem *)orderView {
    if (!_orderView) {
        _orderView = [LogisticsHomeHeadItem new];
        _orderView.imageView.image = [UIImage imageNamed:@"logistics_home_order"];
        @weakify(self);
        [_orderView setClickedBlock:^(id view) {
            @strongify(self);
            if (self.clickedBlock) {
                self.clickedBlock(300);
            }
        }];
    }
    return _orderView;
}


@end
