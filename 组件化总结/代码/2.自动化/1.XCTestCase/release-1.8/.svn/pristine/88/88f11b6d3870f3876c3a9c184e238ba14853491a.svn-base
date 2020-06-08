//
//  CYTCommitReceiverInfoCell.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/8/30.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    CYTReceiveContactsTypeBuyer = 0,//买家收车信息
    CYTReceiveContactsTypeSeller,//卖家收车信息
} CYTReceiveContactsType;

@class CYTReceiveContacts;

@interface CYTCommitReceiverInfoCell : UITableViewCell

/** 收车信息 */
@property(strong, nonatomic) CYTReceiveContacts *receiveContacts;
/** 收车地址回调 */
@property(copy, nonatomic) void(^recAddressClick)();
/** 收车人回调 */
@property(copy, nonatomic) void(^recerClick)();

+ (instancetype)cellForTableView:(UITableView *)tableView type:(CYTReceiveContactsType)receiveContactsType indexPath:(NSIndexPath *)indexPath;

@end
