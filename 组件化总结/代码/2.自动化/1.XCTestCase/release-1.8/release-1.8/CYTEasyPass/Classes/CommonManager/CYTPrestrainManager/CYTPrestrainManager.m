//
//  CYTPrestrainManager.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/3/15.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTPrestrainManager.h"
#import "CYTAddressDataWNCManager.h"
#import "CYTBrandCacheVM.h"

@interface CYTPrestrainManager()

@end

@implementation CYTPrestrainManager

- (instancetype)init {
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTokenAndAuthInfo) name:kloginSucceedKey object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTokenAndAuthInfo) name:kResiterSuccessKey object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTokenAndAuthInfo) name:kResetPwdSucceedKey object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateH5Token) name:kTokenRefreshedKey object:nil];
    }
    return self;
}

- (void)updateTokenAndAuthInfo {
    [self updateAuthInfo];
    [self updateH5Token];
    [self genUserFolder];
    //登录成功删除未登录用户数据
    [self deleteUnloginData];
}

- (void)updateAuthInfo {
    if ([CYTAuthManager manager].isLogin) {
        //更新认证数据
        [[CYTAuthManager manager] getUserDealerInfoFromLocal:NO result:^(CYTUserInfoModel *model) {
            
        }];
    }
}

- (void)updateH5Token {
    //处理h5
    [CYTH5WithInteractiveCtr cleanCacheAndCookie];
    
    if ([CYTAuthManager manager].isLogin) {
        //增加cookie
        [CYTH5WithInteractiveCtr addCookie];
    }
}

///预加载app数据
- (void)prestrainAppData {
    //创建用户数据目录
    [self genUserFolder];
    //请求三级地址
    [[CYTAddressDataWNCManager shareManager].requestCommand execute:nil];
    //请求品牌车系数据
    [[CYTBrandCacheVM shareManager].requestCommand execute:nil];
}

#pragma mark- method
///登录后删除未登录时候保存的数据
- (void)deleteUnloginData {
    //此处数据区分账号,修改要慎重！！！！
    NSString *path = [CYTTools unloginRootPath];
    
    //1、删除常用品牌数据
    NSString *brandFrequentlyPath = [NSString stringWithFormat:@"%@/%@",path,kFrequentlyBrandPath];
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:brandFrequentlyPath]) {
        [manager removeItemAtPath:brandFrequentlyPath error:nil];
    }
}

- (void)genUserFolder {
    NSString *path = [CYTTools fileRootPathBindUser:YES];
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:path]) {
        [manager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
}

@end
