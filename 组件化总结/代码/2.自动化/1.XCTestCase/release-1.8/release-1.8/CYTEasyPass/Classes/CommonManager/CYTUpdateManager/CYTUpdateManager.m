//
//  CYTUpdateManager.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/5/5.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTUpdateManager.h"
#import "CYTUpdateView.h"

@implementation CYTUpdateManager
+ (void)update {
    [CYTNetworkManager GET:kURL.app_checkUpdate parameters:nil dataTask:nil showErrorTost:NO completion:^(CYTNetworkResponse *responseObject) {
        if (responseObject.resultEffective) {
            CYTUpdateModel *model = [CYTUpdateModel mj_objectWithKeyValues:responseObject.dataDictionary];
            CYTUpdateManager *manager = [CYTUpdateManager new];
            manager.updateModel = model;
            CYTUpdateView *updateView = [[CYTUpdateView alloc] initWithViewModel:manager];
            [updateView setUpdateBlock:^(BOOL update) {
                if (update) {
                    //点击了更新
                    [self goToHtml:model.updateUrl];
                    [MobClick event:@"GX_QD"];
                }else {
                    //点击取消
                    [MobClick event:@"GX_QX"];
                }
            }];
            [updateView ff_showSupernatantView];
        }
    }];
}

+ (void)goToHtml:(NSString *)url {
    NSURL *htmlURL = [NSURL URLWithString:url];
    if ([[UIApplication sharedApplication] canOpenURL:htmlURL]) {
        [[UIApplication sharedApplication] openURL:htmlURL];
    }
}

@end
