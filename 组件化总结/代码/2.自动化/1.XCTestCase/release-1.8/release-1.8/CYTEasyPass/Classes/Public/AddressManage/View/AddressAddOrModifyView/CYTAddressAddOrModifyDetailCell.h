//
//  CYTAddressAddOrModifyDetailCell.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/5/23.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendTableViewCell.h"

@interface CYTAddressAddOrModifyDetailCell : FFExtendTableViewCell
@property (nonatomic, strong) UILabel *flagLabel;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, copy) void (^textBlock) (NSString *);

@end
