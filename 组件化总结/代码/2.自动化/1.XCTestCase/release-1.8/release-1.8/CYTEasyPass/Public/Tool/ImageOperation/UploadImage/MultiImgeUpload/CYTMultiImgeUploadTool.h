//
//  CYTMultiImgeUploadTool.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/9/19.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYTMultiImgeUploadTool : NSObject

- (void)uploadImagesWithImageDatas:(NSArray <NSData*>*)imageDatas completion:(void(^)(NSArray<NSString *>*imageFileIds))completion;

@end
