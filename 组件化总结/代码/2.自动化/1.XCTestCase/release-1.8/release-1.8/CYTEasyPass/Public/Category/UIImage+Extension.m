//
//  UIImage+Extension.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/1.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "UIImage+Extension.h"
#import <ImageIO/ImageIO.h>

static const char *fileIDKey = "fileIDKey";
static const char *IDKey = "IDKey";


@implementation UIImage (Extension)

- (void)setFileID:(NSString *)fileID{
    objc_setAssociatedObject(self, fileIDKey, fileID, OBJC_ASSOCIATION_RETAIN);
}

- (NSString *)fileID{
    return objc_getAssociatedObject(self, fileIDKey);
}

- (void)setID:(NSInteger)ID{
    objc_setAssociatedObject(self, IDKey, [NSNumber numberWithInteger:ID], OBJC_ASSOCIATION_RETAIN);
}

- (NSInteger)ID{
    return [objc_getAssociatedObject(self, IDKey) integerValue];
}


+ (instancetype)resizedImageWithName:(NSString *)name {
    return [self resizedImageWithName:name leftWidthMultiple:0.5 topCapHeightMultiple:0.5];
}

+ (instancetype)resizedByModeTileWithName:(NSString *)name {
    UIImage *image = [UIImage imageNamed:name];
    CGFloat imgW = image.size.width * 0.3;
    CGFloat imgH = image.size.height * 0.3;
    UIEdgeInsets edge = UIEdgeInsetsMake(imgH, imgW, imgH, imgW);
    return [image resizableImageWithCapInsets:edge resizingMode:UIImageResizingModeTile];
}

+ (instancetype)resizedImageWithName:(NSString *)name leftWidthMultiple:(CGFloat)leftMultiple topCapHeightMultiple:(CGFloat)topMultiple {
    UIImage *image = [UIImage imageNamed:name];
    CGSize size = image.size;
    return [image stretchableImageWithLeftCapWidth:size.width * leftMultiple topCapHeight:size.height * topMultiple];
}

- (instancetype)resizedImageImageInAspectFitWithSize:(CGSize)size {
    UIImage *newimage;
    CGSize oldsize = self.size;
    CGRect rect;
    if (size.width / size.height > oldsize.width / oldsize.height) {
        rect.size.width = size.height * oldsize.width / oldsize.height;
        rect.size.height = size.height;
        rect.origin.x = (size.width - rect.size.width) / 2;
        rect.origin.y = 0;
    } else {
        rect.size.width = size.width;
        rect.size.height = size.width * oldsize.height / oldsize.width;
        rect.origin.x = 0;
        rect.origin.y = (size.height - rect.size.height) / 2;
    }
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
    UIRectFill(CGRectMake(0, 0, size.width, size.height)); //clear background
    [self drawInRect:rect];
    newimage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newimage;
}

- (instancetype)resizedImageImageSize:(CGSize)size {
    UIImage *newimage;
    UIGraphicsBeginImageContext(size);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    newimage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newimage;
}

#pragma mark - 根据指定颜色及大小返回图片
+ (instancetype)imageWithColor:(UIColor *)color imageSize:(CGSize)size {
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (instancetype)imageWithColor:(UIColor *)color {
    return [self imageWithColor:color imageSize:CGSizeMake(1.0f, 1.0f)];
}

+ (instancetype)clipImageWithOriginalImage:(UIImage *)image scaledToSize:(CGSize)clipSize
{
    clipSize.height = image.size.height*(clipSize.width/image.size.width);
    UIGraphicsBeginImageContext(clipSize);
    [image drawInRect:CGRectMake(0, 0, clipSize.width, clipSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (UIImage *)circleImage {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctx, rect);
    CGContextClip(ctx);
    [self drawInRect:rect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)imageWithRotation:(UIImageOrientation)orientation{
    long double rotate = 0.0;
    CGRect rect;
    float translateX = 0;
    float translateY = 0;
    float scaleX = 1.0;
    float scaleY = 1.0;
    
    switch (orientation) {
        case UIImageOrientationLeft:
            rotate = M_PI_2;
            rect = CGRectMake(0, 0, self.size.height, self.size.width);
            translateX = 0;
            translateY = -rect.size.width;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationRight:
            rotate = 3 * M_PI_2;
            rect = CGRectMake(0, 0, self.size.height, self.size.width);
            translateX = -rect.size.height;
            translateY = 0;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationDown:
            rotate = M_PI;
            rect = CGRectMake(0, 0, self.size.width, self.size.height);
            translateX = -rect.size.width;
            translateY = -rect.size.height;
            break;
        default:
            rotate = 0.0;
            rect = CGRectMake(0, 0, self.size.width, self.size.height);
            translateX = 0;
            translateY = 0;
            break;
    }
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //做CTM变换
    CGContextTranslateCTM(context, 0.0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextRotateCTM(context, rotate);
    CGContextTranslateCTM(context, translateX, translateY);
    
    CGContextScaleCTM(context, scaleX, scaleY);
    //绘制图片
    CGContextDrawImage(context, CGRectMake(0, 0, rect.size.width, rect.size.height), self.CGImage);
    
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    return newPic;
}

/**
 *  图片模糊处理
 */
- (instancetype)blurImageWithBlurRadius:(CGFloat)blurRadius{
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *ciImage = [CIImage imageWithCGImage:self.CGImage];
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:ciImage forKey:kCIInputImageKey];

    [filter setValue:[NSNumber numberWithFloat:blurRadius] forKey:@"inputRadius"];
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    CGImageRef outImage = [context createCGImage: result fromRect:ciImage.extent];
    return [UIImage imageWithCGImage:outImage];
}

-  (UIImage*)drawImageWithColor:(UIColor *)aColor {
    CGRect rect = CGRectMake(0.0f, 0.0f, self.size.width, self.size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, self.scale);
    CGContextRef c = UIGraphicsGetCurrentContext();
    [self drawInRect:rect];
    CGContextSetFillColorWithColor(c, [aColor CGColor]);
    CGContextSetBlendMode(c, kCGBlendModeSourceAtop);
    CGContextFillRect(c, rect);
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return tintedImage;
}

+ (UIImage *)gifWithData:(NSData *)imageData{
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)imageData, NULL);
    size_t count = CGImageSourceGetCount(source);
    UIImage *animatedImage;
    if (count <= 1) {
        animatedImage = [[UIImage alloc] initWithData:imageData];
    }else {
        NSMutableArray *images = [NSMutableArray array];
        NSTimeInterval duration = 0.0f;
        for (size_t i = 0; i < count; i++) {
            CGImageRef image = CGImageSourceCreateImageAtIndex(source, i, NULL);
            if (!image) {
                continue;
            }
            duration += [self frameDurationAtIndex:i source:source];
            [images addObject:[UIImage imageWithCGImage:image scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp]];
            CGImageRelease(image);
        }
        if (!duration) {
            duration = (1.0f / 10.0f) * count;
        }
        animatedImage = [UIImage animatedImageWithImages:images duration:duration];
    }
    CFRelease(source);
    return animatedImage;

}

+ (float)frameDurationAtIndex:(NSUInteger)index source:(CGImageSourceRef)source {
    float frameDuration = 0.1f;
    CFDictionaryRef cfFrameProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil);
    NSDictionary *frameProperties = (__bridge NSDictionary *)cfFrameProperties;
    NSDictionary *gifProperties = frameProperties[(NSString *)kCGImagePropertyGIFDictionary];
    NSNumber *delayTimeUnclampedProp = gifProperties[(NSString *)kCGImagePropertyGIFUnclampedDelayTime];
    if (delayTimeUnclampedProp) {
        frameDuration = [delayTimeUnclampedProp floatValue];
    }else {
        NSNumber *delayTimeProp = gifProperties[(NSString *)kCGImagePropertyGIFDelayTime];
        if (delayTimeProp) {
            frameDuration = [delayTimeProp floatValue];
        }
    }
    if (frameDuration < 0.011f) {
        frameDuration = 0.100f;
    }
    CFRelease(cfFrameProperties);
    return frameDuration;
}
/**
 *  图片颜色渲染
 */
-  (instancetype)renderWithColor:(UIColor *)color{
    CGRect rect = CGRectMake(0.0f, 0.0f, self.size.width, self.size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, self.scale);
    CGContextRef c = UIGraphicsGetCurrentContext();
    [self drawInRect:rect];
    CGContextSetFillColorWithColor(c, [color CGColor]);
    CGContextSetBlendMode(c, kCGBlendModeSourceAtop);
    CGContextFillRect(c, rect);
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return tintedImage;
}
- (instancetype)compressedToSize:(CGFloat)someKb{
    if (someKb<kImageCompressedMaxSize) {
        return self;
    }
    
    someKb*=1024.0;
    CGFloat compression = 0.9f;
    CGFloat maxCompression = 0.01f;
    NSData *imageData = UIImageJPEGRepresentation(self, compression);
    
    while ([imageData length] > someKb && compression > maxCompression) {
        compression -= 0.1;
        imageData = UIImageJPEGRepresentation(self, compression);
    }
    
    return [UIImage imageWithData:imageData];
}

- (NSData *)dataWithCompressedSize:(CGFloat)someKb{
    someKb*=1024.0;
    CGFloat compression = 0.9f;
    CGFloat maxCompression = 0.01f;
    NSData *imageData = UIImageJPEGRepresentation(self, compression);
    while ([imageData length] > someKb && compression > maxCompression) {
        compression -= 0.1;
        imageData = UIImageJPEGRepresentation(self, compression);
    }
    return imageData;
}

- (NSData *)dataCompressedToByte:(NSUInteger)maxLength{
    UIImage *resultImage = [self compressedToByte:maxLength];
    return UIImageJPEGRepresentation(resultImage, 1.0f);
}

- (instancetype)compressedToByte:(NSUInteger)maxLength{
    CGFloat compression = 1.0f;
    NSData *data = UIImageJPEGRepresentation(self, compression);
    if (data.length < maxLength) return self;
    CGFloat max = 1.0f;
    CGFloat min = 0.f;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(self, compression);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    UIImage *resultImage = [UIImage imageWithData:data];
    if (data.length < maxLength) return resultImage;
    NSUInteger lastDataLength = 0;
    while (data.length > maxLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = maxLength*1.0 / data.length;
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio)));
        UIGraphicsBeginImageContext(size);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, compression);
    }
    return resultImage;
}


@end
