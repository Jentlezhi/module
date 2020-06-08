//
//  FFConditionView.h
//  CYTEasyPass
//
//  Created by xujunquan on 2017/10/12.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

/*
 使用方法
 - (void)ff_addSubViewAndConstraints {
     [super ff_addSubViewAndConstraints];
 
     [self.ffContentView addSubview:self.conditionView];
     [self.conditionView makeConstraints:^(MASConstraintMaker *make) {
         make.left.right.top.equalTo(self.ffContentView);
         make.height.equalTo(40);
     }];
 }

 - (CarFilterConditionView *)conditionView {
     if (!_conditionView) {
         _conditionView = [CarFilterConditionView new];
         _conditionView.segmentHeight = 40;
         _conditionView.viewHeight = (kScreenHeight-CYTViewOriginY-150);
     }
     return _conditionView;
 }
 */
#import "FFExtendView.h"
#import "FFBasicSegmentView.h"
#import "FFConditionView_bottom.h"

@interface FFConditionView : FFExtendView
@property (nonatomic, strong) FFExtendView *bgView;
@property (nonatomic, strong) FFBasicSegmentView *segmentView;
@property (nonatomic, strong) FFConditionView_bottom *closeView;

///获取当前index
@property (nonatomic, assign) NSInteger currentIndex;
///获取lastindex
@property (nonatomic, assign) NSInteger lastIndex;
///伸缩状态
@property (nonatomic, assign) BOOL isExtend;
///设置segment高度
@property (nonatomic, assign) float segmentHeight;
///回传index
- (void)segmentIndexChanged:(NSInteger)currentIndex;
///close方法供外部使用
- (void)closeConditionView;
///子类重写设置控件高度
- (float)extendContentHeightWithIndex:(NSInteger)index;
///更新高度
- (void)updateSelfHeightWithIndex:(NSInteger)index;

@end
