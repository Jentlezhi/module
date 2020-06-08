//
//  CYTLogisticsOrderList.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/9/6.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTLogisticsOrderList.h"
#import "CYTLogisticsOrderListItemTableController.h"
#import "CYTLogisticsOrderDetail3DController.h"
#import "CYTSimpleBottomView.h"
#import "CYTLogisticsNeedWriteTableController.h"

@interface CYTLogisticsOrderList ()
@property (nonatomic, strong) CYTLogisticsOrderListItemTableController *quanbuCtr;
@property (nonatomic, strong) CYTLogisticsOrderListItemTableController *daizhifuCtr;
@property (nonatomic, strong) CYTLogisticsOrderListItemTableController *daipeibanCtr;
@property (nonatomic, strong) CYTLogisticsOrderListItemTableController *daisijiCtr;
@property (nonatomic, strong) CYTLogisticsOrderListItemTableController *yunshuzhongCtr;
@property (nonatomic, strong) CYTLogisticsOrderListItemTableController *quxiaoCtr;
@property (nonatomic, strong) CYTLogisticsOrderListItemTableController *wanchengCtr;

@property (nonatomic, strong) NSMutableArray *controlArray;
@property (nonatomic, strong) CYTSimpleBottomView *bottomView;

@end

@implementation CYTLogisticsOrderList

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ffTitle = @"我的物流订单";
    self.view.backgroundColor = kFFColor_bg_nor;
    [CYTTools updateNavigationBarWithController:self showBackView:YES showLine:YES];
    
    self.segmentHeight = CYTAutoLayoutV(80);
    self.segmentView.itemMinWidth = CYTAutoLayoutH(150);
    self.segmentView.indicatorBgColor = [UIColor whiteColor];
    self.segmentView.lineHeight = CYTAutoLayoutV(2);
    self.segmentView.titleNorColor = kFFColor_title_L2;
    [self creatViewSlider];
    self.tabControllersArray = self.controlArray;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshMethod) name:kLogisticsOrderCommitSuccessNotkey object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshMethod) name:kLogisticsOrderPaySuccessNotkey object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshMethod) name:kLogisticsOrderListRefreshKey object:nil];
    
    [self.ffContentView addSubview:self.bottomView];
    [self.bottomView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(0);
        make.height.equalTo([CYTSimpleBottomView height]);
    }];
}

- (void)indexChangeWithIndex:(NSInteger)index {
    CYTLogisticsOrderListItemTableController *item = self.controlArray[index];
    [item refreshMethodWithNeed:NO];
}

- (void)refreshMethod {
    //不切标签
//    self.segmentView.index = 0;
    
    [self.quanbuCtr refreshMethodWithNeed:YES];
    [self.daizhifuCtr refreshMethodWithNeed:YES];
    [self.daipeibanCtr refreshMethodWithNeed:YES];
    [self.daisijiCtr refreshMethodWithNeed:YES];
    [self.yunshuzhongCtr refreshMethodWithNeed:YES];
    [self.quxiaoCtr refreshMethodWithNeed:YES];
    [self.wanchengCtr refreshMethodWithNeed:YES];
}

-(void)creatViewSlider{
    self.quanbuCtr = [CYTLogisticsOrderListItemTableController new];
    self.quanbuCtr.orderList = self;
    self.quanbuCtr.title = @"全部";
    self.quanbuCtr.viewModel.state = CYTLogisticsOrderStatusAll;
    @weakify(self);
    [self.quanbuCtr setSelectBlock:^(CYTLogisticsOrderListModel *model) {
        @strongify(self);
        [self gotoDetail:model];
    }];
    
    self.daizhifuCtr = [CYTLogisticsOrderListItemTableController new];
    self.daizhifuCtr.orderList = self;
    self.daizhifuCtr.title = @"待支付";
    self.daizhifuCtr.viewModel.state = CYTLogisticsOrderStatusWaitPay;
    [self.daizhifuCtr setSelectBlock:^(CYTLogisticsOrderListModel *model) {
        @strongify(self);
        [self gotoDetail:model];
    }];
    
    self.daipeibanCtr = [CYTLogisticsOrderListItemTableController new];
    self.daipeibanCtr.orderList = self;
    self.daipeibanCtr.title = @"待配板";
    self.daipeibanCtr.viewModel.state = CYTLogisticsOrderStatusWaitMatchingBoard;
    [self.daipeibanCtr setSelectBlock:^(CYTLogisticsOrderListModel *model) {
        @strongify(self);
        [self gotoDetail:model];
    }];
    
    self.daisijiCtr = [CYTLogisticsOrderListItemTableController new];
    self.daisijiCtr.orderList = self;
    self.daisijiCtr.title = @"待司机上门";
    self.daisijiCtr.viewModel.state = CYTLogisticsOrderStatusWaitDriver;
    [self.daisijiCtr setSelectBlock:^(CYTLogisticsOrderListModel *model) {
        @strongify(self);
        [self gotoDetail:model];
    }];
    
    self.yunshuzhongCtr = [CYTLogisticsOrderListItemTableController new];
    self.yunshuzhongCtr.orderList = self;
    self.yunshuzhongCtr.title = @"运输中";
    self.yunshuzhongCtr.viewModel.state = CYTLogisticsOrderStatusInTransit;
    [self.yunshuzhongCtr setSelectBlock:^(CYTLogisticsOrderListModel *model) {
        @strongify(self);
        [self gotoDetail:model];
    }];
    
    self.wanchengCtr = [CYTLogisticsOrderListItemTableController new];
    self.wanchengCtr.orderList = self;
    self.wanchengCtr.title = @"已完成";
    self.wanchengCtr.viewModel.state = CYTLogisticsOrderStatusFinish;
    [self.wanchengCtr setSelectBlock:^(CYTLogisticsOrderListModel *model) {
        @strongify(self);
        [self gotoDetail:model];
    }];
    
    self.quxiaoCtr = [CYTLogisticsOrderListItemTableController new];
    self.quxiaoCtr.orderList = self;
    self.quxiaoCtr.title = @"已取消";
    self.quxiaoCtr.viewModel.state = CYTLogisticsOrderStatusCancel;
    [self.quxiaoCtr setSelectBlock:^(CYTLogisticsOrderListModel *model) {
        @strongify(self);
        [self gotoDetail:model];
    }];
    
    self.controlArray = [[NSMutableArray alloc] initWithObjects:self.quanbuCtr, self.daizhifuCtr,self.daipeibanCtr,self.daisijiCtr,self.yunshuzhongCtr,self.wanchengCtr,self.quxiaoCtr, nil];
}
/**
 * 物流订单详情页面
 */
- (void)gotoDetail:(CYTLogisticsOrderListModel *)model {
    CYTLogisticsOrderDetail3DController *logisticsOrderDetailController = [[CYTLogisticsOrderDetail3DController alloc] init];
    logisticsOrderDetailController.orderId = [NSString stringWithFormat:@"%ld",model.orderId];
    [self.navigationController pushViewController:logisticsOrderDetailController animated:YES];
}

#pragma mark- get
- (CYTSimpleBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [CYTSimpleBottomView new];
        _bottomView.title = @"发布新的物流需求";
        @weakify(self);
        [_bottomView setClickBlock:^{
            @strongify(self);
            [self.navigationController pushViewController:[CYTLogisticsNeedWriteTableController new] animated:YES];
        }];
    }
    return _bottomView;
}

@end
