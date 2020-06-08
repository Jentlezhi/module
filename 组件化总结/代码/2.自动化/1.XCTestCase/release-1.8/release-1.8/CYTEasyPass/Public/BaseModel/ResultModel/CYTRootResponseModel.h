//
//  CYTRootResponseModel.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/6/13.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYTRootResponseModel : NSObject
/** 字典数据 */
@property(strong, nonatomic) NSMutableDictionary *dictData;
/** 数组数据 */
@property(strong, nonatomic) NSMutableArray *arrayData;
/** 是否加载错误 */
@property(assign, nonatomic) BOOL networkError;
/** 是否无数据 */
@property(assign, nonatomic) BOOL nodata;
/** 是否有更多数据 */
@property(assign, nonatomic) BOOL isMore;
/** 是否显示加载错误页面 */
@property(assign, nonatomic) BOOL showNoNetworkView;
/** 是否显示无数据页面 */
@property(assign, nonatomic) BOOL showNoDataView;

@end
