//
//  CYTPhotoCollectionViewCell.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/9/1.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CYTSelectImageModel;

@interface CYTImageCollectionViewCell : UICollectionViewCell

/** 图片 */
@property(strong, nonatomic) UIImageView *imageView;
/** 图片资源模型 */
@property(strong, nonatomic) CYTSelectImageModel *selectImageModel;
/** 是否为添加按钮 */
@property(assign, nonatomic,getter=isAddButton) BOOL addButton;
/** 添加按钮的点击 */
@property(copy, nonatomic) void(^addImageAction)();
/** 删除按钮的点击 */
@property(copy, nonatomic) void(^deleteImageAction)(CYTSelectImageModel *imageModel);

@end
