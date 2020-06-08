//
//  CYTMultiImgeUploadTool.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/9/19.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTMultiImgeUploadTool.h"
#import "CYTBasicUploadImageTool.h"
#import "CYTUploadImageResult.h"

@interface CYTMultiImgeUploadTool()

/** 待上传图片数据 */
@property(strong, nonatomic) NSMutableArray <NSData*>*waitUploadDatas;
/** 上传失败图片数据 */
@property(strong, nonatomic) NSMutableArray <NSData*>*uploadFailDatas;
/** 图片上传成功后的图片fileId */
@property(strong, nonatomic) NSMutableArray <NSString*>*uploadSuccessFileIds;

@end

@implementation CYTMultiImgeUploadTool


#pragma mark - 懒加载

- (NSMutableArray<NSData *> *)uploadFailDatas{
    if (!_uploadFailDatas) {
        _uploadFailDatas = [NSMutableArray array];
    }
    return _uploadFailDatas;
}

- (NSMutableArray<NSData *> *)waitUploadDatas{
    if (!_waitUploadDatas) {
        _waitUploadDatas = [NSMutableArray array];
    }
    return _waitUploadDatas;
}

- (NSMutableArray<NSString *> *)uploadSuccessFileIds{
    if (!_uploadSuccessFileIds) {
        _uploadSuccessFileIds = [NSMutableArray array];
    }
    return _uploadSuccessFileIds;
}

- (void)uploadImagesWithImageDatas:(NSArray <NSData*>*)imageDatas completion:(void(^)(NSArray<NSString *>*imageFileIds))completion{
    dispatch_group_t group0 = dispatch_group_create();
    dispatch_group_enter(group0);
    [[CYTAccountManager sharedAccountManager] getTokenByRefreshTokenComplation:^(CYTUserKeyInfoModel *userKeyInfoModel) {
        if (userKeyInfoModel) {
            dispatch_group_leave(group0);
        }else{
            [CYTLoadingView hideLoadingView];
            [CYTToast errorToastWithMessage:userKeyInfoModel.message];
            return;
        }
    }];
    dispatch_group_notify(group0, dispatch_get_main_queue(), ^{
        CYTWeakSelf
        self.waitUploadDatas = imageDatas;
        [imageDatas enumerateObjectsUsingBlock:^(NSData * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [weakSelf.uploadSuccessFileIds addObject:[NSNull class]];
        }];
        dispatch_group_t group1 = dispatch_group_create();
        for (NSInteger index = 0; index < imageDatas.count; index++) {
            NSData *imageData = imageDatas[index];
            if (!imageData) continue;
            if (imageData.fileID)continue;
            dispatch_group_enter(group1);
            [CYTBasicUploadImageTool uploadWithImageData:imageData url:kURL.user_file_uploadImage parameters:nil filename:nil name:@"image" mimeType:nil success:^(id responseObject) {
                CYTUploadImageResult *result = [CYTUploadImageResult mj_objectWithKeyValues:responseObject];
                if (result.result) {
                    if ([weakSelf.uploadFailDatas containsObject:imageData]) {
                        [weakSelf.uploadFailDatas removeObject:imageData];
                    }
                    CYTImageFileModel *fileModel = [CYTImageFileModel mj_objectWithKeyValues:result.data];
                    imageData.fileID = fileModel.fileID;
                    dispatch_group_leave(group1);
                }else{
                    if (![weakSelf.uploadFailDatas containsObject:imageData]) {
                        [weakSelf.uploadFailDatas addObject:imageData];
                    }
                    dispatch_group_leave(group1);
                }
            } fail:^(NSError *error) {
                if (![weakSelf.uploadFailDatas containsObject:imageData]) {
                    [weakSelf.uploadFailDatas addObject:imageData];
                }
                dispatch_group_leave(group1);
            }];
        }
        
        dispatch_group_notify(group1, dispatch_get_main_queue(), ^{
            BOOL allUploadSuccess = !weakSelf.uploadFailDatas.count;
            if (allUploadSuccess) {
                [self.waitUploadDatas enumerateObjectsUsingBlock:^(NSData * _Nonnull imageData, NSUInteger idx, BOOL * _Nonnull stop) {
                    if(imageData.fileID){
                        [weakSelf.uploadSuccessFileIds replaceObjectAtIndex:idx withObject:imageData.fileID];
                    }
                }];
                !completion?:completion(weakSelf.uploadSuccessFileIds);
            }else{
               [self uploadImagesWithImageDatas:weakSelf.uploadSuccessFileIds completion:nil];
            }
        });
    });
}


@end
