//
//  CYTImageAssetCell.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/7/13.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CYTAlbumModel;

@interface CYTImageAssetCell : UICollectionViewCell

/** 图片 */
@property(strong, nonatomic) UIImageView *itemImageView;
/** 相片模型 */
@property(strong, nonatomic) CYTAlbumModel *albumModel;
/** 选择按钮回调 */
@property(copy, nonatomic) void(^selectAction)(CYTAlbumModel *albumModel,BOOL selected);
@property(weak, nonatomic) id<UIViewControllerPreviewing> previewingContext;
@property (assign, nonatomic) BOOL firstRegisterPreview;
@end
