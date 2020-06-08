//
//  CYTPersonalHomeVM.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/8/29.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTExtendViewModel.h"
#import "CYTPersonalHomeCellModel.h"

@interface CYTPersonalHomeVM : CYTExtendViewModel
///数据数组
@property (nonatomic, strong) NSMutableArray *cellArray;
///获取每个section的cell数量
- (NSInteger)numberWithSection:(NSInteger)sectionIndex;
///获取section title
- (NSString *)sectinTitleWithSection:(NSInteger)sectionIndex;
///获取cellModel
- (CYTPersonalHomeCellModel *)cellModelWithIndexPath:(NSIndexPath *)indexPath;

@end
