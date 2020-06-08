//
//  CYTDealerAuthImageModel.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/8/2.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendModel.h"

@interface CYTDealerAuthImageModel : FFExtendModel
@property (nonatomic, copy) NSString *thumbnailUrl;
@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, assign) CGRect prviewFrame;
@property(strong, nonatomic) UIImage *prviewImage;

@end
