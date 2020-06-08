//
//  CYTSelectedImageCell.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/7/21.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CYTSelectImageModel;

@interface CYTSelectedImageCell : UICollectionViewCell
/** 图片 */
@property(strong, nonatomic) UIImageView *imageView;
/** 图片资源模型 */
@property(strong, nonatomic) CYTSelectImageModel *selectImageModel;
/** 是否为添加按钮 */
@property(assign, nonatomic,getter=isAddButton) BOOL addButton;
/** 添加按钮的点击 */
@property(copy, nonatomic) void(^addImageAction)();
/** 图片的点击 */
@property(copy, nonatomic) void(^imageViewClickAction)();
/** 选择按钮回调 */
@property(copy, nonatomic) void(^selectAction)(CYTSelectImageModel *albumModel,BOOL selected);


@end
