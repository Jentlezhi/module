//
//  CYTEasyPass
//
//  Created by Jentle on 2017/6/14.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTSeekCarDetailModel.h"
#import "CYTDealer.h"

@implementation CYTSeekCarDetailModel

+ (NSDictionary *)objectClassInDictionary{
    return @{@"dealer" : [CYTDealer class]};
}

@end
