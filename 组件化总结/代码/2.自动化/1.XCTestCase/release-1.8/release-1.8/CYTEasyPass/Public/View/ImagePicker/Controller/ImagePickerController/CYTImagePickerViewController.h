//
//  CYTImagePickerController.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/7/13.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTBasicViewController.h"
#import "CYTNavigationController.h"

@class CYTAssetModel;
@class CYTAlbumModel;
@class CYTSelectedArrayModel;

@interface CYTImagePickerViewController : CYTBasicViewController

/** 图片间隔 */
@property(assign, nonatomic) CGFloat itemMargin;//默认6个pixel
/** 每行显示个数 */
@property(assign, nonatomic) NSInteger eachLineNum;//默认4个
/** 可选最大图片个数 */
@property(assign, nonatomic) NSInteger selectedMaxNum;//默认9个
/** 资源模型 */
@property(strong, nonatomic) CYTAssetModel *assetModel;
/** 完成 */
@property(copy, nonatomic) void(^completeAction)(NSArray <CYTAlbumModel*>*albumModels);



@end
