//
//  CYTPhotoSelectTool.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/5/3.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <UIKit/UIKit.h>

//图片选择样式
typedef enum : NSUInteger {
    CYTImageModeAllowsEditing = 0,  //可编辑模式
    CYTImageModePreview,            //预览模式
} CYTImageMode;

@interface CYTPhotoSelectTool : NSObject

/** 图片的回调 */
@property(copy, nonatomic) void(^imageBack)(UIImage *);

+ (void)photoSelectToolWithImageMode:(CYTImageMode)imageMode image:(void(^)(UIImage *selectedImage))imageBlock;



@end
