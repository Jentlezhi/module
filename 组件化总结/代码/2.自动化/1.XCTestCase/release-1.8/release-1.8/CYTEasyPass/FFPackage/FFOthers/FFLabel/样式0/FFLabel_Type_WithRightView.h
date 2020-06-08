//
//  FFLabel_Type_WithRightView.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/4/24.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendView.h"

@interface FFLabel_Type_WithRightView : FFExtendView
///title
@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) BOOL showRight;

- (void)initWithLabel:(UILabel *)label rightView:(UIView *)rightView;

- (void)hideRightIfTitleIs:(NSString *)string;

@end
