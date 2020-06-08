//
//  CYTPhotoCollectionView.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/9/1.
//  Copyright © 2017年 EasyPass. All rights reserved.
//
/*
 CYTImageCollectionView *imageCollectionView = [[CYTImageCollectionView alloc] init];
 [self.view addSubview:imageCollectionView];
 [imageCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
 make.edges.equalTo(UIEdgeInsetsMake(CYTViewOriginY, 0, 0, 0));
 }];
 */

#import <UIKit/UIKit.h>

@class CYTSelectImageModel;

@interface CYTImageCollectionView : UIView

/** 图片间隔 */
@property(assign, nonatomic) CGFloat itemMargin;//默认15个pixel
/** 顶部间隔 */
@property(assign, nonatomic) CGFloat topBottomMargin;//默认30个pixel
/** 左右间隔 */
@property(assign, nonatomic) CGFloat leftRightMargin;//默认30个pixel
/** 每行显示个数 */
@property(assign, nonatomic) NSInteger eachLineNum;//默认3个
/** 可选最大图片个数 */
@property(assign, nonatomic) NSInteger selectedMaxNum;//默认9个
/** 高度 */
@property(assign, nonatomic) CGFloat collectionViewHeight;
/** 适配高度 */
@property(assign, nonatomic) CGFloat layoutHeight;
/** 重新布局回调 */
@property(copy, nonatomic) void(^reLayout)();
/** 已选中的图片 */
@property(strong, nonatomic,readonly) NSMutableArray<CYTSelectImageModel *> *selectedImageModels;

@end
