//
//  CYTImageAssetManager.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/7/13.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTImageAssetManager.h"
#import "CYTAssetModel.h"
#import "CYTAlbumModel.h"
#import <AVFoundation/AVFoundation.h>
#import "CYTImagePickerController.h"


static CGSize assetThumbnailSize;
static CGFloat screenScale;
@interface CYTImageAssetManager()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>


@end

@implementation CYTImageAssetManager

static CYTImageAssetManager *imageAssetManager;
static dispatch_once_t onceToken;
/**
 *  单例对象
 */
+ (instancetype)sharedAssetManager{
    dispatch_once(&onceToken, ^{
        imageAssetManager = [[self alloc] init];
        screenScale = kScreenWidth>375.f ? 3.f:2.5f;
    });
    return imageAssetManager;
}

- (instancetype)init{
    if (self = [super init]) {
        [self basicConfig];
    }
    return self;
}

#pragma mark - 初始化设置

/**
 *  基本配置
 */
- (void)basicConfig{
    //设置默认排序
    self.sortAscendingByCreationDate = YES;
}

#pragma mark - 权限设置

#pragma mark - 相机权限

+ (void)requestCameraAuthorizationComplation:(void(^)())authorized{
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    switch (status) {
        case AVAuthorizationStatusNotDetermined:{
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        !authorized?:authorized();
                    });
                }
            }];
            break;
        }
        case AVAuthorizationStatusAuthorized:{
            !authorized?:authorized();
            break;
        }
        case AVAuthorizationStatusDenied:
        case AVAuthorizationStatusRestricted:
            [CYTAlertView alertTipWithTitle:@"提示" message:@"没有权限访问您的相册，请前往设置允许该应用访问相册。" confiemAction:nil];
            break;
        default:
            break;
    }

}

#pragma mark - 相册权限

+ (void)authorizationStatusWithDenied:(void(^)())denied authorized:(void(^)())authorized{
       PHAuthorizationStatus status = [CYTImageAssetManager authorizationStatus];
    switch (status) {
        case PHAuthorizationStatusNotDetermined:
        {
            [[CYTImageAssetManager sharedAssetManager] requestAuthorizationComplation:^{
                [CYTImageAssetManager authorizationStatusWithDenied:denied authorized:authorized];
            }];
        }
            break;
        case PHAuthorizationStatusRestricted:
        case PHAuthorizationStatusDenied:
            !denied?:denied();
            break;
        case PHAuthorizationStatusAuthorized:
            !authorized?:authorized();
            break;
        default:
            break;
    }

}
/**
 *  用户授权情况
 */
+ (PHAuthorizationStatus)authorizationStatus{
    return [PHPhotoLibrary authorizationStatus];
}
/**
 *  用户是否授权
 */
- (BOOL)authorizationStatusAuthorized{
    PHAuthorizationStatus status = [self.class authorizationStatus];
    if (!status) {
        [self requestAuthorizationComplation:nil];
    }
    BOOL authorized = status == PHAuthorizationStatusAuthorized;
    return authorized;
}
/**
 *  发起授权
 */
- (void)requestAuthorizationComplation:(void(^)())completion{
    dispatch_async(dispatch_get_main_queue(), ^{
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            !completion?:completion();
        }];
    });
}


#pragma mark - 属性设置

- (void)setEachLineNum:(NSInteger)eachLineNum{
    _eachLineNum = eachLineNum;
    CGFloat itemWH = ([UIScreen mainScreen].bounds.size.width - (self.eachLineNum + 1) * self.itemMargin) / self.eachLineNum;
    assetThumbnailSize = CGSizeMake(itemWH, itemWH);
}

- (CGFloat)imageQuality{
    if (_imageQuality <= 0 || _imageQuality >= 1.0) {
        return 1.0f;
    }else{
        return _imageQuality;
    }
}

- (CGFloat)imageQualityConfig{
    if (_imageQualityConfig <= 0 || _imageQualityConfig >= 1.0) {
        return 1.0f;
    }else{
        return _imageQualityConfig;
    }
}

- (CGFloat)imagePreviewMaxWidth{
    return kScreenWidth;
}

#pragma mark - 获取拍照照片

- (void)fetchCareraImage{
    CYTWeakSelf
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
        CYTImagePickerController *carmeraIpc = [[CYTImagePickerController alloc] init];
        carmeraIpc.deallocBlock = ^{
            !weakSelf.imagePickerDeallocBlock?:weakSelf.imagePickerDeallocBlock();
        };
        carmeraIpc.delegate = self;
//        carmeraIpc.modalPresentationStyle = UIModalPresentationCustom;
        carmeraIpc.sourceType = UIImagePickerControllerSourceTypeCamera;
        [[CYTCommonTool currentViewController] presentViewController:carmeraIpc animated:YES completion:nil];
    }
}

#pragma mark - <UIImagePickerControllerDelegate>
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *selectedImage = info[UIImagePickerControllerOriginalImage];
    @weakify(self);
    [[CYTCommonTool currentViewController] dismissViewControllerAnimated:YES completion:^{
        @strongify(self);
        !self.cameraImageBlock?:self.cameraImageBlock(selectedImage);
    }];
}

#pragma mark - 获取相册封面图

- (void)fetchAlbumCoverImageWithAlbumModel:(CYTAssetModel *)assetModel coverWidth:(CGFloat)coverWidth completion:(void (^)(UIImage *))completion{
    CYTAlbumModel *albumModel = [[CYTAlbumModel alloc] init];
    if (self.sortAscendingByCreationDate) {
        albumModel = [assetModel.albumModels lastObject];
    }else{
        albumModel = [assetModel.albumModels firstObject];
    }
    
    [self fetchAssetSizeWithAsset:albumModel.asset completion:^(CGFloat assetSize) {
        self.imageQuality = [[self class] fetchImageQualityWithImageSize:assetSize];
        [self fetchImageWithAsset:albumModel.asset imageWidth:coverWidth allowLoadFromiCloud:YES completion:^(UIImage *image, NSDictionary *info, BOOL isDegraded) {
            !completion?:completion(image);
        }];
    }];
    

}

#pragma mark - 获取智能相册数据模型

- (void)fetchSmartAlbumsWithAssetType:(CYTAssetType)assetType completion:(void(^)(CYTAssetModel*assetModel))completion{
    
   __block CYTAssetModel *assetModel = [[CYTAssetModel alloc] init];
    [self fetchAssetCollectionWithAssetType:assetType collectionType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular completion:^(NSArray<PHAssetCollection *> *assetCollection) {
        [assetCollection enumerateObjectsUsingBlock:^(PHAssetCollection * _Nonnull assetCollection, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([self isAllAlbumWithAlbumName:assetCollection.localizedTitle]) {
                assetModel.assetCollection = assetCollection;
                [self fetchAssetsWithAssetType:assetType assetCollection:assetCollection completion:^(NSArray<PHAsset *> *assets) {
                    assetModel.albumTotalNum = assets.count;
                    [assets enumerateObjectsUsingBlock:^(PHAsset * _Nonnull asset, NSUInteger idx, BOOL * _Nonnull stop) {
                        CYTAlbumModel *albumModel = [[CYTAlbumModel alloc] init];
                        albumModel.assetMediaType = [self typeWithAsset:asset];
                        albumModel.asset = asset;
                        [assetModel.assets addObject:asset];
                        if ([self typeWithAsset:asset] != CYTAssetMediaTypeVideo) {
                            [assetModel.albumModels addObject:albumModel];
                        }
                    }];
                }];
                *stop = YES;
            }
        }];
    }];
    !completion?:completion(assetModel);
}

#pragma mark - 获取所有资源数据模型

- (void)fetchAllAssetModelsWithAssetType:(CYTAssetType)assetType completion:(void(^)(NSArray <CYTAssetModel *>*))completion{
    __block NSMutableArray *assetModels = [NSMutableArray array];
    //获取智能相册
    [self fetchAssetCollectionWithAssetType:assetType collectionType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular completion:^(NSArray<PHAssetCollection *> *assetCollection) {
        [assetCollection enumerateObjectsUsingBlock:^(PHAssetCollection * _Nonnull assetCollection, NSUInteger idx, BOOL * _Nonnull stop) {
            __block BOOL isAssetsNull = NO;
            __block CYTAssetModel *assetModel = [[CYTAssetModel alloc] init];
            BOOL isRecentlyDeleted = [self isRecentlyDeletedWithAlbumName:assetCollection.localizedTitle];
            BOOL isVideo = [self isVideoWithAlbumName:assetCollection.localizedTitle];
            assetModel.assetCollection = assetCollection;
            [self fetchAssetsWithAssetType:assetType assetCollection:assetCollection completion:^(NSArray<PHAsset *> *assets) {
                NSUInteger assetCount = assets.count;
                isAssetsNull = assets.count <= 0;
                assetModel.albumTotalNum = assetCount;
                [assets enumerateObjectsUsingBlock:^(PHAsset * _Nonnull asset, NSUInteger idx, BOOL * _Nonnull stop) {
                    if (!isRecentlyDeleted) {
                        CYTAlbumModel *albumModel = [[CYTAlbumModel alloc] init];
                        albumModel.assetMediaType = [self typeWithAsset:asset];
                        albumModel.asset = asset;
                        albumModel.assetRadio = asset.pixelWidth*1.0/asset.pixelWidth;
                        //                    if (albumModel.assetRadio > 1.f || albumModel.assetRadio < 0.2f) {
                        //                        albumModel.bigImage = YES;
                        //                    }else{
                        //                        albumModel.bigImage = NO;
                        //                    }
                        if ([self typeWithAsset:asset] != CYTAssetMediaTypeVideo) {
                            [assetModel.albumModels addObject:albumModel];
                        }
                        
                    }

                }];
            }];
            if (self.isFilterEmptyAlbum) {
                if (!isAssetsNull && !isRecentlyDeleted && !isVideo) {
                    [assetModels addObject:assetModel];
                }
            }else{
               [assetModels addObject:assetModel];
            }
            
        }];
    }];
    
    //获取用户相册
    [self fetchAssetCollectionWithAssetType:assetType collectionType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary completion:^(NSArray<PHAssetCollection *> *assetCollection) {
        [assetCollection enumerateObjectsUsingBlock:^(PHAssetCollection * _Nonnull assetCollection, NSUInteger idx, BOOL * _Nonnull stop) {
            __block BOOL isAssetsNull = NO;
            __block CYTAssetModel *assetModel = [[CYTAssetModel alloc] init];
            assetModel.assetCollection = assetCollection;
            [self fetchAssetsWithAssetType:assetType assetCollection:assetCollection completion:^(NSArray<PHAsset *> *assets) {
                NSUInteger assetCount = assets.count;
                isAssetsNull = assets.count <= 0;
                assetModel.albumTotalNum = assetCount;
                [assets enumerateObjectsUsingBlock:^(PHAsset * _Nonnull asset, NSUInteger idx, BOOL * _Nonnull stop) {
                    CYTAlbumModel *albumModel = [[CYTAlbumModel alloc] init];
                    albumModel.asset = asset;
                    [assetModel.albumModels addObject:albumModel];
                }];
            }];
            if (self.isFilterEmptyAlbum) {
                if (!isAssetsNull) {
                    [assetModels addObject:assetModel];
                }
            }else{
                [assetModels addObject:assetModel];
            }
        }];
    }];
    
    !completion?:completion(assetModels);
}

#pragma mark - 获取图片资源集合

- (void)fetchAssetCollectionWithAssetType:(CYTAssetType)assetType collectionType:(PHAssetCollectionType)type subtype:(PHAssetCollectionSubtype)subtype completion:(void(^)(NSArray <PHAssetCollection *>*))completion{
    PHFetchResult *assetCollectionResult = [PHAssetCollection fetchAssetCollectionsWithType:type subtype:subtype options:nil];
    PHFetchOptions *fetchOptions = [[PHFetchOptions alloc] init];
    if (assetType == CYTAssetTypePhoto) {
        fetchOptions.predicate = [NSPredicate predicateWithFormat:@"mediaType == %ld", PHAssetMediaTypeImage];
    }else if (assetType == CYTAssetTypeVideo){
        fetchOptions.predicate = [NSPredicate predicateWithFormat:@"mediaType == %ld", PHAssetMediaTypeVideo];
    }
    fetchOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
    NSMutableArray *assetCollectionArray = [NSMutableArray array];
    [assetCollectionResult enumerateObjectsUsingBlock:^(PHAssetCollection  *_Nonnull assetCollection, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([self isAllAlbumWithAlbumName:assetCollection.localizedTitle]) {
            [assetCollectionArray insertObject:assetCollection atIndex:0];
        }else{
            [assetCollectionArray addObject:assetCollection];
        }
        
    }];
    
    !completion?:completion(assetCollectionArray);
}

#pragma mark - 获取相机胶卷

- (void)fetchAllPhotosWithAssetType:(CYTAssetType)assetType completion:(void(^)(NSArray <PHAssetCollection *>*))completion{
    [self fetchAssetCollectionWithAssetType:assetType collectionType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular completion:^(NSArray<PHAssetCollection *> *assetCollection) {
        !completion?:completion(assetCollection);
    }];
}




#pragma mark - 获取图片/视频集合

- (void)fetchAssetsWithAssetType:(CYTAssetType)assetType assetCollection:(PHAssetCollection *)assetCollection completion:(void(^)(NSArray <PHAsset *>*))completion{
    PHFetchOptions *fetchOptions = [[PHFetchOptions alloc] init];
    if (assetType == CYTAssetTypePhoto) {
        fetchOptions.predicate = [NSPredicate predicateWithFormat:@"mediaType == %ld", PHAssetMediaTypeImage];
    }else if (assetType == CYTAssetTypeVideo){
        fetchOptions.predicate = [NSPredicate predicateWithFormat:@"mediaType == %ld", PHAssetMediaTypeVideo];
    }
    fetchOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:self.sortAscendingByCreationDate]];
    NSMutableArray *assetArray = [NSMutableArray array];
    PHFetchResult *assetResult = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
    for (PHAsset *asset in assetResult) {
        [assetArray addObject:asset];
    }
    !completion?:completion(assetArray);
    
}

#pragma mark - 获取原图

- (void)fetchOriginImageWithAsset:(PHAsset*)asset completion:(void(^)(UIImage *image,NSDictionary *info))completion{
    [self fetchHighQualityImageWithAsset:asset withSize:CGSizeMake(asset.pixelWidth, asset.pixelHeight) completion:completion error:nil];
}
#pragma mark - 获取高清图片

- (void)fetchHighQualityImageWithAsset:(PHAsset*)asset withSize:(CGSize)imageSize completion:(void(^)(UIImage *image,NSDictionary *info))completion error:(void(^)(NSDictionary *info))error{
    PHImageRequestID requestID = -1;
    PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
    option.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    option.resizeMode = PHImageRequestOptionsResizeModeFast;
    option.synchronous = YES;
    requestID = [[PHCachingImageManager defaultManager] requestImageForAsset:asset targetSize:imageSize contentMode:PHImageContentModeAspectFill options:option resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        BOOL downloadFinined = (![[info objectForKey:PHImageCancelledKey] boolValue] && ![[info objectForKey:PHImageErrorKey] boolValue] && ![[info objectForKey:PHImageResultIsDegradedKey] boolValue]);
        if (downloadFinined && result) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (completion) {
                    completion(result,info);
                }
            });
        }else {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (error) {
                    error(info);
                }
            });
        }
    }];
}

#pragma mark - 获取图片大小

- (PHImageRequestID)fetchAssetSizeWithAsset:(PHAsset*)asset completion:(void (^)(CGFloat assetSize))completion{
    PHImageRequestOptions *option = [[PHImageRequestOptions alloc]init];
    option.resizeMode = PHImageRequestOptionsResizeModeFast;
    option.networkAccessAllowed = YES;
    __block CGFloat assetSize = 0.f;
   return [[PHImageManager defaultManager] requestImageDataForAsset:asset options:option resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
        assetSize = imageData.length/1024.f/1024.f;
       !completion?:completion(assetSize);
    }];
}

#pragma mark - 获取data

- (PHImageRequestID)fetchImageDataWithAsset:(PHAsset*)asset completion:(void (^)(NSData *imageData,NSDictionary *info))completion{
    PHImageRequestOptions *option = [[PHImageRequestOptions alloc]init];
    option.resizeMode = PHImageRequestOptionsResizeModeFast;
    option.networkAccessAllowed = YES;
    return [[PHImageManager defaultManager] requestImageDataForAsset:asset options:option resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
        if (imageData) {
            !completion?:completion(imageData,info);
        }
    }];
}


#pragma mark - 获取图片

- (PHImageRequestID)fetchImageWithAsset:(PHAsset*)asset completion:(void (^)(UIImage *image,NSDictionary *info,BOOL isDegraded))completion{
    CGFloat imageWidth = kScreenWidth>self.imagePreviewMaxWidth ? self.imagePreviewMaxWidth:kScreenWidth;
    return [self fetchImageWithAsset:asset imageWidth:imageWidth allowLoadFromiCloud:YES completion:completion iCloudRequestProgressHandler:nil];
}

- (PHImageRequestID)fetchImageWithAsset:(PHAsset*)asset imageWidth:(CGFloat)imageWidth allowLoadFromiCloud:(BOOL)allow completion:(void (^)(UIImage *image,NSDictionary *info,BOOL isDegraded))completion{
    return [self fetchImageWithAsset:asset imageWidth:imageWidth allowLoadFromiCloud:allow completion:completion iCloudRequestProgressHandler:nil];
}

- (PHImageRequestID)fetchImageWithAsset:(PHAsset*)asset allowLoadFromiCloud:(BOOL)allow completion:(void (^)(UIImage *image,NSDictionary *info,BOOL isDegraded))completion iCloudRequestProgressHandler:(void (^)(double progress, NSError *error, BOOL *stop, NSDictionary *info))progressHandler{
    CGFloat imageWidth = kScreenWidth>self.imagePreviewMaxWidth ? self.imagePreviewMaxWidth:kScreenWidth;
    return [self fetchImageWithAsset:asset imageWidth:imageWidth allowLoadFromiCloud:allow completion:completion iCloudRequestProgressHandler:progressHandler];
}

- (PHImageRequestID)fetchImageWithAsset:(PHAsset*)asset imageWidth:(CGFloat)imageWidth allowLoadFromiCloud:(BOOL)allow completion:(void (^)(UIImage *image,NSDictionary *info,BOOL isDegraded))completion iCloudRequestProgressHandler:(void (^)(double progress, NSError *error, BOOL *stop, NSDictionary *info))progressHandler{
    if (![asset isKindOfClass:[PHAsset class]]) return 0;
    CGSize imageSize = CGSizeZero;
    if (imageWidth < kScreenWidth && imageWidth < _imagePreviewMaxWidth) {
        imageSize = assetThumbnailSize;
    } else {
        CGFloat assetRadio = asset.pixelWidth/(CGFloat)asset.pixelHeight;
        CGFloat pixelWidth = imageWidth * screenScale * self.imageQuality * self.imageQualityConfig;
        //处理太宽和太高的图片
        if (assetRadio > 1) {
            pixelWidth = pixelWidth * assetRadio;
        }
        if (assetRadio < 0.2) {
            pixelWidth = pixelWidth * 0.5f;
        }
        CGFloat pixelHeight = pixelWidth/assetRadio;
        imageSize = CGSizeMake(pixelWidth, pixelHeight);
    }
    //请求图片
    __block UIImage *image = nil;
    PHImageRequestOptions *imageRequestOptions = [[PHImageRequestOptions alloc] init];
    imageRequestOptions.resizeMode = PHImageRequestOptionsResizeModeFast;
//    imageRequestOptions
    return [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:imageSize contentMode:PHImageContentModeAspectFill options:imageRequestOptions resultHandler:^(UIImage *result, NSDictionary *info) {
        if (!result) {
            image = [UIImage imageNamed:@"img_picture_180x180_hl"];
            return;
        }else{
            image = result;
        }
        BOOL downloadFinined = (![[info objectForKey:PHImageCancelledKey] boolValue] && ![info objectForKey:PHImageErrorKey]);
        if (downloadFinined && result) {
            image = [self adjustImageDirectionWithImage:result];
            BOOL isDegraded = [[info objectForKey:PHImageResultIsDegradedKey] boolValue];
            if (completion) completion(image,info,isDegraded);
        }
        
        BOOL resultIsInCloud = [info objectForKey:PHImageResultIsInCloudKey];
        if (!resultIsInCloud || image || !allow ) return;
        
        
        //从iCloud加载图片
        PHImageRequestOptions *imageRequestOptions = [[PHImageRequestOptions alloc] init];
        imageRequestOptions.progressHandler = ^(double progress, NSError *error, BOOL *stop, NSDictionary *info) {
            dispatch_async(dispatch_get_main_queue(), ^{
                !progressHandler?:progressHandler(progress,error,stop,info);
            });
        };
        imageRequestOptions.networkAccessAllowed = YES;
        imageRequestOptions.resizeMode = PHImageRequestOptionsResizeModeFast;
        [[PHImageManager defaultManager] requestImageDataForAsset:asset options:imageRequestOptions resultHandler:^(NSData *imageData, NSString *dataUTI, UIImageOrientation orientation, NSDictionary *info) {
            UIImage *resultImage = [UIImage imageWithData:imageData scale:0.1];
            resultImage = [self resizeImage:resultImage toSize:imageSize];
            if (!resultImage) {
                resultImage = image;
            }
            resultImage = [self adjustImageDirectionWithImage:resultImage];
            !completion?:completion(resultImage,info,NO);
        }];
    }];
}

/**
 *  获取待上传图片
 */
- (PHImageRequestID)fetchUploadImageWithAsset:(PHAsset*)asset ID:(NSInteger)ID completion:(void (^)(UIImage *image,NSDictionary *info))completion {
    if (![asset isKindOfClass:[PHAsset class]]) return 0;
    PHImageRequestOptions *imageRequestOptions = [[PHImageRequestOptions alloc] init];
    imageRequestOptions.resizeMode = PHImageRequestOptionsResizeModeFast;
    imageRequestOptions.networkAccessAllowed = YES;
    imageRequestOptions.synchronous = NO;
    
    return [[PHImageManager defaultManager] requestImageDataForAsset:asset options:imageRequestOptions resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
        BOOL downloadFinined = (![[info objectForKey:PHImageCancelledKey] boolValue] && ![info objectForKey:PHImageErrorKey] && ![[info objectForKey:PHImageResultIsDegradedKey] boolValue]);
        if (downloadFinined && imageData) {
            UIImage *image = [UIImage imageWithData:imageData];
            image.ID = ID;
            !completion?:completion(image,info);
        }
    }];
    
}



#pragma mark - 配置

/**
 *  是否为智能相册（所有照片）
 */
- (BOOL)isAllAlbumWithAlbumName:(NSString *)albumName{
    return [albumName isEqualToString:@"Camera Roll"] || [albumName isEqualToString:@"相机胶卷"] || [albumName isEqualToString:@"所有照片"] || [albumName isEqualToString:@"All Photos"];
}

/**
 *  是否为最近删除文件
 */
- (BOOL)isRecentlyDeletedWithAlbumName:(NSString *)albumName{
    return [albumName isEqualToString:@"Recently Deleted"] || [albumName isEqualToString:@"最近删除"];
}
/**
 *  是否为视频文件
 */
- (BOOL)isVideoWithAlbumName:(NSString *)albumName{
    return [albumName isEqualToString:@"Videos"] || [albumName isEqualToString:@"视频"];
}
/**
 *  调整图片方向
 */
- (UIImage *)adjustImageDirectionWithImage:(UIImage *)aImage{
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    CGAffineTransform transform = CGAffineTransformIdentity;
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *bImage = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return bImage;
    
}
/**
 *  调整图片尺寸
 */
- (UIImage *)resizeImage:(UIImage *)aImage toSize:(CGSize)aSize{
    if (aImage.size.width > aSize.width) {
        UIGraphicsBeginImageContext(aSize);
        [aImage drawInRect:CGRectMake(0, 0, aSize.width, aSize.height)];
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return newImage;
    } else {
        return aImage;
    }
}

/**
 *  图片字符串属性
 */
- (NSString *)localIdentifier:(PHAsset *)asset{
    return asset.localIdentifier;
}
/**
 *  资源类型
 */
- (CYTAssetMediaType)typeWithAsset:(PHAsset *)asset{
    if (asset.mediaType == PHAssetMediaTypeVideo) {
        return CYTAssetMediaTypeVideo;
    }else if (asset.mediaType == PHAssetMediaTypeImage){
        if ([[asset valueForKey:@"filename"] hasSuffix:@"GIF"]) {
            return CYTAssetlMediaTypePhotoGif;
        }
        return CYTAssetMediaTypePhoto;
    }
    return CYTAssetMediaTypeLivePhoto;
}
/**
 *  资源类型
 */
+ (CGFloat)fetchImageQualityWithImageSize:(CGFloat)imageSize{
    float limitSize = 10.f;
    if (imageSize<=limitSize) {
        NSUInteger base = floorf(imageSize);
        CGFloat floorIndex = base*0.05f;
        return 1.f - floorIndex;
    }else{
        return limitSize/imageSize*0.5f;
    }
}


@end
