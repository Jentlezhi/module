//
//  CYTBrandSelectVM.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/8/14.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTBrandSelectVM.h"
#import "CYTBrandCacheVM.h"

@implementation CYTBrandSelectVM
@synthesize requestCommand = _requestCommand;

- (void)ff_initWithModel:(FFExtendModel *)model {
    [super ff_initWithModel:model];
    self.needBack = YES;
    self.brandResultModel = [CYTBrandSelectResultModel new];
    //获取品牌车系缓存数据
    self.brandCacheArray = [CYTBrandCacheVM shareManager].brandArray;
    self.groupNameArray = [CYTBrandCacheVM shareManager].groupNameArray;
}

- (void)handleSelectedBrand {
    if (self.selectedBrandModel) {
        //获取选中的品牌数据
        CYTBrandSelectModel *theBrand;
        NSIndexPath *indexPath;
        for (int i=0; i<self.brandCacheArray.count; i++) {
            CYTBrandGroupModel *group = self.brandCacheArray[i];
            NSArray *brands = group.masterBrands;
            for (int j=0; j<brands.count; j++) {
                CYTBrandSelectModel *brandModel = brands[j];
                if ([self.selectedBrandModel isEqual:brandModel]) {
                    theBrand = brandModel;
                    indexPath = [NSIndexPath indexPathForRow:j inSection:i];
                    break;
                }
            }
            
            if (theBrand) {
                break;
            }
        }

        if (theBrand) {
            //找到了改品牌
            self.selectedBrandModel = theBrand;
            [self.getSelectedBrandModelFinishedSubject sendNext:indexPath];
        }
    }
}

#pragma mark- get
- (RACSubject *)getSelectedBrandModelFinishedSubject {
    if (!_getSelectedBrandModelFinishedSubject) {
        _getSelectedBrandModelFinishedSubject = [RACSubject new];
    }
    return _getSelectedBrandModelFinishedSubject;
}

- (CYTBrandSelectResultModel *)brandResultModel {
    if (!_brandResultModel) {
        _brandResultModel = [CYTBrandSelectResultModel new];
    }
    return _brandResultModel;
}

@end
