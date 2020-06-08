//
//  CYTLocationViewController.h
//  CYTEasyPass
//
//  Created by bita on 16/1/18.
//  Copyright (c) 2016年 EasyPass. All rights reserved.
//

#import "CYTCarBaseTableViewController.h"
#import "CYTAdressListModel.h"

typedef NS_ENUM(NSInteger, CYTEditingAddressStatus) {
    CYTEditingAddressStatusAddNew = 0,
    CYTEditingAddressStatusAmendOld
};

@protocol CYTLocationSettingsViewControllerDelegate <NSObject>

@required
- (void)loactionMode:(CYTFilterColorsMode *)masterMode andWithProvinces:(NSString *)provincesName andWithProvincesId:(NSString *)provincesId andLocationDetailed:(NSString *)locationDetiled andWithIndexPath:(NSIndexPath *)indenxPath;

@end

@interface CYTLocationSettingsViewController : CYTCarBaseTableViewController

@property (nonatomic,weak) id <CYTLocationSettingsViewControllerDelegate> locationDegate;

@property (nonatomic,strong) NSIndexPath *indexPath;

//省份
@property (nonatomic,strong) NSMutableArray *loactionArray;

@property (nonatomic,assign) CYTEditingAddressStatus edStatus;

//修改的时候 默认的 输入项


- (void)setDefaultAdderss:(CYTAdressModel *)adressM;

@end
