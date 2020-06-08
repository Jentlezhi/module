//
//  CYTImagePickerNavController.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/7/17.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTImagePickerNavController.h"
#import "CYTImagePickerViewController.h"
#import "CYTAlbumsListViewController.h"
#import "CYTImageAssetManager.h"
#import "CYTAlbumModel.h"
#import "CYTSelectedArrayModel.h"

@interface CYTImagePickerNavController ()

/** 图片资源管理 */
@property(strong, nonatomic) CYTImageAssetManager *imageAssetManager;

@end

@implementation CYTImagePickerNavController

+ (instancetype)pickerNavControllerWithMaxSelectNum:(NSUInteger)maxSelectNum eachLineNum:(NSInteger)eachLineNum{
    CYTImagePickerNavController *imagePickerNavController = [[CYTImagePickerNavController alloc] init];
    [imagePickerNavController imagePickerNavBasicConfigWithMaxSelectNum:maxSelectNum eachLineNum:eachLineNum];
    return imagePickerNavController;
}
#pragma mark - 基本设置
/**
 *  基本配置
 */
- (void)imagePickerNavBasicConfigWithMaxSelectNum:(NSUInteger)maxSelectNum eachLineNum:(NSInteger)eachLineNum{
    BOOL authorized = [[CYTImageAssetManager sharedAssetManager] authorizationStatusAuthorized];
    if (authorized) {
        CYTAlbumsListViewController *albumsListViewController = [[CYTAlbumsListViewController alloc] init];
        albumsListViewController.selectedMaxNum = maxSelectNum;
        CYTWeakSelf
        albumsListViewController.completeAction = ^(NSArray<CYTAlbumModel *> *albumModels) {
            !weakSelf.completeAction?:weakSelf.completeAction(albumModels);
        };
        CYTImagePickerViewController *imagePickerViewController = [self configImagePickerViewControllerWithMaxSelectNum:maxSelectNum eachLineNum:eachLineNum];
        self.viewControllers = @[albumsListViewController,imagePickerViewController];
    }else{
        CYTAlbumsListViewController *albumsListViewController = [[CYTAlbumsListViewController alloc] init];
        CYTWeakSelf
        albumsListViewController.completeAction = ^(NSArray<CYTAlbumModel *> *albumModels) {
            !weakSelf.completeAction?:weakSelf.completeAction(albumModels);
        };
        albumsListViewController.selectedMaxNum = maxSelectNum;
        self.viewControllers = @[albumsListViewController];
    }
    if (authorized) return;
    
    [CYTImageAssetManager authorizationStatusWithDenied:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [CYTAlertView alertTipWithTitle:@"提示" message:@"没有权限访问您的相册，请前往设置允许该应用访问相册。" confiemAction:^(UIAlertAction *action) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }];
        });
    } authorized:^{
        CYTWeakSelf
        dispatch_async(dispatch_get_main_queue(), ^{
            CYTImagePickerViewController *imagePickerViewController = [self configImagePickerViewControllerWithMaxSelectNum:maxSelectNum eachLineNum:eachLineNum];
            [weakSelf pushViewController:imagePickerViewController animated:YES];
        });

    }];
}
/**
 *  配置图片选择控制器
 */
- (CYTImagePickerViewController *)configImagePickerViewControllerWithMaxSelectNum:(NSUInteger)maxSelectNum eachLineNum:(NSInteger)eachLineNum{
    CYTWeakSelf
    CYTImagePickerViewController *imagePickerViewController = [[CYTImagePickerViewController alloc] init];
    imagePickerViewController.selectedMaxNum = maxSelectNum;
    imagePickerViewController.eachLineNum = eachLineNum;
    imagePickerViewController.completeAction = ^(NSArray<CYTAlbumModel *> *albumModels) {
        !weakSelf.completeAction?:weakSelf.completeAction(albumModels);
    };
    return imagePickerViewController;
}

#pragma mark - 懒加载

- (CYTImageAssetManager *)imageAssetManager{
    if (!_imageAssetManager) {
        _imageAssetManager = [CYTImageAssetManager sharedAssetManager];
    }
    return _imageAssetManager;
}

@end
