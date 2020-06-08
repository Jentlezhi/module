//
//  CYTHomeHeaderView.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/10/16.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYTFunctionModel.h"

@class CYTRecommendListModel;

@interface CYTHomeHeaderView : UIView

/** Banner轮播资源 */
@property(strong, nonatomic) NSArray *bannerInfoLists;
/** Banner图片点击操作 */
@property(copy, nonatomic) void(^bannerImageClick)(NSString *url);

/** 功能数据 */
@property(strong, nonatomic) NSArray *functionData;
/** 功能点击操作 */
@property(copy, nonatomic) void(^functionItemClick)(CYTFunctionModel *functionModel);

/** 实店认证商家列表数据 */
@property(strong, nonatomic) NSArray *storeAuthModels;

/** 推荐数据 */
@property(strong, nonatomic) NSArray *recommendLists;
/** 推荐点击操作 */
@property(copy, nonatomic) void(^recommendClick)(CYTRecommendListModel *recommendListModel);


@end
