//
//  CYT3DPriviewController.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/7/20.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTBasicViewController.h"

@class CYTAlbumModel;

@interface CYT3DPriviewController : CYTBasicViewController

- (void)showPhotoBrowserViewWithAnimation;

/** 图片模型 */
@property(strong, nonatomic) CYTAlbumModel *albumModel;

@end
