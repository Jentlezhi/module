//
//  CYTAddImageModel.h
//  CYTEasyPass
//
//  Created by xujunquan on 17/6/17.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "FFExtendModel.h"

//图片间隔
#define imageMargin CYTAutoLayoutH(10)

typedef NS_ENUM(NSInteger,AddImageType) {
    ///编辑模式
    AddImageTypeEdit = 0,
    ///浏览模式
    AddImageTypeShow,
};

@interface CYTAddImageModel : FFExtendModel
///最多图片数量
@property (nonatomic, assign) NSInteger imageMaxNum;
///每一排显示n张图片
@property (nonatomic, assign) NSInteger perLineNum;
///编辑还是浏览模式
@property (nonatomic, assign) AddImageType type;
///图片数据（CYTImageFileModel）
@property (nonatomic, strong) NSMutableArray *imageModelArray;


//计算属性，根据每行图片数获取image的宽高
@property (nonatomic, assign) float imageWH;

@end
