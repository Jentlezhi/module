//
//  CYTBasicUploadImageTool.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/9/19.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTBasicUploadImageTool.h"

static const NSTimeInterval timeoutInterval = 15.f;

@implementation CYTBasicUploadImageTool

/**
 *  上传图片文件
 */
+ (void)uploadWithImage:(UIImage *)image url:(NSString *)url parameters:(NSDictionary *)parameters filename:(NSString *)filename name:(NSString *)name mimeType:(NSString *)mimeType success:(void(^)(id responseObject))success fail:(void (^)(NSError *error))fail{
    NSData *imageData = UIImageJPEGRepresentation(image, 0.8);
    if (!imageData || ![imageData isKindOfClass:[NSData class]]) return;
    [self uploadWithImageData:imageData url:url parameters:parameters filename:filename name:name mimeType:mimeType success:success fail:fail];
    
}
/**
 *  上传图片二进制数据
 */
+ (void)uploadWithImageData:(NSData *)imageData url:(NSString *)url parameters:(NSDictionary *)parameters filename:(NSString *)filename name:(NSString *)name mimeType:(NSString *)mimeType success:(void(^)(id responseObject))success fail:(void (^)(NSError *error))fail{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [self uploadImageToolBasicConfigWithManager:manager];
    [manager POST:[url replaceBlank] parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (![imageData isKindOfClass:[NSData class]]) return;
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        NSString *aMimeType = mimeType;
        NSString *aFilename = filename;
        if (aFilename == nil || ![aFilename isKindOfClass:[NSString class]] || aFilename.length == 0) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            aFilename = [NSString stringWithFormat:@"%@.JPEG",str];
        }
        if (!aMimeType) {
            aMimeType = @"image/jpeg";
        }
        [formData appendPartWithFileData:imageData name:name fileName:aFilename mimeType:aMimeType];
    } progress:^(NSProgress * _Nonnull uploadProgress) {} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        if (fail) {
            fail(error);
        }
    }];
}


/**
 * 图片上传基本配置
 */
+ (void)uploadImageToolBasicConfigWithManager:(AFHTTPSessionManager *)manager{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/plain", @"text/html",@"multipart/form-data", nil];
    manager.requestSerializer.timeoutInterval = timeoutInterval;
    //设置header
    NSArray *filedKeys = [CYTTools headFiledDictionary].allKeys;
    if (filedKeys.count>0) {
        for (int i=0; i<filedKeys.count; i++) {
            NSString *key = filedKeys[i];
            NSString *value = [[CYTTools headFiledDictionary] objectForKey:key];
            [manager.requestSerializer setValue:value forHTTPHeaderField:key];
        }
    }
}


@end
