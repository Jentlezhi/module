//
//  CYTLogisticsNeedList.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/9/6.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTLogisticsNeedList.h"
#import "CYTLogisticsNeedListItemTableController.h"
#import "CYTLogisticsNeedDetailTableController.h"
#import "CYTSimpleBottomView.h"
#import "CYTLogisticsNeedWriteTableController.h"

@interface CYTLogisticsNeedList ()
@property (nonatomic, strong) CYTLogisticsNeedListItemTableController *quanbuCtr;
@property (nonatomic, strong) CYTLogisticsNeedListItemTableController *daixiadanCtr;
@property (nonatomic, strong) CYTLogisticsNeedListItemTableController *wanchengCtr;
@property (nonatomic, strong) CYTLogisticsNeedListItemTableController *guoqiCtr;
@property (nonatomic, strong) CYTLogisticsNeedListItemTableController *quxiaoCtr;

@property (nonatomic, strong) NSMutableArray *controlArray;
@property (nonatomic, strong) CYTSimpleBottomView *bottomView;

@end

@implementation CYTLogisticsNeedList

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ffTitle = @"我的物流需求";
    self.view.backgroundColor = kFFColor_bg_nor;
    [CYTTools updateNavigationBarWithController:self showBackView:YES showLine:YES];
    
    self.segmentHeight = CYTAutoLayoutV(80);
    self.segmentView.itemMinWidth = CYTAutoLayoutH(150);
    self.segmentView.indicatorBgColor = [UIColor whiteColor];
    self.segmentView.lineHeight = CYTAutoLayoutV(2);
    self.segmentView.titleNorColor = kFFColor_title_L2;
    [self creatViewSlider];
    self.tabControllersArray = self.controlArray;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshMethod) name:kLogisticsNeedListRefreshKey object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshMethod) name:kLogisticsNeedList_cancel_refresh object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshMethod) name:kLogisticsOrderCommitSuccessNotkey object:nil];
    
    [self.ffContentView addSubview:self.bottomView];
    [self.bottomView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(0);
        make.height.equalTo([CYTSimpleBottomView height]);
    }];
}

- (void)refreshMethod {
    //切标签
    //1、取消后单子归类到全部。2、订单提交成功单子归类到全部--所以index=0即可
    //和订单保持一致，暂时不切标签
//    self.segmentView.index = 0;
    
    [self.quanbuCtr refreshMethodWithNeed:YES];
    [self.daixiadanCtr refreshMethodWithNeed:YES];
    [self.wanchengCtr refreshMethodWithNeed:YES];
    [self.guoqiCtr refreshMethodWithNeed:YES];
    [self.quxiaoCtr refreshMethodWithNeed:YES];
}

- (void)indexChangeWithIndex:(NSInteger)index {
    CYTLogisticsNeedListItemTableController *item = self.controlArray[index];
    [item refreshMethodWithNeed:NO];
}

- (void)creatViewSlider{
    
    self.quanbuCtr = [CYTLogisticsNeedListItemTableController new];
    self.quanbuCtr.viewModel.state = CYTLogisticsNeedStatusAll;
    self.quanbuCtr.title = @"全部";
    @weakify(self);
    [self.quanbuCtr setSelectBlock:^(CYTLogisticsNeedListModel *model) {
        @strongify(self);
        [self gotoDetail:model];
    }];
    
    self.daixiadanCtr = [CYTLogisticsNeedListItemTableController new];
    self.daixiadanCtr.viewModel.state = CYTLogisticsNeedStatusUnOrder;
    self.daixiadanCtr.title = @"待下单";
    [self.daixiadanCtr setSelectBlock:^(CYTLogisticsNeedListModel *model) {
        @strongify(self);
        [self gotoDetail:model];
    }];
    
    self.wanchengCtr = [CYTLogisticsNeedListItemTableController new];
    self.wanchengCtr.viewModel.state = CYTLogisticsNeedStatusFinished;
    self.wanchengCtr.title = @"已完成";
    [self.wanchengCtr setSelectBlock:^(CYTLogisticsNeedListModel *model) {
        @strongify(self);
        [self gotoDetail:model];
    }];
    
    self.guoqiCtr = [CYTLogisticsNeedListItemTableController new];
    self.guoqiCtr.viewModel.state = CYTLogisticsNeedStatusExpired;
    self.guoqiCtr.title = @"已过期";
    [self.guoqiCtr setSelectBlock:^(CYTLogisticsNeedListModel *model) {
        @strongify(self);
        [self gotoDetail:model];
    }];
    
    self.quxiaoCtr = [CYTLogisticsNeedListItemTableController new];
    self.quxiaoCtr.viewModel.state = CYTLogisticsNeedStatusCancel;
    self.quxiaoCtr.title = @"已取消";
    [self.quxiaoCtr setSelectBlock:^(CYTLogisticsNeedListModel *model) {
        @strongify(self);
        [self gotoDetail:model];
    }];
    
    self.controlArray = [[NSMutableArray alloc] initWithObjects:self.quanbuCtr, self.daixiadanCtr,self.wanchengCtr,self.guoqiCtr,self.quxiaoCtr, nil];
}

- (void)gotoDetail:(CYTLogisticsNeedListModel *)model {
    CYTLogisticsNeedDetailTableController *detail = [CYTLogisticsNeedDetailTableController new];
    detail.viewModel.neeId = model.demandId;
    [self.navigationController pushViewController:detail animated:YES];
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
