//
//  CYTCommitGuideView.h
//  CYTEasyPass
//
//  Created by xujunquan on 2017/10/26.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFBasicSupernatant.h"

@interface CYTCommitGuideView : FFBasicSupernatant
@property (nonatomic, strong) UIView *whiteView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *actionButton;
@property (nonatomic, copy) ffDefaultBlock clickBlock;

@end
