//
//  CYTUpdateView.h
//  CYTEasyPass
//
//  Created by xujunquan on 2017/11/20.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFBasicSupernatant.h"
#import "CYTUpdateManager.h"

@interface CYTUpdateView : FFBasicSupernatant
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, copy) void (^updateBlock) (BOOL update);
//子类重写父类属性（需要在实体中重写set/get方法）
@property (nonatomic, strong) CYTUpdateManager *viewModel;

@end
