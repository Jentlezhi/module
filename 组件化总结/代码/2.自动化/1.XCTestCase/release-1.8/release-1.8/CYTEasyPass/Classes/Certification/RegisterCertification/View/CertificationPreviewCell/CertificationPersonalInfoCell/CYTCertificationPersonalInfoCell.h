//
//  CYTCertificationPersonalInfoCell.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/5/4.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CYTUserInfoModel;

@interface CYTCertificationPersonalInfoCell : UITableViewCell

/** 个人信息模型 */
@property(strong, nonatomic) CYTUserInfoModel *userAuthenticateInfoModel;

/** 图片点击的回调 */
@property(copy, nonatomic)  void(^picClickBack)(NSUInteger);

+ (instancetype)certificationPersonalInfoCelllForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@end
