//
//  CYTAssetModel.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/7/14.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTAssetModel.h"
#import <Photos/PHObject.h>

@implementation CYTAssetModel

- (instancetype)init{
    if (self = [super init]) {
        _albumModels = [NSMutableArray array];
        _assets = [NSMutableArray array];
    }
    return self;
}

- (void)setAssetCollection:(PHAssetCollection *)assetCollection{
    _assetCollection = assetCollection;
    self.albumsTitle = assetCollection.localizedTitle;
}


@end
