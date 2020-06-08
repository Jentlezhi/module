//
//  CYTImageHandelTool.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/9/20.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CYTSelectImageModel.h"

@interface CYTImageHandelTool : NSObject

+ (void)handelImageWithImageModels:(NSArray<CYTSelectImageModel *> *)imageModels complation:(void(^)(NSArray *imageDatas))complation;

@end
