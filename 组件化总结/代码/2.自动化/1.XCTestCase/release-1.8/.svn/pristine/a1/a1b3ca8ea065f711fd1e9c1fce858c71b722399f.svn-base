//
//  CYTCarSourceAddImageViewController.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/7/23.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTBasicViewController.h"
#import <Photos/Photos.h>

@class CYTSelectImageModel;

@interface CYTCarSourceAddImageViewController : CYTBasicViewController

/** 相册资源模型 */
@property(strong, nonatomic) NSMutableArray <CYTSelectImageModel *>*albumModels;
/** 完成 */
@property(copy, nonatomic) void(^completion)(NSMutableArray <UIImage *>*images,NSMutableArray <NSData *>*imageDatas,NSMutableArray<CYTSelectImageModel *> *imageModels);

@end
