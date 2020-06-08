//
//  CYTPhotoSelectTool.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/5/3.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTPhotoSelectTool.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "CYTPhotoPreviewView.h"
#import "CYTIndicatorView.h"

static CYTPhotoSelectTool *photoSelectTool = nil;

@interface CYTPhotoSelectTool()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

/** 图片样式 */
@property(assign, nonatomic) CYTImageMode imageMode;

/** 预览 */
@property(strong, nonatomic) CYTPhotoPreviewView *photoPreviewView;

/** 是否使用相机 */
@property(assign, nonatomic,getter=isUseCarmera) BOOL useCarmera;

@end

@implementation CYTPhotoSelectTool

- (void)dealloc {
    CYTLog(@"CYTPhotoSelectTool dealloc-----");
}

- (CYTPhotoPreviewView *)photoPreviewView{
    if (!_photoPreviewView) {
        _photoPreviewView = [[CYTPhotoPreviewView alloc] init];
        _photoPreviewView.frame = [UIScreen mainScreen].bounds;
    }
    return _photoPreviewView;
}

+ (void)photoSelectToolWithImageMode:(CYTImageMode)imageMode image:(void(^)(UIImage *selectedImage))imageBlock{
    [kWindow endEditing:YES];
    CYTWeakSelf
    photoSelectTool = [[CYTPhotoSelectTool alloc] init];
    photoSelectTool.imageMode = imageMode;
    [CYTAlertView selectPhotoAlertWithTakePhoto:^(UIAlertAction * _Nullable action) {
        [weakSelf determineAVAuthorizationStatusForCamera];
    } album:^(UIAlertAction * _Nullable action) {
        [weakSelf determineAVAuthorizationStatusForAlbums];
    }];
    photoSelectTool.imageBack = ^(UIImage *image){
        !imageBlock?:imageBlock(image);
        photoSelectTool = nil;
    };
}

+ (void)determineAVAuthorizationStatusForCamera{
    //判断是否授权
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    switch (status) {
        case AVAuthorizationStatusNotDetermined:{
            // 许可对话没有出现，发起授权许可
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    //第一次用户接受
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self turnOnCarmera];
                    });
                }
            }];
            break;
        }
        case AVAuthorizationStatusAuthorized:{
            // 已经开启授权，可继续
            [self turnOnCarmera];
            break;
        }
        case AVAuthorizationStatusDenied:
        case AVAuthorizationStatusRestricted:
            // 用户明确地拒绝授权，或者相机设备无法访问
            [CYTAlertView alertTipWithTitle:@"提示" message:@"没有权限访问您的相机，请前往设置允许该应用访问相机。" confiemAction:nil];
            break;
        default:
            break;
    }
}

+ (void)determineAVAuthorizationStatusForAlbums{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        ALAuthorizationStatus authStatus = [ALAssetsLibrary authorizationStatus];
        if (authStatus == ALAuthorizationStatusDenied) {
            [CYTAlertView alertTipWithTitle:@"提示" message:@"没有权限访问您的相册，请前往设置允许该应用访问相册。" confiemAction:nil];
            return;
        }else{
            [self openAlbums];
        }
    }else{
        [self openAlbums];
    }
}

/**
 *  打开相机
 */
+ (void)turnOnCarmera{
    //记录
    photoSelectTool.useCarmera = YES;
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
        UIImagePickerController *carmeraIpc = [[UIImagePickerController alloc] init];
        carmeraIpc.delegate = photoSelectTool;
        carmeraIpc.sourceType = sourceType;
        if (photoSelectTool.imageMode == CYTImageModeAllowsEditing) {
            carmeraIpc.allowsEditing = YES;
        }
        [[CYTCommonTool currentViewController] presentViewController:carmeraIpc animated:YES completion:nil];
    }
    
}
/**
 *  打开相册
 */
+ (void)openAlbums{
    UIImagePickerController *albumsIpc = [[UIImagePickerController alloc] init];
    albumsIpc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    albumsIpc.delegate = photoSelectTool;
    if (photoSelectTool.imageMode == CYTImageModeAllowsEditing) {
        albumsIpc.allowsEditing = YES;
    }
    [[CYTCommonTool currentViewController] presentViewController:albumsIpc animated:YES completion:nil];
}

#pragma mark - <UIImagePickerControllerDelegate>
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    @weakify(self);
    __block UIImage *selectedImage = nil;
    [[CYTCommonTool currentViewController] dismissViewControllerAnimated:NO completion:^{
        @strongify(self);
        dispatch_async(dispatch_get_main_queue(), ^{
            if (photoSelectTool.imageMode == CYTImageModePreview) {
                selectedImage = info[UIImagePickerControllerOriginalImage];
                
                if (photoSelectTool.isUseCarmera) {
                    //相机拍照
                    //处理拍照时图片方向问题
                    selectedImage = [selectedImage fixOrientation];
                    !self.imageBack?:self.imageBack(selectedImage);
                }else{
                    //相簿选择
                    [kWindow addSubview:photoSelectTool.photoPreviewView];
                    [self addShowAnimationWithView:photoSelectTool.photoPreviewView];
                    selectedImage = [selectedImage fixOrientation];
                    photoSelectTool.photoPreviewView.selectedImage = selectedImage;
                    @weakify(self);
                    photoSelectTool.photoPreviewView.selectedBtnClick = ^(UIImage *selectedImage){
                        @strongify(self);
                        !self.imageBack?:self.imageBack(selectedImage);
                    };
                    
                }
            }else{
                selectedImage = info[UIImagePickerControllerEditedImage];
                selectedImage = [selectedImage fixOrientation];
                !self.imageBack?:self.imageBack(selectedImage);
            }
        });
    }];
}

/**
 *  显示动画
 */
- (void)addShowAnimationWithView:(UIView *)view{
    view.transform = CGAffineTransformMakeScale(0.4f, 0.4f);
    [UIView beginAnimations:nil context:UIGraphicsGetCurrentContext()];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.35f];
    view.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
    [UIView commitAnimations];
}


@end
