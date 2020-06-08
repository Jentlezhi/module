//
//  CYTImageHandelTool.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/9/20.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTImageHandelTool.h"
#import "CYTImageAssetManager.h"

@implementation CYTImageHandelTool

+ (void)handelImageWithImageModels:(NSArray<CYTSelectImageModel *> *)imageModels complation:(void(^)(NSArray *imageDatas))complation{
    NSMutableArray *images = [NSMutableArray array];
    NSMutableArray *imageDatas = [NSMutableArray array];
    NSMutableArray *controlCallBackTime = [NSMutableArray array];//防止回调两次
    [imageModels enumerateObjectsUsingBlock:^(CYTSelectImageModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [images addObject:[NSNull null]];
        [imageDatas addObject:[NSNull null]];
        [controlCallBackTime addObject:[NSNull null]];
    }];
    
    dispatch_group_t group = dispatch_group_create();
    for (NSInteger index = 0; index < imageModels.count; index++) {
        [CYTImageAssetManager sharedAssetManager].imageQuality = 1.0f;
        [CYTImageAssetManager sharedAssetManager].imageQualityConfig = 1.0f;
        CYTSelectImageModel *imageModel = imageModels[index];
        imageModel.ID = index;
        if (imageModel.image) {//拍照照片
            dispatch_group_enter(group);
            NSData *imageData = [imageModel.image dataWithCompressedSize:kImageCompressedMaxSize];
            imageData.ID = index;
            [imageDatas replaceObjectAtIndex:index withObject:imageData];
            dispatch_group_leave(group);
        }else if (imageModel.fileID.length && imageModel.fileID){//已上传的修改
            dispatch_group_enter(group);
            NSString *str = [NSString stringWithFormat:@"%ld",index];
            NSData *tempData = [str dataUsingEncoding:NSUTF8StringEncoding];
            tempData.fileID = imageModel.fileID;
            tempData.ID = index;
            [imageDatas replaceObjectAtIndex:index withObject:tempData];
            dispatch_group_leave(group);
        }else{//系统相册
            dispatch_group_enter(group);
            [[CYTImageAssetManager sharedAssetManager] fetchUploadImageWithAsset:imageModel.asset ID:imageModel.ID completion:^(UIImage *result, NSDictionary *info) {
                UIImage *image = [result compressedToSize:kImageCompressedMaxSize];
                if ([[controlCallBackTime objectAtIndex:index] isKindOfClass:[NSNumber class]]) return;
                if (image) {
                    @synchronized(image){
                        [images replaceObjectAtIndex:index withObject:image];}
                }
                NSData *imageData = [result dataWithCompressedSize:kImageCompressedMaxSize];
                imageData.ID = result.ID;
                if (imageData) {
                    @synchronized(imageDatas){
                        if ([[imageDatas objectAtIndex:index] isKindOfClass:[NSNull class]]) {
                            [imageDatas replaceObjectAtIndex:index withObject:imageData];
                            dispatch_group_leave(group);}
                    }
                }else{
                    [imageDatas replaceObjectAtIndex:index withObject:[NSNull class]];
                    dispatch_group_leave(group);
                }
                [controlCallBackTime replaceObjectAtIndex:index withObject:[NSNumber numberWithBool:YES]];
            }];
            
        }
    }
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        __block BOOL imagesSizeCorrect = YES;
        [imageDatas enumerateObjectsUsingBlock:^(NSData  *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CGFloat dataSize = obj.length/1024.0/1024.f;
            if (dataSize>= 4.0f) {
                NSString *tip = [NSString stringWithFormat:@"第%ld张图超过最大文件限制",idx+1];
                [CYTLoadingView hideLoadingView];
                [CYTToast errorToastWithMessage:tip];
                *stop = true;
                imagesSizeCorrect = NO;
                return;
            }
        }];
        if (imagesSizeCorrect) {
            !complation?:complation(imageDatas);
        }
    });
    
}

@end

