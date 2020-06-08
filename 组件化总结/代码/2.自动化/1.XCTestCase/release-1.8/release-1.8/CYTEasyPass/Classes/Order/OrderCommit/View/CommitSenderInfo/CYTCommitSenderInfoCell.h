//
//  CYTCommitReceiverInfoCell.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/8/30.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CYTSendContacts;

@interface CYTCommitSenderInfoCell : UITableViewCell

/** 发车人信息 */
@property(strong, nonatomic) CYTSendContacts *sendContacts;
/** 发车地址点击回调 */
@property(copy, nonatomic) void(^sendAddressClick)();
/** 发车人点击回调 */
@property(copy, nonatomic) void(^senderClick)();

+ (instancetype)cellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@end
