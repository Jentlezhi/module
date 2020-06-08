//
//  CYTImageVouchersModel.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/9/12.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYTImageVoucherModel : NSObject

/** 文件ID */
@property(copy, nonatomic) NSString *fileID;
/** 图片地址 */
@property(copy, nonatomic) NSString *url;
/** 图片缩略图地址 */
@property(copy, nonatomic) NSString *thumbnailUrl;

@end
