//
//  CYTAssetModel.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/7/14.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

@class CYTAlbumModel;

@interface CYTAssetModel : NSObject

/** 相册 */
@property(strong, nonatomic) PHAssetCollection *assetCollection;
/** 相册名称 */
@property(copy, nonatomic) NSString *albumsTitle;
/** 相册图片个数 */
@property(assign, nonatomic) NSUInteger albumTotalNum;
/** 图片资源 */
@property(strong, nonatomic) NSMutableArray <CYTAlbumModel *>*albumModels;
/** asset资源 */
@property(strong, nonatomic) NSMutableArray <PHAsset *>*assets;

@end
