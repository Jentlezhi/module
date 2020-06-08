//
//  CYTPublishProcedureVM.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/6/6.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTExtendViewModel.h"

@interface CYTPublishProcedureVM : CYTExtendViewModel
@property (nonatomic, strong) NSMutableArray *listArray;
@property (nonatomic, copy) NSString *lastTitle;
///自定义的内容
@property (nonatomic, copy) NSString *content;

@property (nonatomic, assign) NSInteger sectionNumber;

- (NSString *)titleWithIndex:(NSIndexPath *)indexPath;

@end
