//
//  CYTImagePickerNavController.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/7/17.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTNavigationController.h"

@class CYTAlbumModel;

@interface CYTImagePickerNavController : CYTNavigationController
/** 完成 */
@property(copy, nonatomic) void(^completeAction)(NSArray <CYTAlbumModel*>*albumModels);

+ (instancetype)pickerNavControllerWithMaxSelectNum:(NSUInteger)maxSelectNum eachLineNum:(NSInteger)eachLineNum;

@end
