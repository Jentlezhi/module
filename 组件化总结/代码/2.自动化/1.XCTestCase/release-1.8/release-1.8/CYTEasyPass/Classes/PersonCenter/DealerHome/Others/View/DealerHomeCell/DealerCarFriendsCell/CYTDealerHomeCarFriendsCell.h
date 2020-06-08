//
//  CYTDealerHomeCarFriendsCell.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/7/28.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendTableViewCell.h"
#import "CYTDealerHomeCarFriendsModel.h"

@interface CYTDealerHomeCarFriendsCell : FFExtendTableViewCell
@property (nonatomic, strong) UIImageView *thumImageView;
@property (nonatomic, strong) UILabel *contentLab;
@property (nonatomic, strong) UILabel *numLab;

@property (nonatomic, strong) CYTDealerHomeCarFriendsModel *model;

@end
