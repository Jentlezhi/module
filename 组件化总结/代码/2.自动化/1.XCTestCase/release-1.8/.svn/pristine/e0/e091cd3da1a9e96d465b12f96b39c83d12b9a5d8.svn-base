//
//  CarFilterConditionView.m
//  CYTEasyPass
//
//  Created by xujunquan on 2017/10/12.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CarFilterConditionView.h"
#import "FFBasicSegmentItemView_triangle.h"
#import "CarFilterConditionArea_provinceModel.h"
#import "CarFilterConditionDealerTypeModel.h"
#import "CarFilterConditionAreaModel.h"

#define kMAXHeight (350)

@interface CarFilterConditionView ()
@property (nonatomic, strong) CarFilterConditionTableView *brandTable;
@property (nonatomic, strong) CarFilterConditionTableView *colorTable;
@property (nonatomic, strong) CarFilterConditionTableView *areaTable;
@property (nonatomic, strong) CarFilterConditionTableView *dealerTypeTable;

@property (nonatomic, strong) CarFilterConditionTableView *showingTable;
@property (nonatomic, strong) NSArray *itemTitleArray;

@property (nonatomic, assign) float brandTableHeight;

@end

@implementation CarFilterConditionView

- (void)ff_initWithViewModel:(id)viewModel {
    [super ff_initWithViewModel:viewModel];
    self.viewModel = viewModel;
    self.brandTableHeight = 0;
    
    //自定义segment样式=========>
    if (self.viewModel.requestModel.sourceTypeId == 1) {
        self.itemTitleArray = @[@"全部车型",@"颜色",@"区域",@"车商类型"];
    }else {
        self.itemTitleArray = @[@"全部车型",@"颜色",@"上牌地区",@"车商类型"];
    }
    
    NSMutableArray *array = [NSMutableArray array];
    for (int i=0; i<self.itemTitleArray.count; i++) {
        FFBasicSegmentItemView_triangle *item = [FFBasicSegmentItemView_triangle new];
        item.title = self.itemTitleArray[i];
        item.titleLabel.font = CYTFontWithPixel(30);
        item.triangleImageView.image = [UIImage imageNamed:@"carfilter_seg_arrNor"];
        item.vline.hidden = NO;
        [array addObject:item];
    }
    //segmentView样式自定义
    self.segmentView.type = FFBasicSegmentTypeAverage;
    self.segmentView.customItemArray = array;
    //closebutton图片
    [self.closeView.closeButton setImage:[UIImage imageNamed:@"ffCondition_close"] forState:UIControlStateNormal];
    //剪切
    [self radius:1 borderWidth:1 borderColor:[UIColor clearColor]];
    //<========================
}

- (void)ff_bindViewModel {
    @weakify(self);
    [self.viewModel.hudSubject subscribeNext:^(id x) {
        if ([x integerValue] == 0) {
            [CYTLoadingView showLoadingWithType:CYTLoadingViewTypeEditNavBar];
        }else {
            [CYTLoadingView hideLoadingView];
        }
    }];
    
    [self.viewModel.conditionGroupCommand.executionSignals.switchToLatest subscribeNext:^(FFBasicNetworkResponseModel *responseModel) {
        @strongify(self);
        self.brandTable.viewModel.leftListArray = self.viewModel.carArray;
        self.brandTable.viewModel.invalid = self.viewModel.invalid;
        self.brandTable.viewModel.rightListArray = self.viewModel.singleCarArray;
        self.brandTable.viewModel.singleCar = self.viewModel.singleCar;
        
        self.colorTable.viewModel.leftListArray = self.viewModel.colorArray;
        self.colorTable.viewModel.invalid = self.viewModel.invalid;
        
        self.areaTable.viewModel.leftListArray = self.viewModel.areaArray;
        self.areaTable.viewModel.invalid = self.viewModel.invalid;
        
        self.dealerTypeTable.viewModel.leftListArray = self.viewModel.dealerArray;
        self.dealerTypeTable.viewModel.invalid = self.viewModel.invalid;
        
        //table刷新
        [self.showingTable loadData];
        [self updateSelfHeightWithIndex:self.currentIndex];
    }];
}

- (void)ff_addSubViewAndConstraints {
    [super ff_addSubViewAndConstraints];
    
    [self insertSubview:self.brandTable atIndex:0];
    [self insertSubview:self.colorTable atIndex:0];
    [self insertSubview:self.areaTable atIndex:0];
    [self insertSubview:self.dealerTypeTable atIndex:0];
    
    [self.brandTable makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.segmentView.bottom);
        make.bottom.equalTo(self.closeView.top);
    }];
    [self.colorTable makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.segmentView.bottom);
        make.bottom.equalTo(self.closeView.top);
    }];
    [self.areaTable makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.segmentView.bottom);
        make.bottom.equalTo(self.closeView.top);
    }];
    [self.dealerTypeTable makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.segmentView.bottom);
        make.bottom.equalTo(self.closeView.top);
    }];
}

//切换tabel的展示
- (void)changeConditionTabelWithIndex:(NSInteger)index {
    CarFilterConditionTableView *table = [self getTabelWithIndex:index];
    if (!table) {
        return;
    }
    [self bringSubviewToFront:table];
    
    //判断table数据是否有，如果没有则请求，然后赋值给各个table
    BOOL needRefresh = NO;
    //无数据
    if (!self.viewModel.carArray && !self.viewModel.colorArray && !self.viewModel.areaArray && !self.viewModel.dealerArray) {
        needRefresh = YES;
    }
    //只有“全部”数据
    if (self.viewModel.colorArray.count==1&&self.viewModel.dealerArray.count==1) {
        needRefresh = YES;
    }
    
    if (needRefresh) {
        [self.viewModel.conditionGroupCommand execute:nil];
        self.showingTable = table;
    }else {
        [table loadData];
    }
}

- (CarFilterConditionTableView *)getTabelWithIndex:(NSInteger)index {
    switch (index) {
        case 0:
            return self.brandTable;
        case 1:
            return self.colorTable;
        case 2:
            return self.areaTable;
        case 3:
            return self.dealerTypeTable;
        default:
            return nil;
    }
}

///segment回调方法
- (void)segmentIndexChanged:(NSInteger)currentIndex {
    //设置item状态
    FFBasicSegmentItemView_triangle *lastItem = [self.segmentView itemWithIndex:self.lastIndex];
    FFBasicSegmentItemView_triangle *item = [self.segmentView itemWithIndex:currentIndex];
    
    if (!self.isExtend) {
        //收缩状态
        [self updateSegmentWithItem:item isExtend:NO];
    }else {
        //下拉状态
        [self updateSegmentWithItem:lastItem isExtend:NO];
        [self updateSegmentWithItem:item isExtend:YES];
        
        //更新table
        [self changeConditionTabelWithIndex:currentIndex];
    }
    
    if (self.conditionViewExtendBlock) {
        self.conditionViewExtendBlock(self.isExtend);
    }
}

#pragma mark- method
///判断字符串是不是“全部”
- (BOOL)titleIsDefault:(NSString *)title {
    if ([title isEqualToString:@"全部"]) {
        return YES;
    }
    return NO;
}

//判断字符串是不是segment的标题
- (BOOL)titleIsSegment:(NSString *)title {
    for (NSString *item in self.itemTitleArray) {
        if ([title isEqualToString:item]) {
            return YES;
        }
    }
    return NO;
}

- (NSString *)segmentString:(NSString *)title andSeriesModel:(CarFilterConditionSubbrand_seriesModel *)seriesModel andType:(CarFilterConditionTableType)type{
    
    if (type == CarFilterConditionTableCar) {
        if (!seriesModel.modelName) {
            if ([self titleIsDefault:title]) {
                return self.itemTitleArray[0];
            }
            return title;
        }else {
            NSString *seriesName = seriesModel.modelName;
            if ([self titleIsDefault:title]) {
                if ([self titleIsDefault:seriesName]) {
                    title = self.itemTitleArray[0];
                }else {
                    title = seriesName;
                }
            }else {
                title = [NSString stringWithFormat:@"%@ %@",seriesName,title];
            }
            return title;
        }
    }else {
        if ([self titleIsDefault:title]) {
            return self.itemTitleArray[type];
        }
        return title;
    }
}

- (UIFont *)fontWithString:(NSString *)string {
    BOOL isDefault = NO;
    for (NSString *itemTitle in self.itemTitleArray) {
        if ([itemTitle isEqualToString:string]) {
            isDefault = YES;
            break;
        }
    }
    return (isDefault)?CYTFontWithPixel(30):CYTFontWithPixel(26);
}

- (void)updateSegmentTitle:(NSString *)title andSeriesModel:(CarFilterConditionSubbrand_seriesModel *)seriesModel andType:(CarFilterConditionTableType)type{
    //关闭view
    [self closeConditionView];
    //获取title
    title = [self segmentString:title andSeriesModel:seriesModel andType:type];
    
    //修改item
    FFBasicSegmentItemView_triangle *item = [self.segmentView itemWithIndex:type];
    item.title = title;
    item.titleLabel.font = [self fontWithString:title];
    [self updateSegmentWithItem:item isExtend:NO];
}

- (void)updateSegmentWithItem:(FFBasicSegmentItemView_triangle *)item isExtend:(BOOL)isExtend{
    if (isExtend) {
        //拉伸
        item.triangleImageView.image = [UIImage imageNamed:@"carfilter_seg_arrHi"];
        item.titleColor = kFFColor_green;
    }else {
        //收缩
        item.triangleImageView.image = [UIImage imageNamed:@"carfilter_seg_arrNor"];
        item.titleColor = kFFColor_title_L1;
        //设置颜色和三角
        if (![self titleIsSegment:item.title]) {
            item.triangleImageView.image = [UIImage imageNamed:@"carfilter_seg_arrSel"];
            item.titleColor = kFFColor_green;
        }
    }
}

#pragma mark- height
- (float)extendContentHeightWithIndex:(NSInteger)index {
    return [self tableHeightWithIndex:index];
}

- (float)tableHeightWithIndex:(NSInteger)index {
    //默认值
    float height=0;
    
    if (index==0) {
        //车款
        height = self.brandTableHeight;
    }else if (index==1) {
        //颜色
        height = CYTAutoLayoutV(80)*self.viewModel.colorArray.count;
    }else if (index==2) {
        //地区
        NSInteger section = self.viewModel.areaArray.count-1;
        NSInteger row = 0;
        for (CarFilterConditionAreaModel *group in self.viewModel.areaArray) {
            row = row+group.provinces.count;
        }
        height = CYTAutoLayoutV(80)*row+CYTAutoLayoutV(40)*section;
    }else if (index==3) {
        //经销商
        height = CYTAutoLayoutV(80)*self.viewModel.dealerArray.count;
    }
    //取最小值
    return MIN(kMAXHeight, height);
}

- (void)updateSingleSeriesHeight:(float)height {
    self.brandTableHeight = height;
    [self updateSelfHeightWithIndex:self.currentIndex];
}

#pragma mark- api
- (void)updateSegmentTitleWithModel:(id)model andSeriesModel:(CarFilterConditionSubbrand_seriesModel *)seriesModel andType:(CarFilterConditionTableType)type{
    switch (type) {
        case CarFilterConditionTableCar:
        {
            CYTBrandSelectCarModel *carModel = (CYTBrandSelectCarModel *)model;
            NSString *name = carModel.carName;
            [self updateSegmentTitle:name andSeriesModel:seriesModel andType:type];
        }
            break;
        case CarFilterConditionTableColor:
        {
            CarFilterConditionColorModel *color = (CarFilterConditionColorModel *)model;
            NSString *name = color.name;
            [self updateSegmentTitle:name andSeriesModel:seriesModel andType:type];
        }
            break;
        case CarFilterConditionTableArea:
        {
            CarFilterConditionArea_provinceModel *area = (CarFilterConditionArea_provinceModel *)model;
            NSString *name = area.name;
            [self updateSegmentTitle:name andSeriesModel:seriesModel andType:type];
        }
            break;
        case CarFilterConditionTableDealer:
        {
            CarFilterConditionDealerTypeModel *dealer = (CarFilterConditionDealerTypeModel *)model;
            NSString *name = dealer.levelName;
            [self updateSegmentTitle:name andSeriesModel:seriesModel andType:type];
        }
            break;
        default:
            break;
    }
}

#pragma mark- get
- (CarFilterConditionTableView *)brandTable {
    if (!_brandTable) {
        CarFilterConditionTableVM *vm = [CarFilterConditionTableVM new];
        vm.conditionViewRef = self;
        vm.type = CarFilterConditionTableCar;
        vm.requestModel = self.viewModel.requestModel;
        vm.listRequestModel = self.viewModel.listRequestModel;
        vm.invalid = self.viewModel.invalid;
        _brandTable = [[CarFilterConditionTableView alloc] initWithViewModel:vm];
    }
    return _brandTable;
}

- (CarFilterConditionTableView *)colorTable {
    if (!_colorTable) {
        CarFilterConditionTableVM *vm = [CarFilterConditionTableVM new];
        vm.conditionViewRef = self;
        vm.type = CarFilterConditionTableColor;
        vm.requestModel = self.viewModel.requestModel;
        vm.listRequestModel = self.viewModel.listRequestModel;
        vm.invalid = self.viewModel.invalid;
        _colorTable = [[CarFilterConditionTableView alloc] initWithViewModel:vm];
    }
    return _colorTable;
}

- (CarFilterConditionTableView *)areaTable {
    if (!_areaTable) {
        CarFilterConditionTableVM *vm = [CarFilterConditionTableVM new];
        vm.conditionViewRef = self;
        vm.type = CarFilterConditionTableArea;
        vm.requestModel = self.viewModel.requestModel;
        vm.listRequestModel = self.viewModel.listRequestModel;
        vm.invalid = self.viewModel.invalid;
        _areaTable = [[CarFilterConditionTableView alloc] initWithViewModel:vm];
    }
    return _areaTable;
}

- (CarFilterConditionTableView *)dealerTypeTable {
    if (!_dealerTypeTable) {
        CarFilterConditionTableVM *vm = [CarFilterConditionTableVM new];
        vm.conditionViewRef = self;
        vm.type = CarFilterConditionTableDealer;
        vm.requestModel = self.viewModel.requestModel;
        vm.listRequestModel = self.viewModel.listRequestModel;
        vm.invalid = self.viewModel.invalid;
        _dealerTypeTable = [[CarFilterConditionTableView alloc] initWithViewModel:vm];
    }
    return _dealerTypeTable;
}

@end
