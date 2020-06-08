//
//  CYTPersonalHomeVM.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/8/29.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTPersonalHomeVM.h"
#import "CYTPersonalHomeNumberModel.h"

@interface CYTPersonalHomeVM ()
@property (nonatomic, strong) NSArray *sectionTitleArray;

@end

@implementation CYTPersonalHomeVM
@synthesize requestCommand = _requestCommand;

- (void)ff_initWithModel:(FFExtendModel *)model {
    [self getSectionTitle];
    [self getCellListModel];
}

- (void)getSectionTitle {
    self.sectionTitleArray = @[@"",@"买车",@"卖车",@"物流",@"资金管理",@"其他"];
}

- (void)getCellListModel {
    //我的信息
    CYTPersonalHomeCellModel *personModel = [CYTPersonalHomeCellModel new];
    personModel.indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    NSMutableArray *array0 = [NSMutableArray array];
    [array0 addObject:personModel];
    
    //买车
    CYTPersonalHomeCellModel *seekCar = [CYTPersonalHomeCellModel new];
    seekCar.title = @"我的寻车";
    seekCar.imageName = @"mine_seekCar";
    seekCar.indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    
    CYTPersonalHomeCellModel *boughtCarOrder = [CYTPersonalHomeCellModel new];
    boughtCarOrder.title = @"买车订单";
    boughtCarOrder.imageName = @"mine_order_bought";
    boughtCarOrder.indexPath = [NSIndexPath indexPathForRow:1 inSection:1];
    NSMutableArray *array1 = [NSMutableArray array];
    [array1 addObject:seekCar];
    [array1 addObject:boughtCarOrder];
    
    //卖车
    CYTPersonalHomeCellModel *carSource = [CYTPersonalHomeCellModel new];
    carSource.title = @"我的车源";
    carSource.imageName = @"mine_carSource";
    carSource.indexPath = [NSIndexPath indexPathForRow:0 inSection:2];
    
    CYTPersonalHomeCellModel *souldCarOrder = [CYTPersonalHomeCellModel new];
    souldCarOrder.title = @"卖车订单";
    souldCarOrder.imageName = @"mine_order_sold";
    souldCarOrder.indexPath = [NSIndexPath indexPathForRow:1 inSection:2];
    NSMutableArray *array2 = [NSMutableArray array];
    [array2 addObject:carSource];
    [array2 addObject:souldCarOrder];
    
    //物流
    CYTPersonalHomeCellModel *logisticsNeed = [CYTPersonalHomeCellModel new];
    logisticsNeed.title = @"物流需求";
    logisticsNeed.imageName = @"mine_log_need";
    logisticsNeed.indexPath = [NSIndexPath indexPathForRow:0 inSection:3];
    
    CYTPersonalHomeCellModel *logisticsOrder = [CYTPersonalHomeCellModel new];
    logisticsOrder.title = @"物流订单";
    logisticsOrder.imageName = @"mine_log_order";
    logisticsOrder.indexPath = [NSIndexPath indexPathForRow:1 inSection:3];
    NSMutableArray *array3 = [NSMutableArray array];
    [array3 addObject:logisticsNeed];
    [array3 addObject:logisticsOrder];
    
    //资金管理
    CYTPersonalHomeCellModel *account = [CYTPersonalHomeCellModel new];
    account.title = @"我的账户";
    account.imageName = @"mine_account";
    account.indexPath = [NSIndexPath indexPathForRow:0 inSection:4];
    
    CYTPersonalHomeCellModel *coupon = [CYTPersonalHomeCellModel new];
    coupon.title = @"我的卡券";
    coupon.imageName = @"mine_coupon";
    coupon.indexPath = [NSIndexPath indexPathForRow:1 inSection:4];
    
    CYTPersonalHomeCellModel *dealPwd = [CYTPersonalHomeCellModel new];
    dealPwd.title = @"交易密码";
    dealPwd.imageName = @"mine_dealpwd";
    dealPwd.indexPath = [NSIndexPath indexPathForRow:2 inSection:4];
    
    CYTPersonalHomeCellModel *getCash = [CYTPersonalHomeCellModel new];
    getCash.title = @"提现";
    getCash.imageName = @"mine_getCash";
    getCash.indexPath = [NSIndexPath indexPathForRow:3 inSection:4];
    
    CYTPersonalHomeCellModel *myCurrency = [CYTPersonalHomeCellModel new];
    myCurrency.title = @"我的易车币";
    myCurrency.imageName = @"mine_currency";
    myCurrency.indexPath = [NSIndexPath indexPathForRow:4 inSection:4];
    
    NSMutableArray *array4 = [NSMutableArray array];
    [array4 addObject:account];
    [array4 addObject:coupon];
    [array4 addObject:dealPwd];
    [array4 addObject:getCash];
    [array4 addObject:myCurrency];
    
    //其他
    CYTPersonalHomeCellModel *myConnected = [CYTPersonalHomeCellModel new];
    myConnected.title = @"我联系的";
    myConnected.imageName = @"mine_myConnected";
    myConnected.indexPath = [NSIndexPath indexPathForRow:0 inSection:5];
    
    CYTPersonalHomeCellModel *connectedMe = [CYTPersonalHomeCellModel new];
    connectedMe.title = @"联系我的";
    connectedMe.imageName = @"mine_connectedMe";
    connectedMe.indexPath = [NSIndexPath indexPathForRow:1 inSection:5];
    
    NSMutableArray *array5 = [NSMutableArray array];
    [array5 addObject:myConnected];
    [array5 addObject:connectedMe];
    
    
    self.cellArray = [NSMutableArray array];
    [self.cellArray addObject:array0];
    [self.cellArray addObject:array1];
    [self.cellArray addObject:array2];
    [self.cellArray addObject:array3];
    [self.cellArray addObject:array4];
    [self.cellArray addObject:array5];
    
}

- (NSInteger)numberWithSection:(NSInteger)sectionIndex {
    NSArray *section = self.cellArray[sectionIndex];
    return section.count;
}

- (NSString *)sectinTitleWithSection:(NSInteger)sectionIndex {
    return self.sectionTitleArray[sectionIndex];
}

- (CYTPersonalHomeCellModel *)cellModelWithIndexPath:(NSIndexPath *)indexPath {
    NSArray *section = self.cellArray[indexPath.section];
    return section[indexPath.row];
}

#pragma mark- get
- (RACCommand *)requestCommand {
    if (!_requestCommand) {
        _requestCommand = [self commandWithRequestModel:^FFBasicNetworkRequestModel *{
            FFBasicNetworkRequestModel *model = [FFBasicNetworkRequestModel new];
            model.requestURL = kURL.user_info_getMyCount;
            model.methodType = NetRequestMethodTypeGet;
            model.needHud = NO;
            model.requestParameters = nil;
            return model;
        } andHandle:^(FFBasicNetworkResponseModel *resultModel) {
            //处理消息数量
            CYTPersonalHomeNumberModel *numberModel = [CYTPersonalHomeNumberModel mj_objectWithKeyValues:resultModel.dataDictionary];
            
            NSString *sec1_num0 = numberModel.seekCarCountText;
            NSString *sec1_num1 = numberModel.buyOrderCountText;
            NSString *sec2_num0 = numberModel.carSourceCountText;
            NSString *sec2_num1 = numberModel.saleOrderCountText;
            NSString *sec3_num0 = numberModel.logisticsDemandCountText;
            NSString *sec3_num1 = numberModel.logisticsOrderCountText;
            
            //买车
            NSMutableArray *section1 = self.cellArray[1];
            CYTPersonalHomeCellModel *sec1_model0 = section1[0];
            sec1_model0.number = sec1_num0;
            CYTPersonalHomeCellModel *sec1_model1 = section1[1];
            sec1_model1.number = sec1_num1;
            sec1_model1.showBubble = numberModel.isBuyOrderTip;
            
            //卖车
            NSMutableArray *section2 = self.cellArray[2];
            CYTPersonalHomeCellModel *sec2_model0 = section2[0];
            sec2_model0.number = sec2_num0;
            CYTPersonalHomeCellModel *sec2_model1 = section2[1];
            sec2_model1.number = sec2_num1;
            sec2_model1.showBubble = numberModel.isSaleOrderTip;
            
            //物流
            NSMutableArray *section3 = self.cellArray[3];
            CYTPersonalHomeCellModel *sec3_model0 = section3[0];
            sec3_model0.number = sec3_num0;
            sec3_model0.showBubble = numberModel.isLogisticsDemandTip;
            CYTPersonalHomeCellModel *sec3_model1 = section3[1];
            sec3_model1.number = sec3_num1;
            sec3_model1.showBubble = numberModel.isLogisticsOrderTip;
            
        }];
    }
    return _requestCommand;
}

@end
