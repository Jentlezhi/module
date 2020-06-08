//
//  CYTPrestrainManager.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/3/15.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTExtendViewModel.h"
///预加载类
@interface CYTPrestrainManager : CYTExtendViewModel
///预加载app数据
- (void)prestrainAppData;
///更新cookie和认证数据
- (void)updateTokenAndAuthInfo;
///生成多账号本地文件夹,应用启动时候就会创建
- (void)genUserFolder;

@end
