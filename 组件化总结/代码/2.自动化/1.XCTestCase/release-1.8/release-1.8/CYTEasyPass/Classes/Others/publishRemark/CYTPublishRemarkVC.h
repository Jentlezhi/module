//
//  CYTPublishRemarkVC.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/6/7.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTBasicViewController.h"

@interface CYTPublishRemarkVC : CYTBasicViewController
///title
@property (nonatomic, copy) NSString *titleString;
///placeholder
@property (nonatomic, copy) NSString *placeholder;
///备注
@property (nonatomic, copy) NSString *remarkPlaceholder;
///配置
@property (nonatomic, copy) NSString *configPlaceholder;
///可售区域
@property (nonatomic, copy) NSString *avaliableAreaPlaceholder;
///content
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) void (^configBlock) (NSString *item);



@end
