//
//  CYTSeekCarNeedPublishViewController.h
//  CYTEasyPass
//
//  Created by Jentle on 2017/6/8.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFSideSlideViewController.h"
#import "CYTSeekCarListModel.h"

typedef enum : NSUInteger {
    CYTSeekCarNeedPublishTypeDefault = 0, //普通模式
    CYTSeekCarNeedPublishTypeEdit,   //编辑寻车信息

} CYTSeekCarNeedPublishType;

@interface CYTSeekCarNeedPublishViewController : FFSideSlideViewController

/** 寻车模型 */
@property(strong, nonatomic) CYTSeekCarListModel *seekCarModel;

/** 页面模式 */
@property(assign, nonatomic) CYTSeekCarNeedPublishType seekCarNeedPublishType;


@end
