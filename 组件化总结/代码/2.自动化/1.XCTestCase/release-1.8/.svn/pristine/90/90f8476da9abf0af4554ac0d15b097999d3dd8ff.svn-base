//
//  FFConditionView.m
//  CYTEasyPass
//
//  Created by xujunquan on 2017/10/12.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFConditionView.h"

@interface FFConditionView()
@property (nonatomic, assign) BOOL useCustomSegment;
@property (nonatomic, assign) float closeViewHeight;

@end

@implementation FFConditionView
@synthesize segmentView = _segmentView;

- (void)ff_initWithViewModel:(id)viewModel {
    _segmentHeight = 40;
    _isExtend = NO;
    _closeViewHeight = 0;
    self.backgroundColor = kFFColor_green;
}

- (void)ff_addSubViewAndConstraints {
    [self addSubview:self.bgView];
    [self addSubview:self.closeView];
    [self addSubview:self.segmentView];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (void)handleSegmentSelect {
    @weakify(self);
    [_segmentView setIndexChangeBlock:^(NSInteger index) {
        @strongify(self);
        //更新当前点击的item和上一次点击的item 和extend状态
        [self updateSelectItemAndIndex:index];
        //更新自身高度
        [self updateSelfHeightWithIndex:index];
        //更新index
        self.lastIndex = self.currentIndex;
        self.currentIndex = index;
        //回传
        [self segmentIndexChanged:index];
    }];
}

- (void)segmentIndexChanged:(NSInteger)currentIndex {
    
}

//在此方法调用前 isExtend 需要已完成赋值。
- (void)updateSelfHeightWithIndex:(NSInteger)index {
    @synchronized(self) {
        self.closeViewHeight = kFFAutolayoutV(60);
        float height = [self heightWithIndex:index];
        NSTimeInterval time = kFFAnimationDuration;
        if (!self.isExtend) {
            height = self.segmentHeight;
            self.closeViewHeight = 0;
            time = kFFAnimationDuration*0.5;
        }
        
        [self updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(height);
        }];
        [self.closeView updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(self.closeViewHeight);
        }];
        [UIView animateWithDuration:time animations:^{
            [self.superview layoutIfNeeded];
        }];
    }
}

- (void)updateSelectItemAndIndex:(NSInteger)index {
    FFBasicSegmentItemView *lastItem = [self.segmentView itemWithIndex:self.currentIndex];
    FFBasicSegmentItemView *item = [self.segmentView itemWithIndex:index];
    
    if (!self.isExtend) {
        //高亮当前item
        if (item) {
            item.titleColor = self.segmentView.titleSelColor;
        }
        self.isExtend = YES;
    }else {
        if (self.currentIndex == index) {
            //相同，置灰当前，index=-1；
            if (item) {
                item.titleColor = self.segmentView.titleNorColor;
            }
            self.isExtend = NO;
        }else {
            //不同，置灰上一个，高亮当前，
            if (lastItem) {
                lastItem.titleColor = self.segmentView.titleNorColor;
            }
            if (item) {
                item.titleColor = self.segmentView.titleSelColor;
            }
            self.isExtend = YES;
        }
    }
}

- (void)setSegmentHeight:(float)segmentHeight {
    _segmentHeight = segmentHeight;
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (void)setSegmentView:(FFBasicSegmentView *)segmentView {
    _segmentView = segmentView;
    _segmentView.showIndicatorLine = NO;
    _segmentView.showBottomLine = YES;
    self.useCustomSegment = YES;
    [self handleSegmentSelect];
}

- (void)updateConstraints {
    [self.bgView updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [self.closeView updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.equalTo(self.closeViewHeight);
    }];
    [self.segmentView updateConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.equalTo(self.segmentHeight);
    }];
    
    [super updateConstraints];
}

- (void)closeConditionView {
    self.segmentView.index = self.currentIndex;
}

- (float)heightWithContentHeight:(float)height {
    float allHeight = kFFAutolayoutV(60)+self.frame.size.height;
    allHeight+=height;
    return allHeight;
}

#pragma mark- method
- (float)heightWithIndex:(NSInteger)index {
    float contentHeight = [self extendContentHeightWithIndex:index];
    return contentHeight+self.segmentHeight+self.closeViewHeight;
}

- (float)extendContentHeightWithIndex:(NSInteger)index {
    return 200;
}

#pragma mark- get
- (FFBasicSegmentView *)segmentView {
    if (!_segmentView) {
        _segmentView = [FFBasicSegmentView new];
        _segmentView.type = FFBasicSegmentTypeAverage;
        _segmentView.showIndicatorLine = NO;
        _segmentView.showBottomLine = YES;
        _segmentView.titlesArray = @[@"1111111111111111111",@"222",@"333",@"4444"];
        [self handleSegmentSelect];
    }
    return _segmentView;
}

- (FFExtendView *)bgView {
    if (!_bgView) {
        _bgView = [FFExtendView new];
        _bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4f];
    }
    return _bgView;
}

- (FFConditionView_bottom *)closeView {
    if (!_closeView) {
        _closeView = [FFConditionView_bottom new];
        @weakify(self);
        [_closeView setClickedBlock:^{
            @weakify(self);
            self.segmentView.index = self.currentIndex;
        }];
    }
    return _closeView;
}

@end
