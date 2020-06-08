//
//  CYTImageCompresser.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/10/28.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTImageCompresser.h"

@implementation CYTImageCompresser

+ (NSData *)compressDataWithImage:(UIImage *)image{
    UIImage *resultImage = [self compressDataWithImage:image];
    return UIImageJPEGRepresentation(resultImage, 1.0f);
    
}

+ (UIImage *)compressImage:(UIImage *)image{
    if (!image) return nil;
    double size;
    NSData *imageOriginData = UIImageJPEGRepresentation(image, 1);
    int fixelW = (int)image.size.width;
    int fixelH = (int)image.size.height;
    int thumbW = fixelW % 2  == 1 ? fixelW + 1 : fixelW;
    int thumbH = fixelH % 2  == 1 ? fixelH + 1 : fixelH;
    
    double scale = ((double)fixelW/fixelH);
    
    if (scale <= 1 && scale > 0.5625) {
        
        if (fixelH < 1664) {
            if (imageOriginData.length/1024.0 < 150) {
                return image;
            }
            size = (fixelW * fixelH) / pow(1664, 2) * 150;
            size = size < 60 ? 60 : size;
        }
        else if (fixelH >= 1664 && fixelH < 4990) {
            thumbW = fixelW / 2;
            thumbH = fixelH / 2;
            size   = (thumbH * thumbW) / pow(2495, 2) * 300;
            size = size < 60 ? 60 : size;
        }
        else if (fixelH >= 4990 && fixelH < 10240) {
            thumbW = fixelW / 4;
            thumbH = fixelH / 4;
            size = (thumbW * thumbH) / pow(2560, 2) * 300;
            size = size < 100 ? 100 : size;
        }
        else {
            int multiple = fixelH / 1280 == 0 ? 1 : fixelH / 1280;
            thumbW = fixelW / multiple;
            thumbH = fixelH / multiple;
            size = (thumbW * thumbH) / pow(2560, 2) * 300;
            size = size < 100 ? 100 : size;
        }
    }
    else if (scale <= 0.5625 && scale > 0.5) {
        
        if (fixelH < 1280 && imageOriginData.length/1024 < 200) {
            
            return image;
        }
        int multiple = fixelH / 1280 == 0 ? 1 : fixelH / 1280;
        thumbW = fixelW / multiple;
        thumbH = fixelH / multiple;
        size = (thumbW * thumbH) / (1440.0 * 2560.0) * 400;
        size = size < 100 ? 100 : size;
    }
    else {
        int multiple = (int)ceil(fixelH / (1280.0 / scale));
        thumbW = fixelW / multiple;
        thumbH = fixelH / multiple;
        size = ((thumbW * thumbH) / (1280.0 * (1280 / scale))) * 500;
        size = size < 100 ? 100 : size;
    }
    
    return [self compressWithImage:image thumbW:thumbW thumbH:thumbH size:size];
}
+ (UIImage *)compressWithImage:(UIImage *)image thumbW:(int)width thumbH:(int)height size:(double)size{
    
    UIImage *thumbImage = [image fixOrientation];
    thumbImage = [self resizeImage:image thumbWidth:width thumbHeight:height];
    
    int qualityCompress = 1.0;
    
    NSData *dataLen = UIImageJPEGRepresentation(thumbImage, qualityCompress);
    
    NSUInteger lenght = dataLen.length;
    while (lenght / 1024 > size && qualityCompress > 0.06) {
        
        qualityCompress -= 0.06;
        dataLen    = UIImageJPEGRepresentation(thumbImage, qualityCompress);
        lenght     = dataLen.length;
        thumbImage = [UIImage imageWithData:dataLen];
    }
    return thumbImage;
}

+ (UIImage *)resizeImage:(UIImage *)image thumbWidth:(int)width thumbHeight:(int)height{
    
    int outW = (int)image.size.width;
    int outH = (int)image.size.height;
    
    int inSampleSize = 1;
    
    if (outW > width || outH > height) {
        int halfW = outW / 2;
        int halfH = outH / 2;
        
        while ((halfH / inSampleSize) > height && (halfW / inSampleSize) > width) {
            inSampleSize *= 2;
        }
    }
    int heightRatio = (int)ceil(outH / (float) height);
    int widthRatio  = (int)ceil(outW / (float) width);
    
    if (heightRatio > 1 || widthRatio > 1) {
        
        inSampleSize = heightRatio > widthRatio ? heightRatio : widthRatio;
    }
    CGSize thumbSize = CGSizeMake((NSUInteger)((CGFloat)outW/widthRatio), (NSUInteger)((CGFloat)outH/heightRatio));
    
    UIGraphicsBeginImageContext(thumbSize);
    
    [image drawInRect:CGRectMake(0, 0, thumbSize.width, thumbSize.height)];
    
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resultImage;
}

@end
