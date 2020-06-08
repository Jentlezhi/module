//
//  CYTPhotoBrowseViewController.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/7/23.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTBasicViewController.h"

@class CYTAlbumModel;
@class CYTSelectImageModel;

@interface CYTPhotoBrowseViewController : CYTBasicViewController

/** 资源模型 */
@property(strong, nonatomic) NSMutableArray <CYTAlbumModel *>*albumModels;
/** 资源模型 */
@property(strong, nonatomic) NSArray <CYTSelectImageModel *>*selectImageModels;
/** 图片当前索引 */
@property(assign, nonatomic) NSUInteger photoIndex;
/** 是否显示动画 */
@property(assign, nonatomic) BOOL showAnimation;

- (instancetype)initWithShowAnimation:(BOOL)animation;

- (void)showPhotoBrowseViewWithAnimation;

@end
