//
//  CYTAdsInfoView.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/10/12.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYTRecommendListModel.h"

@interface CYTAdsInfoView : UIView

/** 广告数据 */
@property(strong, nonatomic) NSArray *recommendLists;

/** 点击操作 */
@property(copy, nonatomic) void(^adsInfoClick)(CYTRecommendListModel *recommendListModel);

@end
