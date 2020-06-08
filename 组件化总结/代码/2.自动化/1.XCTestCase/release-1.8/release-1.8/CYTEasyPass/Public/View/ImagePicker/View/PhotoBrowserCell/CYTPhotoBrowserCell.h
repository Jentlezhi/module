//
//  CYTPhotoBrowserCell.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/7/19.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CYTAlbumModel;

@interface CYTPhotoBrowserCell : UICollectionViewCell

/** 图片模型 */
@property(strong, nonatomic) CYTAlbumModel *albumModel;
///** 是否显示动画 */
//@property(assign, nonatomic) BOOL showAnimation;
/** 设置控制器透明度为0 */
@property(copy, nonatomic) void(^setControllerViewColor)();
/** 关闭当前控制器 */
@property(copy, nonatomic) void(^dismissController)();
/** 单击手势 */
@property(copy, nonatomic) void(^signalTapClick)();

@end
