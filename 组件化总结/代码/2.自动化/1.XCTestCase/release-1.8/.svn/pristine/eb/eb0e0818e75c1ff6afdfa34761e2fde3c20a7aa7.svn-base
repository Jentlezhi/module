//
//  CYTPhontoPreviewViewController.h
//  CYTEasyPass
//
//  Created by Juniort on 2017/3/19.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTBasicViewController.h"

@interface CYTPhontoPreviewViewController : CYTBasicViewController

/** 图片 */
@property(strong, nonatomic) NSMutableArray *images;
///如果传递数组中不是数据模型，根据此参数判断是否可以编辑，网络图片不可编辑，本地图片可以，这是最开始的逻辑，以后优化掉！！
@property (nonatomic, assign) BOOL netImage;

///如果传递的数组中是数据模型，则根据此参数判断是否可以编辑
@property (nonatomic, assign) BOOL canEdit;

/** 图片索引 */
@property(assign, nonatomic) NSInteger index;

/** 删除图片处理 */
@property(strong, nonatomic) NSMutableDictionary *cacenlImageUrlDict;

@end
