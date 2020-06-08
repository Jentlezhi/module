//
//  CYTSeekCarResult.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/5/8.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTSeekCarResult.h"
#import "CYTSeekCarListsModel.h"

@implementation CYTSeekCarResult

+ (NSDictionary *)objectClassInDictionary{
    return @{@"data" : [CYTSeekCarListsModel class]};
}

@end
