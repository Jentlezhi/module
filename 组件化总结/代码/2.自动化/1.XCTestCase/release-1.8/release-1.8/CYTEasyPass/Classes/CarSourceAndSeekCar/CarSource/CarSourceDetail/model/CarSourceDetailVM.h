//
//  CarSourceDetailVM.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/6/13.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTExtendViewModel.h"
#import "CarSourceDetailModel.h"
#import "CarSourceDetailItemModel.h"
#import "CarSourceDetailDescModel.h"
#import "CarSourceDetailRoutModel.h"

@interface CarSourceDetailVM : CYTExtendViewModel
@property (nonatomic, copy) NSString *carSourceId;

/*
 1）如果是我的车源，则不显示底部view，不显示经销商view
 2）如果是订单详情进入，不显示底部view
 3）如果是他的车源进入，不显示经销商view
 */
@property (nonatomic, assign) BOOL isMyCarSource;
@property (nonatomic, assign) BOOL fromOrderView;
@property (nonatomic, assign) BOOL fromHisCarSource;
///下架车源
@property (nonatomic, assign) BOOL isUnStore;


@property (nonatomic, strong) CarSourceDetailModel *detailModel;

@property (nonatomic, strong) NSMutableArray *listArray;
@property (nonatomic, strong) NSMutableArray *section_0Arrary;
@property (nonatomic, strong) NSMutableArray *section_1Arrary;
@property (nonatomic, strong) NSMutableArray *flowArray;
@property (nonatomic, strong) NSMutableArray *userInfoArray;
@property (nonatomic, strong) NSMutableArray *routeArray;

///获取图片数据
@property (nonatomic, strong) NSMutableArray *imageURLArray;

/*
 分享使用
 */
@property (nonatomic, copy) NSString *avaliableArea;
@property (nonatomic, copy) NSString *carLocation;
@property (nonatomic, copy) NSString *procedures;
@property (nonatomic, copy) NSString *config;
@property (nonatomic, copy) NSString *remark;

//统计打电话
@property (nonatomic, strong) RACCommand *phoneCallCommand;


///根据section获取cellidentifier
- (NSString *)identifierWithSection:(NSInteger)section;
- (float)heightForHeaderInSection:(NSInteger)section;
- (UIView *)viewForHeaderInSection:(NSInteger)section;


///区ID
@property (nonatomic, assign) NSInteger locationGroupId;
///省ID
@property (nonatomic, assign) NSInteger provinceId;
///获取优势路线
@property (nonatomic, strong) RACCommand *routeCommand;

@end
