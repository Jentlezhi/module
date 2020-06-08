//
//  CYTSignalImageUploadTool.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/9/19.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTSignalImageUploadTool.h"
#import "CYTBasicUploadImageTool.h"

@implementation CYTSignalImageUploadTool

+ (void)uploadWithImage:(UIImage *)image parameters:(NSDictionary *)parameters url:(NSString *)urlString success:(void(^)(CYTUploadImageResult *result))success fail:(void (^)(NSError *error))failure{
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    [[CYTAccountManager sharedAccountManager] getTokenByRefreshTokenComplation:^(CYTUserKeyInfoModel *userKeyInfoModel) {
        dispatch_group_leave(group);
    }];
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        [CYTBasicUploadImageTool uploadWithImage:image url:urlString parameters:parameters filename:nil name:@"image" mimeType:nil success:^(id responseObject) {
            [CYTLoadingView hideLoadingView];
            CYTUploadImageResult *result = [CYTUploadImageResult mj_objectWithKeyValues:responseObject];
            if (result.result) {
                [CYTToast successToastWithMessage:result.message];
            }else{
                [CYTToast errorToastWithMessage:result.message];
            }
            if (success) {
                success(result);
            }
        } fail:^(NSError *error) {
            [CYTLoadingView hideLoadingView];
            [CYTToast errorToastWithMessage:CYTNetworkError];
            if (failure) {
                failure(error);
            }
        }];
    });
}

@end
