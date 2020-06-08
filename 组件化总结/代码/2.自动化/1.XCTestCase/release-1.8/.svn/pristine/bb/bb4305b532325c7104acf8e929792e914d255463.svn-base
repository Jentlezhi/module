//
//  CYTCarSourceListFrequentlyBrandVM.m
//  CYTEasyPass
//
//  Created by xujunquan on 2017/10/16.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCarSourceListFrequentlyBrandVM.h"

@interface CYTCarSourceListFrequentlyBrandVM ()

@end

@implementation CYTCarSourceListFrequentlyBrandVM

- (void)ff_initWithModel:(FFExtendModel *)model {
    self.brandList = [self getBrandFromLocal];
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:kUpdateFrequentlyBrandKey object:nil] subscribeNext:^(NSNotification *noti) {
        if (noti.object && [noti.object isKindOfClass:[CYTBrandSelectModel class]]) {
            [self updateBrandListWithModel:noti.object];
        }
    }];
}

- (NSMutableArray *)getBrandFromLocal {
    NSFileManager *manager = [NSFileManager defaultManager];
    
    if (![manager fileExistsAtPath:[self getFilePath]]) {
        //如果不存在则初始化原始数据
        NSArray *logoArray =    @[@"car_frequently_dz",@"car_frequently_bk",@"car_frequently_bm",@"car_frequently_ft",@"car_frequently_rc"];
        NSArray *nameArray =    @[@"大众",@"别克",@"宝马",@"福特",@"日产"];
        NSArray *idArray =      @[@"8",@"127",@"3",@"17",@"30"];
        
        NSMutableArray *brandList = [NSMutableArray array];
        for (int i=0; i<5; i++) {
            CYTBrandSelectModel *model = [CYTBrandSelectModel new];
            model.logoUrl = logoArray[i];
            model.masterBrandName = nameArray[i];
            model.masterBrandId = [idArray[i] integerValue];
            [brandList addObject:model];
        }
        
        //保存到本地
        [brandList writeToFile:[self getFilePath] atomically:YES];
        [self saveToLocalWithArray:brandList];
        return [brandList mutableCopy];
    }else {
        return [CYTBrandSelectModel mj_objectArrayWithFile:[self getFilePath]];
    }
}

- (void)updateBrandListWithModel:(CYTBrandSelectModel *)model {
    if (!model) {
        self.brandList = [self getBrandFromLocal];
        return;
    }
    CYTBrandSelectModel *theModel;
    NSMutableArray *brandList = [self getBrandFromLocal];
    
    for (int i=0; i<brandList.count; i++) {
        CYTBrandSelectModel *item = brandList[i];
        if ([item isEqual:model]) {
            //有相同的则删除
            theModel = item;
            break;
        }
    }
    
    if (theModel) {
        [brandList removeObject:theModel];
    }
    [brandList insertObject:model atIndex:0];
    brandList = [brandList subarrayWithRange:NSMakeRange(0, 5)];
    [self saveToLocalWithArray:brandList];
    //发消息
    self.brandList = [brandList mutableCopy];
    [self.refreshSubject sendNext:@"1"];
}

- (void)saveToLocalWithArray:(NSArray *)dataArray {
    if (!dataArray) {
        return;
    }
    NSArray *jsonArray = [CYTBrandSelectModel mj_keyValuesArrayWithObjectArray:dataArray];
    [jsonArray writeToFile:[self getFilePath] atomically:YES];
}

//区分账户
- (NSString *)getFilePath {
    NSString *path = [CYTTools filePath:kFrequentlyBrandPath bindUser:YES];
    CYTLog(@"path ======== %@",path);
    return path;
}

- (RACSubject *)refreshSubject {
    if (!_refreshSubject) {
        _refreshSubject = [RACSubject new];
    }
    return _refreshSubject;
}

@end
