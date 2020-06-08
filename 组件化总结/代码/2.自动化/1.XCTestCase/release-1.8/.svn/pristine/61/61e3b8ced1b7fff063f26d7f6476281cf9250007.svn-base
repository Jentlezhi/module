//
//  CYTSelectImageModel.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/7/21.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>


@class CYTUploadImageResult;

@interface CYTSelectImageModel : NSObject

/** 图片资源 */
@property(strong, nonatomic) PHAsset *asset;
/** 图片 */
@property(strong, nonatomic) UIImage *image;
/** 是否编辑模式 */
@property(assign, nonatomic,getter=isEditMode) BOOL editMode;
/** 图片预览frame */
@property(assign, nonatomic) CGRect prviewFrame;
/** 预览图片 */
@property(strong, nonatomic) UIImage *prviewImage;
/** 图片url */
@property (copy,  nonatomic) NSString *imageURL;
/** fileId */
@property (copy,  nonatomic) NSString *fileID;
/** 资源顺序ID */
@property(assign, nonatomic) NSInteger ID;

@end
