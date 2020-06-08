//
//  CYTShareRequestModel.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/6/16.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendModel.h"

///分享方向
typedef NS_ENUM(NSInteger,ShareTypeId) {
    ///分享车源详情
    ShareTypeId_carSource = 1,
    ///分享寻车详情
    ShareTypeId_seekCar = 2,
    ///分享app
    ShareTypeId_applink = 0,
};

///分享途径
typedef NS_ENUM(NSInteger,SharePlant) {
    ///通过微信好友分享
    SharePlant_wx = 0,
    ///通过朋友圈分享
    SharePlant_friends = 1,
    ///复制链接进行分享
    SharePlant_link = 2,
};

///分享内容格式(1.网页 2.文字 3.图片 4.语音 5.视频)
typedef NS_ENUM(NSInteger,ShareContentForm) {
    ShareContentForm_netView=1,
    ShareContentForm_text=2,
    ShareContentForm_image=3,
    ShareContentForm_voice=4,
    ShareContentForm_video=5,
};

@interface CYTShareRequestModel : FFExtendModel
///分享点击的图标index
@property (nonatomic, assign) NSInteger plant;

///分享类型
@property (nonatomic, assign) ShareTypeId type;

///车源或者寻车的id
@property (nonatomic, assign) NSInteger idCode;


@end
