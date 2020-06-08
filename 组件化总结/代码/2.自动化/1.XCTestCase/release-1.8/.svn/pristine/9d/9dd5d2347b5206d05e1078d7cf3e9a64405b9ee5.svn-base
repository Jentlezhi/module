//
//  CYTVehicleToolsModelListCell.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/9/5.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTVehicleToolsListCell.h"
#import "CYTVehicleToolsModel.h"
#import "CYTVehicleToolsListView.h"

@interface CYTVehicleToolsListCell()

/** 自定义view */
@property(strong, nonatomic) CYTVehicleToolsListView *vehicleToolsListView;

@end

@implementation CYTVehicleToolsListCell

#pragma mark - 懒加载

- (CYTVehicleToolsListView *)vehicleToolsListView{
    if (!_vehicleToolsListView) {
        _vehicleToolsListView = [[CYTVehicleToolsListView alloc] initWithType:CYTVehicleToolsViewTypeList];
    }
    return _vehicleToolsListView;
}

- (void)initSubComponents{
    [self.contentView addSubview:self.vehicleToolsListView];
}
- (void)makeSubConstrains{
    [self.vehicleToolsListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
    }];
}
- (void)setVehicleToolsModel:(CYTVehicleToolsModel *)vehicleToolsModel{
    _vehicleToolsModel = vehicleToolsModel;
    self.vehicleToolsListView.vehicleToolsModel = vehicleToolsModel;
}


@end
