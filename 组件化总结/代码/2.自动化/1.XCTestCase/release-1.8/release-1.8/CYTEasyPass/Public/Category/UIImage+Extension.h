//
//  UIImage+Extension.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/1.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

/** 图片上传：服务器地址 */
@property(copy, nonatomic) NSString *fileID;
/** id */
@property(assign, nonatomic) NSInteger ID;
/**
 *  拉伸背景获得一张新的图片
 *
 *  @param name 图片名称
 *
 *  @return 拉伸后的图片
 */
+ (instancetype)resizedImageWithName:(NSString *)name;
/**
 *  平铺模式，通过重复显示指定的矩形区域来填充图
 *
 *  @param name 图片名称
 *
 *  @return 返回通过平铺模式拉伸的图片
 */
+ (instancetype)resizedByModeTileWithName:(NSString *)name;
/**
 *  拉伸背景获得一张新的图片
 *
 *  @param name         图片名称
 *  @param leftMultiple 左侧开始位置倍率（0~1）
 *  @param topMultiple  顶部开始位置倍率（0~1）
 *
 *  @return 拉伸后的图片
 */
+ (instancetype)resizedImageWithName:(NSString *)name leftWidthMultiple:(CGFloat)leftMultiple topCapHeightMultiple:(CGFloat)topMultiple;
/**
 *  创建一个指定大小的图片(等比例)
 *
 *  注意：一般用于缩略图
 *
 *  @param size 图片尺寸
 *
 *  @return 重置大小后的图片
 */
- (instancetype)resizedImageImageInAspectFitWithSize:(CGSize)size;
/**
 *  创建一个指定大小的图片（非等比例）
 *
 *  注意：一般用于缩略图
 *
 *  @param size 图片尺寸
 *
 *  @return 重置大小后的图片
 */
- (instancetype)resizedImageImageSize:(CGSize)size;

/**
 *  根据颜色返回图片
 *
 *  @param color 图片颜色
 *  @param size  图片大小
 *
 *  @return 返回指定颜色和大小的图片
 */
+ (instancetype)imageWithColor:(UIColor *)color imageSize:(CGSize)size;

/**
 *  根据颜色返回指定的大小的图片
 *
 *  @param color 图片颜色
 *
 *  @return 返回指定颜色1个点的图片
 */
+ (instancetype)imageWithColor:(UIColor *)color;

/**
 *  根据指定大小裁剪图片
 *
 *  @param image   原图
 *  @param clipSize 裁剪尺寸
 *
 *  @return 返回裁剪后的图片
 */
+ (instancetype)clipImageWithOriginalImage:(UIImage *)image scaledToSize:(CGSize)clipSize;
/**
 *  裁剪图片为圆形
 */
- (UIImage *)circleImage;
/**
 *  图片旋转
 */
- (UIImage *)imageWithRotation:(UIImageOrientation)orientation;

/**
 *  图片模糊处理
 */
- (instancetype)blurImageWithBlurRadius:(CGFloat)blurRadius;
/**
 *  图片颜色渲染
 */
-  (UIImage*)drawImageWithColor:(UIColor *)aColor;
/**
 *  加载gif图片
 */
+ (UIImage *)gifWithData:(NSData *)imageData;
/**
 *  图片颜色渲染
 */
-  (instancetype)renderWithColor:(UIColor *)color;
/**
 *  压缩到指定字节（最大压缩到0.01）
 */
- (instancetype)compressedToSize:(CGFloat)someKb;
/**
 *  压缩到指定字节（最大压缩到0.01）
 */
- (NSData *)dataWithCompressedSize:(CGFloat)someKb;

/**
 *  压缩到指定字节
 */
- (instancetype)compressedToByte:(NSUInteger)maxLength;
/**
 *  压缩到指定字节
 */
- (NSData *)dataCompressedToByte:(NSUInteger)maxLength;

@end
