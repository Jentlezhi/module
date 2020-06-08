//
//  CYTHomeBannerView.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/10/10.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYTBannerInfoModel.h"

@interface CYTHomeBannerView : UIView

/** 轮播资源 */
@property(strong, nonatomic) NSArray *bannerInfoLists;
/** 图片点击操作 */
@property(copy, nonatomic) void(^imageClick)(NSString *url);

@end
