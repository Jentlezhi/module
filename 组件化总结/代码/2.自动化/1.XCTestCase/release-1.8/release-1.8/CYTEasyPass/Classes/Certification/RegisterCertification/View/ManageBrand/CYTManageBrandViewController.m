//
//  CYTManageBrandViewController.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/3/8.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTManageBrandViewController.h"
#import "CYTManageBrandCell.h"
#import "CYTManageBrandModel.h"
#import "CYTManageBrandIndexModel.h"
#import "NSObject+RACKVOWrapper.h"
#import "CYTKVOArrayModel.h"
#import "MJNIndexView.h"

#define  CYTManageBrandCellHight        CYTAutoLayoutV(90)
#define  CYTManageBrandSectionHeaderH   CYTAutoLayoutV(44)

@interface CYTManageBrandViewController ()<UITableViewDataSource,UITableViewDelegate,MJNIndexViewDataSource>

/** 视图表格 */
@property(strong, nonatomic) UITableView *manageBrandTableView;
/** 数据 */
@property(strong, nonatomic,readonly) NSMutableArray *brandData;

/** 清空按钮 */
@property(weak, nonatomic) UIButton *cleanBtn;

/** 确认按钮 */
@property(weak, nonatomic) UIButton *confirmBtn;
/** 已选择品牌id */
@property(strong, nonatomic) NSMutableArray *selectedBrandsId;
/** 数组模型 */
@property(strong, nonatomic) CYTKVOArrayModel *kvoArrayModel;
/** 索引 */
@property(strong, nonatomic) MJNIndexView *indexView;
/** 索引标题 */
@property (strong, nonatomic) NSMutableArray *indexArray;

@end

@implementation CYTManageBrandViewController
{
    NSMutableArray *_brandData;
    NSMutableArray *_letterIndexData;
}

- (CYTKVOArrayModel *)kvoArrayModel{
    if (!_kvoArrayModel) {
        _kvoArrayModel = [[CYTKVOArrayModel alloc] init];
    }
    return _kvoArrayModel;
}

- (NSMutableArray *)indexArray{
    if (!_indexArray) {
        _indexArray = [NSMutableArray array];
    }
    return _indexArray;
}

- (NSMutableArray *)selectedBrandsId{
    if (!_selectedBrandsId) {
        _selectedBrandsId = [NSMutableArray array];
    }
    return _selectedBrandsId;
}

- (UIButton *)cleanBtn{
    if (!_cleanBtn) {
        UIButton *cleanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [cleanBtn setTitle:@"清空" forState:UIControlStateNormal];
        [cleanBtn setTitleColor:CYTHexColor(@"#2cb73f") forState:UIControlStateNormal];
        [cleanBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [cleanBtn setBackgroundImage:[UIImage imageWithColor:CYTHexColor(@"#2cb73f")] forState:UIControlStateHighlighted];
        cleanBtn.layer.borderWidth = 1.0f;
        cleanBtn.layer.borderColor = [UIColor colorWithHexColor:@"#2cb73f"].CGColor;
        cleanBtn.layer.cornerRadius = 6;
        cleanBtn.layer.masksToBounds = YES;
        cleanBtn.titleLabel.font = CYTFontWithPixel(28.f);
        cleanBtn.enabled = NO;
        [self.view addSubview:cleanBtn];
        _cleanBtn = cleanBtn;
    }
    return _cleanBtn;
}

- (UIButton *)confirmBtn{
    if (!_confirmBtn) {
        UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
        [confirmBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexColor:@"#2cb73f"]] forState:UIControlStateNormal];
        confirmBtn.layer.cornerRadius = 6;
        confirmBtn.layer.masksToBounds = YES;
        confirmBtn.titleLabel.font = CYTFontWithPixel(38.f);
        confirmBtn.enabled = NO;
        [self.view addSubview:confirmBtn];
        _confirmBtn = confirmBtn;
    }
    return _confirmBtn;
}

- (NSMutableArray *)letterIndexData{
    if (!_letterIndexData) {
        _letterIndexData = [NSMutableArray array];
    }
    return _letterIndexData;
}

- (NSMutableArray *)brandData{
    if (!_brandData) {
        _brandData = [NSMutableArray array];
    }
    return _brandData;
}

- (UITableView *)manageBrandTableView{
    if (!_manageBrandTableView) {
        CGRect mbFrame = CGRectMake(0, CYTViewOriginY, kScreenWidth, kScreenHeight - CYTViewOriginY - CYTAutoLayoutV(70+42));
        _manageBrandTableView = [[UITableView alloc] initWithFrame:mbFrame style:UITableViewStylePlain];
        if (@available(iOS 11.0, *)) {
            _manageBrandTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _manageBrandTableView.estimatedSectionFooterHeight = 0;
            _manageBrandTableView.estimatedSectionHeaderHeight = 0;
        }
    }
    return _manageBrandTableView;
}

- (MJNIndexView *)indexView{
    if (!_indexView) {
        _indexView = [[MJNIndexView alloc]initWithFrame:self.view.bounds];
        _indexView.dataSource = self;
        _indexView.fontColor = CYTHexColor(@"#999999");
        _indexView.font = CYTFontWithPixel(30);
        _indexView.selectedItemFont = CYTBoldFontWithPixel(60);
        _indexView.selectedItemFontColor = CYTHexColor(@"#2cb73f");
        _indexView.itemsAligment = NSTextAlignmentCenter;
        _indexView.curtainFade = 0.0;
        _indexView.rightMargin = CYTAutoLayoutH(10);
        _indexView.maxItemDeflection = 75;
        _indexView.rangeOfDeflection = 3;
        _indexView.darkening = NO;
    }
    return _indexView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self manageBrandbasicConfig];
    [self configManageBrandTableView];
    [self initManageBrandComponents];
    [self refreshData];

}
/**
 *  基本配置
 */
- (void)manageBrandbasicConfig{
    [self createNavBarWithBackButtonAndTitle:@"主营品牌选择"];
    self.interactivePopGestureEnable = NO;
    for (CYTManageBrandModel *item in self.hasSelectBrands) {
        [self.selectedBrandsId addObject:item.brandId];
        [[self.kvoArrayModel mutableArrayValueForKeyPath:@"modelArray"] addObject:item];
    }
    [self.manageBrandTableView reloadData];
    [RACObserve(self.kvoArrayModel, modelArray) subscribeNext:^(CYTKVOArrayModel *kvoArrayModel) {
        if (self.kvoArrayModel.modelArray.count>0) {
            self.confirmBtn.enabled = YES;
            self.cleanBtn.enabled = YES;
        }else{
            self.confirmBtn.enabled = NO;
            self.cleanBtn.enabled = NO;
        }
    }];
    
}
/**
 *  初始化子控件
 */
- (void)initManageBrandComponents{
    //清空
    CYTWeakSelf
    [self.cleanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(CYTAutoLayoutH(38));
        make.bottom.equalTo(self.view).offset(-CYTAutoLayoutV(38));
        make.size.equalTo(CGSizeMake(CYTAutoLayoutH(318), CYTAutoLayoutV(70)));
    }];
    [[self.cleanBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        for (NSString *brand in self.selectedBrandsId) {
            for (CYTManageBrandModel *item in [self.kvoArrayModel mutableArrayValueForKeyPath:@"modelArray"]) {
                if ([item.brandId isEqualToString:brand]) {
                    [[self.kvoArrayModel mutableArrayValueForKeyPath:@"modelArray"] removeObject:item];
                }
            }
        }
        [self.selectedBrandsId removeAllObjects];
        [self.manageBrandTableView reloadData];
        
    }];
    //确认
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-CYTAutoLayoutH(38));
        make.bottom.equalTo(self.cleanBtn);
        make.size.equalTo(self.cleanBtn);
    }];
    
    [[self.confirmBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        !weakSelf.manageBrandsBack?:weakSelf.manageBrandsBack(weakSelf.kvoArrayModel.modelArray);
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    
}
/**
 *  配置表格
 */
- (void)configManageBrandTableView{
    self.manageBrandTableView.backgroundColor = [UIColor whiteColor];
    self.manageBrandTableView.delegate = self;
    self.manageBrandTableView.dataSource = self;
    self.manageBrandTableView.tableFooterView = [[UIView alloc] init];
    self.manageBrandTableView.showsVerticalScrollIndicator = NO;
    self.manageBrandTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.manageBrandTableView];
    //上拉刷新
    self.manageBrandTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self requestManageBrandDataWithRequestType:CYTRequestTypeRefresh];
    }];
}

/**
 *  加载数据
 */
- (void)refreshData{
    [self.manageBrandTableView.mj_header beginRefreshing];
}
/**
 * 获取主营类型数据
 */
- (void)requestManageBrandDataWithRequestType:(CYTRequestType)requestType{
    [CYTNetworkManager GET:kURL.car_common_getMasterBrandList parameters:nil dataTask:nil showErrorTost:YES completion:^(CYTNetworkResponse *responseObject) {
        [self.manageBrandTableView.mj_header endRefreshing];
        
        NSMutableArray *newManageBrandModels = [NSMutableArray array];
        NSMutableArray *letterArray = [NSMutableArray array];
        NSMutableArray *modelsArray = [CYTManageBrandModel mj_objectArrayWithKeyValuesArray:[responseObject.dataDictionary valueForKey:@"list"]];
        for (CYTManageBrandModel *item in modelsArray) {
            NSString *letter = [NSString string];
            if (item.spell.length>1) {
               letter = [[item.spell substringToIndex:1] uppercaseString];
            }
            if (![letterArray containsObject:letter]) {
                [letterArray addObject:letter];
                CYTManageBrandIndexModel *manageBrandIndexModel = [[CYTManageBrandIndexModel alloc] init];
                manageBrandIndexModel.letter = letter;
                [newManageBrandModels addObject:manageBrandIndexModel];
            }
        }
        for (CYTManageBrandModel *item in modelsArray) {
            NSString *letter = [NSString string];
            if (item.spell.length>=1) {
                letter = [[item.spell substringToIndex:1] uppercaseString];
            }
            for (CYTManageBrandIndexModel *manageBrandIndexModel in newManageBrandModels) {
                if ([manageBrandIndexModel.letter isEqualToString:letter]) {
                    [manageBrandIndexModel.brands addObject:item];
                }
            }
        }
        [self.brandData removeAllObjects];
        [self.brandData addObjectsFromArray:newManageBrandModels];
        for (CYTManageBrandIndexModel *item in newManageBrandModels) {
            [self.indexArray addObject:item.letter];
            [self.indexArray sortedArrayUsingSelector:@selector(compare:)];
        }
        //添加索引
        [self.view addSubview:self.indexView];
        [self.manageBrandTableView reloadData];
    }];

}


#pragma mark - <UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.brandData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    CYTManageBrandIndexModel *indexModel = self.brandData[section];
    return indexModel.brands.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CYTManageBrandCell *cell = [CYTManageBrandCell manageBrandCellForTableView:tableView indexPath:indexPath];
    CYTManageBrandIndexModel *indexModel = self.brandData[indexPath.section];
    cell.manageBrandModel = indexModel.brands[indexPath.row];
    cell.cellSelected = [self.selectedBrandsId containsObject:cell.manageBrandModel.brandId];
    return cell;
}

#pragma mark - <UITableViewDelegate>

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]init];
    headerView.backgroundColor = kFFColor_bg_nor;
    UILabel *headerLabel = [[UILabel alloc]init];
    headerLabel.font = CYTFontWithPixel(28);
    CYTManageBrandIndexModel *indexModel  = self.brandData[section];
    headerLabel.text = indexModel.letter;
    [headerView addSubview:headerLabel];
    [headerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView).offset(CYTMarginH);
        make.centerY.equalTo(headerView.mas_centerY);
    }];
    return headerView;

}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CYTManageBrandSectionHeaderH;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CYTManageBrandCellHight;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CYTManageBrandIndexModel *indexModel = self.brandData[indexPath.section];
    CYTManageBrandModel *model = indexModel.brands[indexPath.row];
    if ([self.selectedBrandsId containsObject:model.brandId]) {
        [self.selectedBrandsId removeObject:model.brandId];
        for (CYTManageBrandModel *item in [self.kvoArrayModel mutableArrayValueForKeyPath:@"modelArray"]) {
            if ([item.brandId isEqualToString:model.brandId]) {
                [[self.kvoArrayModel mutableArrayValueForKeyPath:@"modelArray"] removeObject:item];
            }
        }
        
    }else{
        if (self.selectedBrandsId.count>=CYTSelectBrandMax) {
            [CYTToast messageToastWithMessage:CYTSelectBrandMaxTip];
        }else{
            [self.selectedBrandsId addObject:model.brandId];
            [[self.kvoArrayModel mutableArrayValueForKeyPath:@"modelArray"] addObject:model];
        }

    }
    [self.manageBrandTableView reloadData];
    
}


/*
 * 返回按钮的点击
 */
- (void)backButtonClick:(UIButton *)backButton{
    if (self.confirmBtn.isHidden) {
        [CYTAlertView alertViewWithTitle:@"提示" message:@"返回后品牌选择将中断，是否确认返回？"  confirmAction:^{
            [self.navigationController popViewControllerAnimated:YES];
        } cancelAction:nil];
    }else{
        [super backButtonClick:backButton];
    }
    
}

#pragma mark - <MJNIndexViewDataSource>

- (NSArray *)sectionIndexTitlesForMJNIndexView:(MJNIndexView *)indexView{
    return self.indexArray;
}

- (void)sectionForSectionMJNIndexTitle:(NSString *)title atIndex:(NSInteger)index;{
    [self.manageBrandTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:0
                                                                       inSection:index] atScrollPosition: UITableViewScrollPositionTop     animated:YES];
}



@end
