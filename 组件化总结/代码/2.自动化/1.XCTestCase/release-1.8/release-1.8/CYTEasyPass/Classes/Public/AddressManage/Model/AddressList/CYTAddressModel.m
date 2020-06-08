//
//  CYTAddressModel.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/5/16.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTAddressModel.h"

@implementation CYTAddressModel

- (NSString *)customDetailAddress{
    NSString *cProvinceName = self.provinceName.length?self.provinceName:@"";
    NSString *cCityName = self.cityName.length?[NSString stringWithFormat:@" %@",self.cityName]:@"";
    NSString *cCountyName = self.countyName.length?[NSString stringWithFormat:@" %@",self.countyName]:@"";
    NSString *cAddressDetail = self.addressDetail.length?[NSString stringWithFormat:@" %@",self.addressDetail]:@"";
    return [NSString stringWithFormat:@"%@%@%@%@",cProvinceName,cCityName,cCountyName,cAddressDetail];
}

@end
