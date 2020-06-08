//
//  FFBasicSupernatantViewModel.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/9/15.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendViewModel.h"

typedef NS_ENUM(NSInteger,SupernatantShowType) {
    ///显示在window上
    SupernatantShowTypeWindow,
    ///显示在视图上
    SupernatantShowTypeView,
};

@interface FFBasicSupernatantViewModel : FFExtendViewModel
///显示类型
@property (nonatomic, assign, readonly) SupernatantShowType type;
///显示源
@property (nonatomic, weak) UIView *sourceView;
///点击背景
@property (nonatomic, copy) ffDefaultBlock bgClickedBlock;

@end
