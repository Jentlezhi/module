//
//  CYTCarContactsModel.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/5/16.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCarContactsModel.h"

@implementation CYTCarContactsModel

- (NSString *)customContactDetail{
    NSString *cName = self.name.length?self.name:@"";
    NSString *cPhone = self.phone.length?[NSString stringWithFormat:@" %@",self.phone]:@"";
    NSString *cCerNumber = self.cerNumber.length?[NSString stringWithFormat:@" %@",self.cerNumber]:@"";
    return [NSString stringWithFormat:@"%@%@%@",cName,cPhone,cCerNumber];
}




@end
