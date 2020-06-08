//
//  CYTAlbumModel.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/7/13.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

typedef enum : NSUInteger {
    CYTAssetMediaTypePhoto   =  0,
    CYTAssetMediaTypeLivePhoto,
    CYTAssetlMediaTypePhotoGif,
    CYTAssetMediaTypeVideo,
    CYTAssetMediaTypeAudio
} CYTAssetMediaType;


@interface CYTAlbumModel : NSObject

/** 资源类型 */
@property(assign, nonatomic) CYTAssetMediaType assetMediaType;
/** 图片 */
@property(strong, nonatomic) UIImage *cameraImage;
/** 图片资源 */
@property(strong, nonatomic) PHAsset *asset;
/** 是否被选中 */
@property(assign, nonatomic,getter=isSelected) BOOL selected;
/** 是否已选到最大值 */
@property(assign, nonatomic,getter=isReachMaxSelectValue) BOOL reachMaxSelectValue;
/** 是否显示蒙层 */
@property(assign, nonatomic,getter=isShowCoverView) BOOL showCoverView;
/** 宽高比 */
@property(assign, nonatomic) CGFloat assetRadio;
/** 详情尺寸 */
@property(assign, nonatomic) CGSize detailSize;
/** 图片尺寸 */
@property(assign, nonatomic) CGSize pixelSize;
/** 图片预览frame */
@property(assign, nonatomic) CGRect prviewFrame;
/** 预览图片 */
@property(strong, nonatomic) UIImage *prviewImage;
/** 是否显示动画 */
@property(assign, nonatomic,getter=isShowAnimation) BOOL showAnimation;
/** 每行显示个数 */
@property(assign, nonatomic) NSInteger eachLineNum;
/** 图片url */
@property (copy,  nonatomic) NSString *imageURL;
///** 是否显示完成 */
//@property(assign, nonatomic,getter=isShowAnimationFinish) BOOL showAnimationFinish;
@end
