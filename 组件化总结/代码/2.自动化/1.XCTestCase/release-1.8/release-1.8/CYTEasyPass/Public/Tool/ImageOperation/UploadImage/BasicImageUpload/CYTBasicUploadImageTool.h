//
//  CYTBasicUploadImageTool.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/9/19.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYTBasicUploadImageTool : NSObject

/**
 *  上传图片文件
 */
+ (void)uploadWithImage:(UIImage *)image url:(NSString *)url parameters:(NSDictionary *)parameters filename:(NSString *)filename name:(NSString *)name mimeType:(NSString *)mimeType success:(void(^)(id responseObject))success fail:(void (^)(NSError *error))fail;
/**
 *  上传图片二进制数据
 */
+ (void)uploadWithImageData:(NSData *)imageData url:(NSString *)url parameters:(NSDictionary *)parameters filename:(NSString *)filename name:(NSString *)name mimeType:(NSString *)mimeType success:(void(^)(id responseObject))success fail:(void (^)(NSError *error))fail;

@end
