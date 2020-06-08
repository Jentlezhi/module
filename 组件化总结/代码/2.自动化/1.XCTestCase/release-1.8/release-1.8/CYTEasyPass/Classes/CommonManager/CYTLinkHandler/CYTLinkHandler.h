//
//  CYTEasyPass
//
//  Created by xujunquan on 17/7/18.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTExtendViewModel.h"
#import "CYTMessageCenterURLModel.h"

@interface CYTLinkHandler : CYTExtendViewModel
///app内部跳转处理(能处理返回yes，否则no)
- (BOOL)handleAPPInnerLinkWithURL:(NSString *)urlString;
- (NSArray *)getURLParamerers;
- (NSString *)getURLParametersWithIndex:(NSInteger)index;

@end
