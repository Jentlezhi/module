//
//  CYTAlbumModel.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/7/13.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTAlbumModel.h"
#import "CYTImageAssetManager.h"

@implementation CYTAlbumModel

- (instancetype)init{
    if (self = [super init]) {
        _showCoverView = YES;
    }
    return self;
}

- (CGSize)pixelSize{
    if (_pixelSize.width != 0 && _pixelSize.height != 0) return _pixelSize;
    return CGSizeMake(self.asset.pixelWidth, self.asset.pixelHeight);
}

- (CGSize)detailSize{
    if (_detailSize.width != 0 && _detailSize.height != 0) return _detailSize;
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height - CYTViewOriginY;
    CGFloat imgWidth = self.pixelSize.width;
    CGFloat imgHeight = self.pixelSize.height;
    CGFloat w = 0;
    CGFloat h = 0;
    imgHeight = width/imgWidth * imgHeight;
    if (imgHeight > height) {
        w = height / self.pixelSize.height * imgWidth;
        h = height;
    }else {
        w = width;
        h = imgHeight;
    }
    return CGSizeMake(w, h);
}

@end
