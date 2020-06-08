//
//  CYTTipLabel.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/4/25.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYTTipLabel : UILabel

- (instancetype)initWithText:(NSString *)text;

- (instancetype)initWithText:(NSString *)text textEdgeInsets:(UIEdgeInsets)textInsets maxWidth:(CGFloat)maxWidth minWidth:(CGFloat)minWidth;


@end
