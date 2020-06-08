//
//  CYTUnenableSearchViewWithBorder.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/5/25.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendView.h"
#import "CYTUnenableSearchView.h"

@interface CYTUnenableSearchViewWithBorder : FFExtendView
@property (nonatomic, strong) CYTUnenableSearchView *searchView;
@property (nonatomic, copy) void (^searchBlock) (void);


@end
