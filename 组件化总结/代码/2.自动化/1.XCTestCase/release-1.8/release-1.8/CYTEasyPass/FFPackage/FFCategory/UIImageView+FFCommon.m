//
//  UIImageView+FFCommon.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/6/29.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "UIImageView+FFCommon.h"

@implementation UIImageView (FFCommon)

+ (instancetype)ff_imageViewWithImageName:(NSString *)imageName {
    UIImageView *imageView = [UIImageView new];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.image = (imageName)?[UIImage imageNamed:imageName]:nil;
    return imageView;
}

@end
