//
//  CYTOrderExtendViewController.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/9/14.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTOrderExtendViewController.h"
#import "CYTOrderManagerSectionHeader.h"
#import "CYTOrderExtendListCell.h"
#import "CYTVouchersCell.h"
#import "CYTOrderExtendItemModel.h"
#import "CYTOrderExtendSectionModel.h"
#import "CYTOrderBottomToolBar.h"
#import "CYTSelectImageModel.h"
#import "CYTMultiImgeUploadTool.h"
#import "CYTImageHandelTool.h"
#import "CYTOrderExtendCommitPar.h"

typedef NS_ENUM(NSUInteger, CYTDepositFlowTo) {
    CYTDepositFlowToUnpay = 0,//未支付
    CYTDepositFlowToReturnToBuyer,//退订金给买家
    CYTDepositFlowToPayForSeller,//付给卖家
};

@interface CYTOrderExtendViewController ()
/** 订单类型拓展 */
@property(assign, nonatomic) CYTOrderExtendType orderExtendType;
/** 订单状态 */
@property(assign, nonatomic) CarOrderState orderStatus;
/** 订单ID */
@property(copy, nonatomic) NSString *orderId;
/** 请求参数 */
@property(strong, nonatomic) NSDictionary *requestListPar;
/** 组 */
@property(strong, nonatomic,readonly) NSArray *sectionTitles;
/** 已选 */
@property(strong, nonatomic) NSMutableArray *selectItems;
/** 已选中的图片 */
@property(strong, nonatomic) NSMutableArray<CYTSelectImageModel *> *selectedImageModels;
/** 底部按钮 */
@property(strong, nonatomic) CYTOrderBottomToolBar *orderBottomToolBar;
/** 提交参数 */
@property(strong, nonatomic) CYTOrderExtendCommitPar *orderExtendCommitPar;
/** 付订金给卖家 */
@property(strong, nonatomic) UIButton *payDepositToSellerBtn;
/** 申请订金退回 */
@property(strong, nonatomic) UIButton *applyReturnDepositBackBtn;
/** 提交 */
@property(strong, nonatomic) UIButton *commitBtn;
/** 确认并退回给买家 */
@property(strong, nonatomic) UIButton *confirmAndReturn;

@end

@implementation CYTOrderExtendViewController
{
    NSArray *_sectionTitles;
}

+ (instancetype)orderExtendWithExtendType:(CYTOrderExtendType)extendType orderStatus:(CarOrderState)orderStatus orderId:(NSString *)orderId{
    CYTOrderExtendViewController *orderExtendViewController = [[CYTOrderExtendViewController alloc] init];
    CYTLog(@"%ld",extendType);
    orderExtendViewController.orderExtendType = extendType;
    CYTLog(@"%ld",orderExtendViewController.orderExtendType);
    orderExtendViewController.orderStatus = orderStatus;
    orderExtendViewController.orderId = orderId;
    return orderExtendViewController;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self orderExtendBasicConfig];
    [self configOrderExtendTableView];
    [self initOrderExtendComponents];
    [self requestOrderExtendData];
    [self addObserver];
    
}
/**
 *  基本设置
 */
- (void)orderExtendBasicConfig{
    NSString *title;
    switch (self.orderExtendType) {
        case CYTOrderExtendTypeBuyerCancel:
             title = @"买家取消订单";
            break;
        case CYTOrderExtendTypeSellerCancel:
            title = @"卖家取消订单";
            break;
        case CYTOrderExtendTypeConfirmRecCar:
            title = @"确认成交";
            break;
        default:
            break;
    }
    [self createNavBarWithBackButtonAndTitle:title];
}
/**
 *  表格配置
 */
- (void)configOrderExtendTableView{
    
}

/**
 *  添加监听
 */
- (void)addObserver{
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:kOrderExtendInputKey object:nil] subscribeNext:^(NSNotification *note) {
        NSString *inputContent = note.object;
        self.commitBtn.enabled = inputContent.length;
        self.orderExtendCommitPar.content = inputContent;
        self.payDepositToSellerBtn.enabled = inputContent.length;
        self.applyReturnDepositBackBtn.enabled = inputContent.length;
        self.confirmAndReturn.enabled = inputContent.length;
    }];
}
/**
 *  初始化子控件
 */
- (void)initOrderExtendComponents{
    //底部按钮
    [self.view addSubview:self.orderBottomToolBar];
    [self.orderBottomToolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(CYTAutoLayoutV(98.f));
    }];
}

/**
 *  请求列表数据
 */
- (void)requestOrderExtendData{
    CYTWeakSelf
    [CYTLoadingView showBackgroundLoadingWithType:CYTLoadingViewTypeEditNavBar];
    [CYTNetworkManager GET:kURL.order_car_orderExtend parameters:self.requestListPar dataTask:^(NSURLSessionDataTask *dataTask) {
        self.sessionDataTask = dataTask;
    } showErrorTost:NO completion:^(CYTNetworkResponse *responseObject) {
        [CYTLoadingView hideLoadingView];
        weakSelf.dataSource = [CYTOrderExtendItemModel mj_objectArrayWithKeyValuesArray:[responseObject.dataDictionary valueForKey:@"items"]];
        [weakSelf.mainTableView reloadData];
    }];
    
}
#pragma mark - 懒加载
- (NSArray *)sectionTitles{
    if (!_sectionTitles) {
        if (self.orderExtendType == CYTOrderExtendTypeConfirmRecCar) {
            CYTOrderExtendSectionModel *model0 = [CYTOrderExtendSectionModel new];
            model0.showInfoBar = YES;
            model0.sectionTitle = @"验收情况：";
            CYTOrderExtendSectionModel *model1 = [CYTOrderExtendSectionModel new];
            model1.showInfoBar = YES;
            model1.sectionTitle = @"上传凭证(选填)：";
            _sectionTitles = @[model0,model1];
            
        }else{
            CYTOrderExtendSectionModel *model0 = [CYTOrderExtendSectionModel new];
            model0.showInfoBar = YES;
            model0.sectionTitle = @"取消原因：";
            CYTOrderExtendSectionModel *model1 = [CYTOrderExtendSectionModel new];
            model1.showInfoBar = YES;
            model1.sectionTitle = @"上传凭证(选填)：";
            _sectionTitles = @[model0,model1];
        }
    }
    return _sectionTitles;
}
- (NSMutableArray *)selectItems{
    if (!_selectItems) {
        _selectItems = [NSMutableArray array];
    }
    return _selectItems;
}
- (CYTOrderBottomToolBar *)orderBottomToolBar{
    CYTWeakSelf
    if (!_orderBottomToolBar) {
        if (self.orderExtendType == CYTOrderExtendTypeBuyerCancel) {//买家取消
            if (self.orderStatus > CarOrderStateUnPay ) {//已支付订金
                NSString *serverImage = @"ic_kefu_hl_new";
                _orderBottomToolBar = [CYTOrderBottomToolBar orderDetailToolBarWithTitles:@[@"客服",@"付订金给卖家",@"申请订金退回"] imageNames:@[serverImage] firstBtnClick:^{
                    [CYTPhoneCallHandler makeServicePhone];
                } secondBtnClick:^{
                    [CYTAlertView alertViewWithTitle:@"提示" message:@"订金将会支付给卖家，确认取消？" confirmAction:^{
                        [weakSelf commitCancelReasonWithDepositFlowTo:CYTDepositFlowToPayForSeller];
                    } cancelAction:nil];
                } thirdBtnClick:^{
                    [CYTAlertView alertViewWithTitle:@"提示" message:@"卖家同意后订金将退回到原付款账户，确认退订金？" confirmAction:^{
                        [weakSelf commitCancelReasonWithDepositFlowTo:CYTDepositFlowToReturnToBuyer];
                    } cancelAction:nil];
                    
                } fourthBtnClick:nil buttonsBlock:^(NSArray *buttons) {
                    weakSelf.payDepositToSellerBtn = buttons[1];
                    weakSelf.payDepositToSellerBtn.enabled = NO;
                    weakSelf.applyReturnDepositBackBtn = [buttons lastObject];
                    weakSelf.applyReturnDepositBackBtn.enabled = NO;
                }];
            }else{
                NSString *serverImage = @"ic_kefu_hl_new";
                _orderBottomToolBar = [CYTOrderBottomToolBar orderDetailToolBarWithTitles:@[@"客服",@"提交"] imageNames:@[serverImage] firstBtnClick:^{
                    [CYTPhoneCallHandler makeServicePhone];
                } secondBtnClick:^{
                    [CYTAlertView alertViewWithTitle:@"提示" message:@"确认提交？" confirmAction:^{
                        [weakSelf commitCancelReasonWithDepositFlowTo:CYTDepositFlowToUnpay];
                    } cancelAction:nil];
                    
                } thirdBtnClick:nil fourthBtnClick:nil buttonsBlock:^(NSArray *buttons) {
                    weakSelf.commitBtn = [buttons lastObject];
                    weakSelf.commitBtn.enabled = NO;
                }];
            }
        }else if (self.orderExtendType == CYTOrderExtendTypeSellerCancel){//卖家取消
            if (self.orderStatus > CarOrderStateUnPay ) {//已支付订金
                NSString *serverImage = @"ic_kefu_hl_new";
                _orderBottomToolBar = [CYTOrderBottomToolBar orderDetailToolBarWithTitles:@[@"客服",@"确认并退订金给买家"] imageNames:@[serverImage] firstBtnClick:^{
                    [CYTPhoneCallHandler makeServicePhone];
                } secondBtnClick:^{
                    [CYTAlertView alertViewWithTitle:@"提示" message:@"退订金给买家?" confirmAction:^{
                        [weakSelf commitCancelReasonWithDepositFlowTo:CYTDepositFlowToReturnToBuyer];
                    } cancelAction:nil];
                } thirdBtnClick:nil fourthBtnClick:nil buttonsBlock:^(NSArray *buttons) {
                    weakSelf.confirmAndReturn = [buttons lastObject];
                    weakSelf.confirmAndReturn.enabled = NO;
                }];
                
            }else{
                NSString *serverImage = @"ic_kefu_hl_new";
                _orderBottomToolBar = [CYTOrderBottomToolBar orderDetailToolBarWithTitles:@[@"客服",@"提交"] imageNames:@[serverImage] firstBtnClick:^{
                    [CYTPhoneCallHandler makeServicePhone];
                } secondBtnClick:^{
                    [CYTAlertView alertViewWithTitle:@"提示" message:@"确认提交？"  confirmAction:^{
                        [weakSelf commitCancelReasonWithDepositFlowTo:CYTDepositFlowToUnpay];
                    } cancelAction:nil];
                } thirdBtnClick:nil fourthBtnClick:nil buttonsBlock:^(NSArray *buttons) {
                    weakSelf.commitBtn = [buttons lastObject];
                    weakSelf.commitBtn.enabled = NO;
                }];
            }
        }else{//确认收车
            NSString *serverImage = @"ic_kefu_hl_new";
            _orderBottomToolBar = [CYTOrderBottomToolBar orderDetailToolBarWithTitles:@[@"客服",@"付订金给卖家",@"申请订金退回"] imageNames:@[serverImage]  firstBtnClick:^{
                [CYTPhoneCallHandler makeServicePhone];
            } secondBtnClick:^{
                [CYTAlertView alertViewWithTitle:@"提示" message:@"订金将转给卖家，确认成交？"  confirmAction:^{
                   [weakSelf confirmRecCarWithDepositFlowTo:2];
                } cancelAction:nil];
                
            } thirdBtnClick:^{
                [CYTAlertView alertViewWithTitle:@"提示" message:@"订金将在卖家同意后退回，确认成交？"  confirmAction:^{
                    [weakSelf confirmRecCarWithDepositFlowTo:1];
                } cancelAction:nil];
            } fourthBtnClick:nil buttonsBlock:^(NSArray *buttons) {
                weakSelf.payDepositToSellerBtn = buttons[1];
                weakSelf.payDepositToSellerBtn.enabled = NO;
                weakSelf.applyReturnDepositBackBtn = [buttons lastObject];
                weakSelf.applyReturnDepositBackBtn.enabled = NO;
            }];
        }

    }
    return _orderBottomToolBar;
}

- (CYTOrderExtendCommitPar *)orderExtendCommitPar{
    if (!_orderExtendCommitPar) {
        _orderExtendCommitPar = [[CYTOrderExtendCommitPar alloc] init];
        _orderExtendCommitPar.orderId = self.orderId;
    }
    return _orderExtendCommitPar;
}
#pragma mark - 属性设置

- (void)setOrderExtendType:(CYTOrderExtendType)orderExtendType{
    _orderExtendType = orderExtendType;
    self.requestListPar = @{@"extendType":@(orderExtendType)};
}


#pragma mark - <UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.sectionTitles.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.dataSource.count;
    }
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        CYTOrderExtendListCell *cell = [CYTOrderExtendListCell celllForTableView:tableView indexPath:indexPath];
        CYTOrderExtendItemModel *orderExtendItemModel = self.dataSource[indexPath.row];
        orderExtendItemModel.customHasSelect = [self.selectItems containsObject:orderExtendItemModel];
        orderExtendItemModel.customLast = indexPath.row == self.dataSource.count-1;
        cell.orderExtendItemModel = orderExtendItemModel;
        return cell;
    }
    CYTVouchersCell *cell = [CYTVouchersCell vouchersCellForTableView:tableView indexPath:indexPath];
    self.selectedImageModels = cell.selectedImageModels;
    return cell;
    
}

#pragma mark - <UITableViewDelegate>

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    CYTOrderManagerSectionHeader *sectionHeader = [[CYTOrderManagerSectionHeader alloc] init];
    sectionHeader.confirmSendCarSectionModel = self.sectionTitles[section];
    return sectionHeader;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CYTAutoLayoutV(90.f);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        CYTOrderExtendItemModel *orderExtendItemModel = self.dataSource[indexPath.row];
        self.orderExtendCommitPar.contentId = orderExtendItemModel.contentId;
        self.orderExtendCommitPar.content = orderExtendItemModel.content;
        if ([self.selectItems containsObject:orderExtendItemModel]) {
            self.commitBtn.enabled = NO;
            self.payDepositToSellerBtn.enabled = NO;
            self.applyReturnDepositBackBtn.enabled = NO;
            self.confirmAndReturn.enabled = NO;
            [self.selectItems removeObject:orderExtendItemModel];
        }else{
            [self.selectItems removeAllObjects];
            self.commitBtn.enabled = orderExtendItemModel.customLast ? NO:YES;
            self.payDepositToSellerBtn.enabled = orderExtendItemModel.customLast ? NO:YES;
            self.applyReturnDepositBackBtn.enabled = orderExtendItemModel.customLast ? NO:YES;
            self.confirmAndReturn.enabled = orderExtendItemModel.customLast ? NO:YES;;
            [self.selectItems addObject:orderExtendItemModel];
        }
        [self.mainTableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section]  withRowAnimation:UITableViewRowAnimationFade];
    }
}
#pragma mark - 取消的提交

- (void)commitCancelReasonWithDepositFlowTo:(CYTDepositFlowTo)depositFlowTo{
    self.commitBtn.enabled = NO;
    self.orderExtendCommitPar.depositFlowTo = depositFlowTo;
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    [CYTLoadingView showLoadingWithType:CYTLoadingViewTypeEditNavBar];
    [CYTImageHandelTool handelImageWithImageModels:self.selectedImageModels complation:^(NSArray *imageDatas) {
        [[CYTMultiImgeUploadTool new] uploadImagesWithImageDatas:imageDatas completion:^(NSArray<NSString *> *imageFileIds) {
             __block NSMutableArray *dictArray = [NSMutableArray array];
            [imageFileIds enumerateObjectsUsingBlock:^(NSString *fileId, NSUInteger idx, BOOL * _Nonnull stop) {
                NSMutableDictionary *dictPar = [NSMutableDictionary dictionary];
                [dictPar setValue:fileId forKey:@"FileID"];
                [dictArray addObject:dictPar];
            }];
            self.orderExtendCommitPar.imageVouchers = dictArray;
            dispatch_group_leave(group);
        }];
    }];
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        [CYTNetworkManager POST:kURL.order_car_cancelOrder parameters:self.orderExtendCommitPar.mj_keyValues dataTask:^(NSURLSessionDataTask *dataTask) {
            self.sessionDataTask = dataTask;
        } showErrorTost:YES completion:^(CYTNetworkResponse *responseObject) {
            [CYTLoadingView hideLoadingView];
            self.commitBtn.enabled = YES;
            if (responseObject.resultEffective) {
                [[NSNotificationCenter defaultCenter] postNotificationName:kRefreshOrderListKey object:nil];
                [[NSNotificationCenter defaultCenter] postNotificationName:kRefreshOrderDetailKey object:nil];
                [self.navigationController popViewControllerAnimated:YES];
                [CYTToast successToastWithMessage:responseObject.resultMessage];
            }
        }];
    });

}

#pragma mark - 确认收车

- (void)confirmRecCarWithDepositFlowTo:(CYTDepositFlowTo)depositFlowTo{
    self.orderExtendCommitPar.depositFlowTo = depositFlowTo;
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    [CYTLoadingView showLoadingWithType:CYTLoadingViewTypeEditNavBar];
    [CYTImageHandelTool handelImageWithImageModels:self.selectedImageModels complation:^(NSArray *imageDatas) {
        [[CYTMultiImgeUploadTool new] uploadImagesWithImageDatas:imageDatas completion:^(NSArray<NSString *> *imageFileIds) {
            __block NSMutableArray *dictArray = [NSMutableArray array];
            [imageFileIds enumerateObjectsUsingBlock:^(NSString *fileId, NSUInteger idx, BOOL * _Nonnull stop) {
                NSMutableDictionary *dictPar = [NSMutableDictionary dictionary];
                [dictPar setValue:fileId forKey:@"FileID"];
                [dictArray addObject:dictPar];
            }];
            self.orderExtendCommitPar.imageVouchers = dictArray;
            dispatch_group_leave(group);
        }];
    }];
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        [CYTNetworkManager POST:kURL.order_car_receiveCar parameters:self.orderExtendCommitPar.mj_keyValues dataTask:^(NSURLSessionDataTask *dataTask) {
            self.sessionDataTask = dataTask;
        } showErrorTost:YES completion:^(CYTNetworkResponse *responseObject) {
            [CYTLoadingView hideLoadingView];
            if (responseObject.resultEffective) {
                [[NSNotificationCenter defaultCenter] postNotificationName:kRefreshOrderListKey object:nil];
                [[NSNotificationCenter defaultCenter] postNotificationName:kRefreshOrderDetailKey object:nil];
                [self.navigationController popViewControllerAnimated:YES];
                [CYTToast successToastWithMessage:responseObject.resultMessage];
            }
        }];
    });
}


@end
