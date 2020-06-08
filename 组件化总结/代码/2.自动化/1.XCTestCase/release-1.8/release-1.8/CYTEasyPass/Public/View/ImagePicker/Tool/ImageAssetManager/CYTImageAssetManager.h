//
//  CYTImageAssetManager.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/7/13.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImagePickerMacro.h"
#import <Photos/Photos.h>

@class CYTAssetModel;
@class CYTAlbumModel;

@interface CYTImageAssetManager : NSObject

+ (instancetype)sharedAssetManager;

/** 图片间隔 */
@property(assign, nonatomic) CGFloat itemMargin;
/** 每行显示个数 */
@property(assign, nonatomic) NSInteger eachLineNum;
/** 每行显示个数 */
@property(assign, nonatomic) CGFloat imagePreviewMaxWidth;
/** 对图片资源排序:按修改时间升序，默认为YES */
@property(assign, nonatomic,getter=isSortAscendingByCreationDate) BOOL sortAscendingByCreationDate;
/** 对图片方向进行调整 */
@property(assign, nonatomic,getter=isAdjustImageDirection) BOOL adjustImageDirection;
/** 图片质量 */
@property(assign, nonatomic) CGFloat imageQuality;//0-1.0
/** 图片质量辅助设置 */
@property(assign, nonatomic) CGFloat imageQualityConfig;//0-1.0
/** 是否过滤空相册 */
@property(assign, nonatomic,getter=isFilterEmptyAlbum) BOOL filterEmptyAlbum;
/** 相机拍照图片回调 */
@property(copy, nonatomic) void(^cameraImageBlock)(UIImage *cameraImage);
/** 拍照界面销毁的回调 */
@property(copy, nonatomic) void(^imagePickerDeallocBlock)();
/**
 *  获取相机照片
 */
- (void)fetchCareraImage;
/**
 *  用户相机授权情况
 */
+ (void)requestCameraAuthorizationComplation:(void(^)())authorized;
/**
 *  用户授权情况
 */
+ (void)authorizationStatusWithDenied:(void(^)())denied authorized:(void(^)())authorized;
/**
 *  用户是否授权
 */
- (BOOL)authorizationStatusAuthorized;
/**
 *  发起授权
 */
- (void)requestAuthorizationComplation:(void(^)())completion;
/**
 *  图片字符串属性
 */
- (NSString *)localIdentifier:(PHAsset *)asset;
/**
 *  获取智能相册数据模型
 */
- (void)fetchSmartAlbumsWithAssetType:(CYTAssetType)assetType completion:(void(^)(CYTAssetModel*assetModel))completion;
/**
 *  获取所有图片资源模型
 */
- (void)fetchAllAssetModelsWithAssetType:(CYTAssetType)assetType completion:(void(^)(NSArray <CYTAssetModel *>*assetModels))completion;
/**
 *  获取图片
 */
- (PHImageRequestID)fetchImageWithAsset:(PHAsset*)asset completion:(void (^)(UIImage *image,NSDictionary *info,BOOL isDegraded))completion;
/**
 *  获取图片
 */
- (PHImageRequestID)fetchImageWithAsset:(PHAsset*)asset imageWidth:(CGFloat)imageWidth allowLoadFromiCloud:(BOOL)allow completion:(void (^)(UIImage *image,NSDictionary *info,BOOL isDegraded))completion;
/**
 *  获取图片
 */
- (PHImageRequestID)fetchImageWithAsset:(PHAsset*)asset allowLoadFromiCloud:(BOOL)allow completion:(void (^)(UIImage *image,NSDictionary *info,BOOL isDegraded))completion iCloudRequestProgressHandler:(void (^)(double progress, NSError *error, BOOL *stop, NSDictionary *info))progressHandler;
/**
 *  获取图片
 */
- (PHImageRequestID)fetchImageWithAsset:(PHAsset*)asset imageWidth:(CGFloat)imageWidth allowLoadFromiCloud:(BOOL)allow completion:(void (^)(UIImage *image,NSDictionary *info,BOOL isDegraded))completion iCloudRequestProgressHandler:(void (^)(double progress, NSError *error, BOOL *stop, NSDictionary *info))progressHandler;
/**
 *  获取相册封面图
 */
- (void)fetchAlbumCoverImageWithAlbumModel:(CYTAssetModel *)assetModel coverWidth:(CGFloat)coverWidth completion:(void (^)(UIImage *image))completion;
/**
 *  获取高清图片
 */
- (void)fetchHighQualityImageWithAsset:(PHAsset*)asset withSize:(CGSize)imageSize completion:(void(^)(UIImage *image,NSDictionary *info))completion error:(void(^)(NSDictionary *info))error;
/**
 *  获取原图
 */
- (void)fetchOriginImageWithAsset:(PHAsset*)asset completion:(void(^)(UIImage *image,NSDictionary *info))completion;
/**
 *  获取图片二进制
 */
- (PHImageRequestID)fetchImageDataWithAsset:(PHAsset*)asset completion:(void (^)(NSData *imageData,NSDictionary *info))completion;
/**
 *  获取图片大小
 */
- (PHImageRequestID)fetchAssetSizeWithAsset:(PHAsset*)asset completion:(void (^)(CGFloat assetSize))completion;
/**
 *  图片加载质量
 */
+ (CGFloat)fetchImageQualityWithImageSize:(CGFloat)imageSize;
/**
 *  获取待上传图片
 */
- (PHImageRequestID)fetchUploadImageWithAsset:(PHAsset*)asset ID:(NSInteger)ID completion:(void (^)(UIImage *image,NSDictionary *info))completion;

@end
