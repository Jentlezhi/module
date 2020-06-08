//
//  CYTCarSourcePublishVM.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/5/25.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCarSourcePublishVM.h"
#import "CYTGetColorBasicVM.h"
#import "CarSourceDetailModel.h"
#import "CYTSelectImageModel.h"
#import "CYTBrandSelectResultModel.h"

@interface CYTCarSourcePublishVM ()
@property (nonatomic, strong) NSArray *titleArray;

@end

@implementation CYTCarSourcePublishVM
@synthesize requestCommand = _requestCommand;

- (NSMutableArray<NSArray *> *)listArray{
    if (!_listArray) {
        _listArray = [NSMutableArray array];
    }
    return _listArray;
}

- (NSMutableArray<CYTCarSourcePublishItemModel *> *)necessaryArray{
    if (!_necessaryArray) {
        _necessaryArray = [NSMutableArray array];
    }
    return _necessaryArray;
}

- (NSMutableArray<CYTCarSourcePublishItemModel *> *)inecessaryArray{
    if (!_inecessaryArray) {
        _inecessaryArray = [NSMutableArray array];
    }
    return _inecessaryArray;
}

- (void)ff_initWithModel:(FFExtendModel *)model {
    [super ff_initWithModel:model];
    self.backSubject = [RACSubject new];
    self.haveEdit = NO;
    self.carSourceTypeIndexPath = [NSIndexPath indexPathForRow:-1 inSection:-1];
    
//    self.listArray = [NSMutableArray array];
//    self.necessaryArray = [NSMutableArray array];
//    self.inecessaryArray = [NSMutableArray array];
    
    ///必填字段
    [self getNecessaryInfo];
    ///可选字段
    [self getInecessaryInfo];
    
    [self.listArray addObject:self.necessaryArray];
    [self.listArray addObject:self.inecessaryArray];
    
}

- (void)handleEditNecessoryWithModel:(CarSourceDetailModel *)model {
    CYTCarSourceInfoModel *infoModel = model.carSourceInfo;
    //处理成需要的信息
    
    //处理品牌车型
    CYTCarSourcePublishItemModel *itemModel0 = [CYTCarSourcePublishItemModel new];
    itemModel0.select = YES;
    itemModel0.index = 1;
    itemModel0.title = @"品牌车型";
    itemModel0.content = [NSString stringWithFormat:@"%@%@",infoModel.brandName,infoModel.serialName];
    NSString *year = (infoModel.carYearType == 0)?@"":[NSString stringWithFormat:@"%ld 款",infoModel.carYearType];
    itemModel0.assistanceString = [NSString stringWithFormat:@"%@ %@",year,infoModel.carName];
    CYTCarBrandModel *carModel = [CYTCarBrandModel new];
    carModel.brandId = @"";
    carModel.seriesId = [NSString stringWithFormat:@"%ld",infoModel.serialId];
    carModel.carId = @"";
    carModel.customCar = @"";
    itemModel0.carModel = carModel;
    
    [self.necessaryArray addObject:itemModel0];
    
    
    //车源类型
    CYTCarSourcePublishItemModel *itemModel1 = [CYTCarSourcePublishItemModel new];
    CYTCarSourceTypeModel *typeModel = [CYTCarSourceTypeModel new];
    typeModel.carSourceTypeId = 0;
    typeModel.carSourceTypeName = infoModel.carSourceTypeName;
    itemModel1.carSourceTypeModel = typeModel;
    itemModel1.select = YES;
    itemModel1.index = 0;
    itemModel1.title = @"车源类型";
    itemModel1.hideArrow = YES;
    itemModel1.content = infoModel.carSourceTypeName;
    
    [self.necessaryArray addObject:itemModel1];
    
    //指导价
    CYTCarSourcePublishItemModel *itemModel2 = [CYTCarSourcePublishItemModel new];
    itemModel2.select = YES;
    itemModel2.index = 3;
    itemModel2.title = @"指导价";
    itemModel2.assistanceString = @"";
    itemModel2.content = infoModel.carReferPrice;
    if ([infoModel.carReferPrice isEqualToString:@"0"]) {
        itemModel2.content = @"暂无";
    }else {
        itemModel2.assistanceString = @"万元";
        itemModel2.select = YES;
    }
    //报价控件使用
    self.guidePrice = infoModel.carReferPrice;
    
    [self.necessaryArray addObject:itemModel2];
    
    //颜色
    CYTCarSourcePublishItemModel *itemModel3 = [CYTCarSourcePublishItemModel new];
    itemModel3.select = YES;
    itemModel3.index = 2;
    itemModel3.title = @"颜色";
    NSString *exColor = infoModel.exteriorColor;
    if (exColor.length == 0) {
        exColor = @"";
    }else {
        if (exColor.length>7) {
            exColor = [exColor substringToIndex:7];
            exColor = [NSString stringWithFormat:@"%@...",exColor];
        }
        exColor = [NSString stringWithFormat:@"%@/",exColor];
    }
    itemModel3.content = [NSString stringWithFormat:@"%@%@",exColor,infoModel.interiorColor];
    itemModel3.inColorSel = infoModel.interiorColor;
    itemModel3.exColorSel  = infoModel.exteriorColor;
    
    [self.necessaryArray addObject:itemModel3];
    
    //车原地
    CYTCarSourcePublishItemModel *itemModel4 = [CYTCarSourcePublishItemModel new];
    itemModel4.select = YES;
    itemModel4.index = 6;
    itemModel4.title = @"车源地";
    itemModel4.content = infoModel.carSourceAddress;
    CYTAddressDataWNCManager *locationModel = [CYTAddressDataWNCManager new];
    CYTAddressDataItemModel *addressModel = [CYTAddressDataItemModel new];
    addressModel.locationGroupID = [infoModel.locationGroupId integerValue];
    addressModel.idCode = [infoModel.provinceId integerValue];
    locationModel.addressModel.selectProvinceModel = addressModel;
    locationModel.addressModel.selectProvinceModel.name = @"name";
    locationModel.addressModel.oriProvinceId = [infoModel.provinceId integerValue];
    locationModel.addressModel.oriAreaId = [infoModel.locationGroupId integerValue];
    if (locationModel.addressModel.oriProvinceId > 0) {
        locationModel.addressModel.oriAreaId = -10;
    }
    itemModel4.carSourceLocationModel = locationModel;
    
    [self.necessaryArray addObject:itemModel4];
    
    //车源状态
    CYTCarSourcePublishItemModel *itemModel5 = [CYTCarSourcePublishItemModel new];
    itemModel5.select = YES;
    itemModel5.title = @"车源状态";
    itemModel5.carSourceStatus = model.carSourceInfo.goodsStatus;
    //判断是否显示车源状态
    BOOL showCarSourceStatus = [model.carSourceInfo.goodsType integerValue] != 3;
    if (showCarSourceStatus) {
        [self.necessaryArray addObject:itemModel5];
    }
    
    //到港日期
    CYTCarSourcePublishItemModel *itemModel6 = [CYTCarSourcePublishItemModel new];
    itemModel6.select = YES;
    itemModel6.index = 5;
    itemModel6.title = @"到港日期";
    itemModel6.content = infoModel.arrivalDateDesc;
    BOOL isFuture =  model.carSourceInfo.goodsStatus == 2;
    BOOL showArriveData = showCarSourceStatus&&isFuture;
    if (showArriveData) {
        [self.necessaryArray addObject:itemModel6];
    }

    //报价
    CYTCarSourcePublishItemModel *itemModel7 = [CYTCarSourcePublishItemModel new];
    itemModel7.index = 4;
    itemModel7.title = @"报价";
    itemModel7.assistanceString = @" 万元";
    itemModel7.content = infoModel.salePrice;
    if (itemModel7.content.length == 0 || [itemModel7.content isEqualToString:@"0"]) {
        itemModel7.content = @"不填写则显示”电议“";
    }else {
        itemModel7.select = YES;
    }
    [self.necessaryArray addObject:itemModel7];
    
    
}

- (void)handleEditInecessoryWithModel:(CarSourceDetailModel *)model {
    CYTCarSourceInfoModel *infoModel = model.carSourceInfo;
    //配置
    CYTCarSourcePublishItemModel *itemModel0 = [CYTCarSourcePublishItemModel new];
    itemModel0.content = infoModel.carConfigure;
    itemModel0.index = 0;
    itemModel0.title = @"配置";
    itemModel0.placeholder = @"请填写";
    if (itemModel0.content.length>0) {
        itemModel0.select = YES;
    }
    
    //手续
    CYTCarSourcePublishItemModel *itemModel1 = [CYTCarSourcePublishItemModel new];
    itemModel1.content = infoModel.carProcedures;
    itemModel1.index = 1;
    itemModel1.title = @"手续";
    itemModel1.placeholder = @"请选择";
    if (itemModel1.content.length>0) {
        itemModel1.select = YES;
    }
    
    //可售区域
    CYTCarSourcePublishItemModel *itemModel2 = [CYTCarSourcePublishItemModel new];
    itemModel2.content = infoModel.salableArea;
    itemModel2.index = 2;
    itemModel2.title = @"可售区域";
    itemModel2.placeholder = @"请填写";
    if (itemModel2.content.length>0) {
        itemModel2.select = YES;
    }
    
    //图片
    CYTCarSourcePublishItemModel *itemModel3 = [CYTCarSourcePublishItemModel new];
    itemModel3.index = 3;
    itemModel3.title = @"图片";
    itemModel3.placeholder = @"请添加";
    
    NSArray *imageArray = model.media;
    NSMutableArray *imageModelArray = [NSMutableArray array];
    for (int i=0; i<imageArray.count; i++) {
        NSDictionary *dic = imageArray[i];
        CYTSelectImageModel *imodel = [CYTSelectImageModel new];
        imodel.imageURL = dic[@"imageUrl"];
        imodel.fileID = dic[@"mediaId"];
        [itemModel3.fileIdImageArray addObject:imodel.fileID];
        [imageModelArray addObject:imodel];
    }
    itemModel3.imageArray = [imageModelArray mutableCopy];
    NSString *numberString;
    if (model.media.count>0) {
        numberString = [NSString stringWithFormat:@"%ld张",model.media.count];
        itemModel3.content = numberString;
        itemModel3.select = YES;
    }
    
    //备注
    CYTCarSourcePublishItemModel *itemModel4 = [CYTCarSourcePublishItemModel new];
    itemModel4.index = 4;
    itemModel4.title = @"备注";
    itemModel4.placeholder = @"请填写";
    itemModel4.content = infoModel.remark;
    if (itemModel4.content.length>0) {
        itemModel4.select = YES;
    }
    
    //放入数组中
    [self.inecessaryArray addObject:itemModel0];
    [self.inecessaryArray addObject:itemModel1];
    [self.inecessaryArray addObject:itemModel2];
    [self.inecessaryArray addObject:itemModel3];
    [self.inecessaryArray addObject:itemModel4];
}

//判断是不是期货
- (BOOL)isQiHuoWithModel:(CarSourceDetailModel *)model {
    CYTCarSourceInfoModel *infoModel = model.carSourceInfo;
    if (infoModel.arrivalDateDesc.length>0) {
        return YES;
    }
    return NO;
}

#pragma mark-

- (void)getNecessaryInfo {
    //0-车源类型
    CYTCarSourcePublishItemModel *item0 = [CYTCarSourcePublishItemModel new];
    item0.index = 0;
    item0.title = @"品牌车型";
    [self.necessaryArray addObject:item0];
    
    //1-品牌
    CYTCarSourcePublishItemModel *item1 = [CYTCarSourcePublishItemModel new];
    item1.index = 1;
    item1.title = @"车源类型";
    item1.placeholder = @"";
    item1.hideArrow = YES;
    [self.necessaryArray addObject:item1];
    
    //2-指导价
    CYTCarSourcePublishItemModel *item2 = [CYTCarSourcePublishItemModel new];
    item2.index = 2;
    item2.title = @"指导价";
    item2.assistanceString = @"";
    item2.placeholder = @"";
    [self.necessaryArray addObject:item2];
    
    //3-颜色
    CYTCarSourcePublishItemModel *item3 = [CYTCarSourcePublishItemModel new];
    item3.index = 3;
    item3.title = @"颜色";
    [self.necessaryArray addObject:item3];
    
    //4-车源地
    CYTCarSourcePublishItemModel *item4 = [CYTCarSourcePublishItemModel new];
    item4.index = 4;
    item4.title = @"车源地";
    [self.necessaryArray addObject:item4];
    
    //6-报价
    CYTCarSourcePublishItemModel *item6 = [CYTCarSourcePublishItemModel new];
    item6.index = 6;
    item6.title = @"报价";
    
    item6.content = @"不填写则显示“电议”";
    item6.assistanceString = @" 万元";
    [self.necessaryArray addObject:item6];
}


- (void)handelCarSourceStateWithAddData:(BOOL)add{
    NSString *carSourceStateTitle = @"车源状态";
    if (add) {
        CYTCarSourcePublishItemModel *item5 = [CYTCarSourcePublishItemModel new];
        item5.index = 5;
        item5.title = carSourceStateTitle;
        [self.necessaryArray addObject:item5];
    }else{
        NSMutableArray *tempArray = NSMutableArray.new;
        [self.necessaryArray enumerateObjectsUsingBlock:^(CYTCarSourcePublishItemModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.title isEqualToString:carSourceStateTitle]) {
                [tempArray addObject:obj];
            }
        }];
        [self.necessaryArray removeObjectsInArray:tempArray];
    }
}



- (void)getInecessaryInfo {
    //0-配置
    CYTCarSourcePublishItemModel *item0 = [CYTCarSourcePublishItemModel new];
    item0.index = 0;
    item0.title = @"配置";
    item0.placeholder = @"请填写";
    [self.inecessaryArray addObject:item0];
    
    //1-手续
    CYTCarSourcePublishItemModel *item1 = [CYTCarSourcePublishItemModel new];
    item1.index = 1;
    item1.title = @"手续";
    item1.placeholder = @"请选择";
    [self.inecessaryArray addObject:item1];
    
    //2-可售区域
    CYTCarSourcePublishItemModel *item2 = [CYTCarSourcePublishItemModel new];
    item2.index = 2;
    item2.title = @"可售区域";
    item2.placeholder = @"请填写";
    [self.inecessaryArray addObject:item2];
    
    //3-图片
    CYTCarSourcePublishItemModel *item3 = [CYTCarSourcePublishItemModel new];
    item3.index = 3;
    item3.title = @"图片";
    item3.placeholder = @"请添加";
    [self.inecessaryArray addObject:item3];
    
    //4-备注
    CYTCarSourcePublishItemModel *item4 = [CYTCarSourcePublishItemModel new];
    item4.index = 4;
    item4.title = @"备注";
    item4.placeholder = @"请填写";
    [self.inecessaryArray addObject:item4];
}


#pragma mark- method
- (NSString *)titleForHeaderWithSection:(NSInteger)section {
    return (section == 0)?@"车辆基本信息（必填）":@"车辆基本信息（选填）";
}
- (BOOL)selectCarBrand {
    CYTCarSourcePublishItemModel *itemModel = [self necessaryItemModelWithTitle:@"品牌车型"];
    return itemModel.select;
}

- (BOOL)selectCarSourceType {
    CYTCarSourcePublishItemModel *itemModel = [self necessaryItemModelWithTitle:@"车源类型"];
    return itemModel.select;
}
- (BOOL)selectCarSourceStatus{
    CYTCarSourcePublishItemModel *itemModel = [self necessaryItemModelWithTitle:@"车源状态"];
    return itemModel.select;
}

- (BOOL)selectColor{
    CYTCarSourcePublishItemModel *itemModel = [self necessaryItemModelWithTitle:@"颜色"];
    return itemModel.content.length;
}

- (BOOL)selectCarSourceAddress{
    CYTCarSourcePublishItemModel *itemModel = [self necessaryItemModelWithTitle:@"车源地"];
    return itemModel.select;
}

- (BOOL)selectArriveData{
    CYTCarSourcePublishItemModel *itemModel = [self necessaryItemModelWithTitle:@"到港日期"];
    return itemModel.select;
}

- (NSString *)colorString {
    CYTCarSourcePublishItemModel *itemModel = [self necessaryItemModelWithTitle:@"颜色"];
    if (itemModel.inColorSel && itemModel.exColorSel) {
        NSString *exColor = itemModel.exColorSel;
        if (exColor.length>7) {
            exColor = [exColor substringToIndex:7];
            exColor = [NSString stringWithFormat:@"%@...",exColor];
        }
        
        NSString *str = [NSString stringWithFormat:@"%@/%@",exColor,itemModel.inColorSel];
        return str;
    }
    return @"";
}

- (NSString *)carSourceLocationString {
    CYTCarSourcePublishItemModel *itemModel = [self necessaryItemModelWithTitle:@"车源地"];
    if (itemModel.carSourceLocationModel) {
        NSString *string  = itemModel.carSourceLocationModel.addressModel.selectProvinceModel.name;
        return string;
    }
    return @"";
}

- (NSString *)arrivalDateString {
    CYTCarSourcePublishItemModel *itemModel = [self necessaryItemModelWithTitle:@"到港日期"];
    if (itemModel.arrivalModel) {
        NSString *string = [NSString stringWithFormat:@"%@ %@",itemModel.arrivalModel.month,itemModel.arrivalModel.name];
        return string;
    }
    return @"";
}

- (void)handlePriceWithMode:(NSInteger)mode andValue:(NSString *)value andResultString:(NSString *)resultString {
    CYTCarSourcePublishItemModel *priceModel = [self necessaryItemModelWithTitle:@"报价"];
    priceModel.select = YES;
    priceModel.priceMode = mode+1;
    priceModel.priceValue = value;
    priceModel.content = resultString;
}

- (BOOL)canSubmit{
    CYTCarSourcePublishItemModel *carSourceSatausItem = [self necessaryItemModelWithTitle:@"车源状态"];
    CYTCarSourcePublishItemModel *arriveDataItem = [self necessaryItemModelWithTitle:@"到港日期"];
    BOOL isMadeInCina = !carSourceSatausItem;
    BOOL selectCarSourceStatus = isMadeInCina?YES:self.selectCarSourceStatus;
    BOOL isFutures = arriveDataItem;
    BOOL selectArriveData = isFutures?self.selectArriveData:YES;
    return self.selectCarSourceType && self.selectCarBrand && self.selectColor && self.selectCarSourceAddress && selectCarSourceStatus && selectArriveData;
}

#pragma mark- 处理指导价搜索数据
- (void)handleSearchModel:(CYTStockCarModel *)model {
    //清空回显
    self.carSourceTypeIndexPath = nil;
    //品牌车型
    CYTCarSourcePublishItemModel *itemModel0 = [self necessaryItemModelWithTitle:@"品牌车型"];
    itemModel0.select = YES;
    itemModel0.content = [NSString stringWithFormat:@"%@%@",model.brandName,model.serialName];
    NSString *year = (model.carYearType == 0)?@"":[NSString stringWithFormat:@"%ld 款",model.carYearType];
    itemModel0.assistanceString = [NSString stringWithFormat:@"%@ %@",year,model.carName];
    CYTCarBrandModel *carModel = [CYTCarBrandModel new];
    carModel.brandId = [NSString stringWithFormat:@"%ld",model.brandId];
    carModel.seriesId = [NSString stringWithFormat:@"%ld",model.serialId];
    carModel.carId = [NSString stringWithFormat:@"%ld",model.carId];
    carModel.customCar = @"";
    itemModel0.carModel = carModel;
    //车源类型
    CYTCarSourcePublishItemModel *itemModel1 = [self necessaryItemModelWithTitle:@"车源类型"];
    CYTCarSourceTypeModel *typeModel = [CYTCarSourceTypeModel new];
    typeModel.carSourceTypeId = model.carSourceTypeId;
    typeModel.carSourceTypeName = model.carSourceTypeName;
    //一定是国产合资的车，写死
    typeModel.isGuoChan = YES;
    itemModel1.carSourceTypeModel = typeModel;
    itemModel1.select = YES;
    itemModel1.content = model.carSourceTypeName;
    
    //指导价
    [self handleGuidePrice:model.carReferPrice];
    //颜色
    CYTCarSourcePublishItemModel *itemModel3 = [self necessaryItemModelWithTitle:@"颜色"];
    itemModel3.inColorSel = @"";
    itemModel3.exColorSel = @"";
    itemModel3.content = @"";
    itemModel3.select = NO;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.requestColorCommand execute:nil];
    });
    //清除车源状态和到港日期
    [self removeNecessaryItemWithTitle:@"车源状态"];
    [self removeNecessaryItemWithTitle:@"到港日期"];
    //报价
    CYTCarSourcePublishItemModel *itemModel4 = [self necessaryItemModelWithTitle:@"报价"];
    itemModel4.assistanceString = @" 万元";
    itemModel4.content = @"不填写则显示”电议“";
    itemModel4.select = NO;

    //刷新页面
    [self.reloadSubject sendNext:@""];
}

- (RACCommand *)requestColorCommand {
    if (!_requestColorCommand) {
        _requestColorCommand = [self commandWithRequestModel:^FFBasicNetworkRequestModel *{
            FFBasicNetworkRequestModel *model = [FFBasicNetworkRequestModel new];
            model.methodType = NetRequestMethodTypeGet;
            model.requestURL = kURL.car_common_getCarSeriesColor;
            model.needHud = YES;
            CYTCarSourcePublishItemModel *itemModel1 = [self necessaryItemModelWithTitle:@"品牌车型"];
            NSString *SerialId = itemModel1.carModel.seriesId;
            NSMutableDictionary *parameters = NSMutableDictionary.new;
            [parameters setValue:SerialId forKey:@"CarSerialId"];
            model.requestParameters = parameters;
            return model;
        } andHandle:^(FFBasicNetworkResponseModel *resultModel) {
            if (resultModel.resultEffective) {
                NSDictionary *colorDic = resultModel.dataDictionary;
                NSArray *exColorArray = [CYTGetColorBasicVM colorArray:colorDic[@"exteriorColors"] withType:CarColorTypeColorAll];
                self.exColorArray = exColorArray;
                NSArray *inColorArray = [CYTGetColorBasicVM colorArray:colorDic[@"interiorColors"] withType:CarColorTypeColorAll];
                self.inColorArray = inColorArray;
            }
        }];
    }
    return _requestColorCommand;
}

#pragma mark- 选择车源类型和车款清空数据
- (void)clearWithType:(NSInteger)type {
    if (type == 0) {
        //品牌车型,指导价
        [self clearCarModel];
        [self clearGuidePrice];
    }
    
    [self clearColor];
    [self clearPrice];
    [self clearArriveDate];
    [self clearCarSourceArea];
    //全部非必填字段
    [self clearAllInecessory];
}

- (void)clearCarModel {
    //1-品牌
    CYTCarSourcePublishItemModel *item1 = [CYTCarSourcePublishItemModel new];
    item1.index = 1;
    item1.title = @"品牌车型";
    [self.necessaryArray replaceObjectAtIndex:1 withObject:item1];
}

- (void)clearColor {
    //2-颜色
    CYTCarSourcePublishItemModel *item2 = [CYTCarSourcePublishItemModel new];
    item2.index = 2;
    item2.title = @"颜色";
    [self.necessaryArray replaceObjectAtIndex:2 withObject:item2];
}

//清空到港日期
- (void)clearArriveDate {
    for (CYTCarSourcePublishItemModel *model in self.necessaryArray) {
        if (model.index == 5) {
            model.select = NO;
            model.content = @"";
        }
    }
}

///清空车原地
- (void)clearCarSourceArea {
    CYTCarSourcePublishItemModel *item6 = [CYTCarSourcePublishItemModel new];
    item6.index = 6;
    item6.title = @"车源地";
    NSInteger index = self.necessaryArray.count-1;
    [self.necessaryArray replaceObjectAtIndex:index withObject:item6];
}

- (void)clearGuidePrice {
    //3-指导价
    CYTCarSourcePublishItemModel *item3 = [CYTCarSourcePublishItemModel new];
    item3.index = 3;
    item3.title = @"指导价";
    item3.assistanceString = @"";
    [self.necessaryArray replaceObjectAtIndex:3 withObject:item3];
}

- (void)clearPrice {
    //清空报价
    CYTCarSourcePublishItemModel *item4 = [CYTCarSourcePublishItemModel new];
    item4.index = 4;
    item4.title = @"报价";
    item4.content = @"不填写则显示“电议”";
    item4.assistanceString = @" 万元";
    [self.necessaryArray replaceObjectAtIndex:4 withObject:item4];
}

- (void)clearAllInecessory {
    [self.inecessaryArray removeAllObjects];
    [self getInecessaryInfo];
}

#pragma mark- method

#pragma mark- 品牌车型的选择
- (void)handleCarBrandData:(CYTBrandSelectResultModel *)brandModel {
    self.brandSelectModel = brandModel;
    CYTCarSourcePublishItemModel *itemModel = [self necessaryItemModelWithTitle:@"品牌车型"];
    CYTCarBrandModel *carModel = [CYTCarBrandModel new];
    itemModel.carModel = carModel;

    //车源类型处理
    [self handleCarSourceWithModel:brandModel];
    
    //指导价处理
    [self handleGuidePrice:brandModel.carModel.carReferPrice];
    
    //颜色处理
    [self handleColorWithModel:brandModel];

    //车源地处理
    [self handleCarSourceAddressWithModel:brandModel];
    //车源状态处理
    [self handleCarSourceStatusWithModel:brandModel];
    
    //清除到港日期
    [self removeNecessaryItemWithTitle:@"到港日期"];
    
    //报价处理
    [self handleOfficePriceWithModel:brandModel];
    
    carModel.brandId = [NSString stringWithFormat:@"%ld",brandModel.subBrandId];
    carModel.seriesId = [NSString stringWithFormat:@"%ld",brandModel.seriesModel.serialId];
    carModel.carId = [NSString stringWithFormat:@"%ld",brandModel.carModel.carId];

    if (brandModel.carModel.carId == -1) {
        
        NSString *customName = brandModel.carModel.carName;
        //自定义车款
        carModel.customCar = YES;
        carModel.customCarName = customName;
        carModel.totalName = [NSString stringWithFormat:@"%@ %@",brandModel.seriesModel.serialName,customName];
        
        itemModel.select = YES;
        itemModel.content = brandModel.seriesModel.serialName;
        itemModel.assistanceString = customName;
    }else {
        //不是自定义车款
        carModel.customCar = NO;
        carModel.totalName = [NSString stringWithFormat:@"%@ %@",brandModel.seriesModel.serialName,brandModel.carModel.carName];
        itemModel.select = YES;
        itemModel.content = brandModel.seriesModel.serialName;
        itemModel.assistanceString = brandModel.carModel.carName;
    }
    
    //请求颜色数据
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.requestColorCommand execute:nil];
    });
    
    //清空选填项数据
    [self cleanUnnecessaryData];
}

- (void)handleCarSourceStatusWithModel:(CYTBrandSelectResultModel *)model{
    NSString *carSourceStatusTitle = @"车源状态";
    if ([model.seriesModel.type integerValue] == 3) {
        [self removeNecessaryItemWithTitle:carSourceStatusTitle];
    }else{
        if (![self containNecessaryItemWithTitle:@"车源状态"]) {
            CYTCarSourcePublishItemModel *carStatusModel = CYTCarSourcePublishItemModel.new;
            carStatusModel.title = @"车源状态";
            [self addNecessaryItemWithModel:carStatusModel beforeTitle:@"报价"];
        }else{
            CYTCarSourcePublishItemModel *carStatusModel = [self necessaryItemModelWithTitle:carSourceStatusTitle];
            carStatusModel.carSourceStatus = 0;
        }
    }
}

- (void)handleCarSourceWithModel:(CYTBrandSelectResultModel *)model{
    //清空回显
    self.carSourceTypeIndexPath = nil;
    CYTCarSourcePublishItemModel *itemModel = [self necessaryItemModelWithTitle:@"车源类型"];
    BOOL isParallelImportCustomCar = model.seriesModel.isParallelImportCar && model.carModel.carId == -1;
    itemModel.hideArrow = !isParallelImportCustomCar;
    if (isParallelImportCustomCar) {
        itemModel.placeholder = @"请选择";
        itemModel.content = @"";
        itemModel.select = NO;
    }else{
        itemModel.placeholder = @"";
        itemModel.content = model.carModel.typeName;
        itemModel.select = model.carModel.typeName.length;
    }
    CYTCarSourceTypeModel *carSourceTypeModel = CYTCarSourceTypeModel.new;
    carSourceTypeModel.carSourceTypeId = [model.carModel.type integerValue];
    itemModel.carSourceTypeModel = carSourceTypeModel;
    
}

- (void)handleColorWithModel:(CYTBrandSelectResultModel *)model{
    CYTCarSourcePublishItemModel *itemModel = [self necessaryItemModelWithTitle:@"颜色"];
    itemModel.inColorSel = @"";
    itemModel.exColorSel = @"";
    itemModel.content = @"";
    itemModel.select = NO;
}

- (void)handleCarSourceAddressWithModel:(CYTBrandSelectResultModel *)model{
    CYTCarSourcePublishItemModel *itemModel = [self necessaryItemModelWithTitle:@"车源地"];
    itemModel.content = @"";
    itemModel.select = NO;
    itemModel.carSourceLocationModel = nil;
}

- (void)handleOfficePriceWithModel:(CYTBrandSelectResultModel *)model{
    CYTCarSourcePublishItemModel *itemModel = [self necessaryItemModelWithTitle:@"报价"];
    itemModel.assistanceString = @" 万元";
    itemModel.content = @"不填写则显示”电议“";
    itemModel.select = NO;
}

- (void)handleGuidePrice:(NSString *)guidePrice{
    NSString *assistant = @"";
    
    if ([guidePrice isEqualToString:@"0"]) {
        guidePrice = @"暂无";
        assistant = @"";
    }else {
        assistant = @" 万元";
    }
    
    self.guidePrice = guidePrice;
    
    CYTCarSourcePublishItemModel *itemModel = [self necessaryItemModelWithTitle:@"指导价"];
    itemModel.content = guidePrice;
    itemModel.assistanceString = assistant;
    itemModel.select = YES;
}

/**
 *  清空选填项数据
 */
- (void)cleanUnnecessaryData{
   CYTCarSourcePublishItemModel *itemModel0 = [self unnecessaryItemModelWithTitle:@"配置"];
    itemModel0.content = @"";
    itemModel0.select = NO;
    CYTCarSourcePublishItemModel *itemModel1 = [self unnecessaryItemModelWithTitle:@"手续"];
    itemModel1.content = @"";
    itemModel1.select = NO;
    CYTCarSourcePublishItemModel *itemModel2 = [self unnecessaryItemModelWithTitle:@"可售区域"];
    itemModel2.content = @"";
    itemModel2.select = NO;
    CYTCarSourcePublishItemModel *itemModel3 = [self unnecessaryItemModelWithTitle:@"图片"];
    itemModel3.imageArray = NSMutableArray.new;
    itemModel3.content = @"";
    itemModel3.select = NO;
    CYTCarSourcePublishItemModel *itemModel4 = [self unnecessaryItemModelWithTitle:@"备注"];
    itemModel4.content = @"";
    itemModel4.select = NO;
}

#pragma mark- 车源类型的选择
- (void)handleCarSourceData:(CYTCarSourceTypeModel *)model {
    CYTCarSourcePublishItemModel *itemModel = [self necessaryItemModelWithTitle:@"车源类型"];
    itemModel.carSourceTypeModel = model;
    itemModel.select = YES;
    itemModel.content = model.carSourceTypeName;
    itemModel.carSourceTypeModel = model;
    self.carSourceTypeIndexPath = model.indexPath;
    
    NSString *carSourceStatusTitle = @"车源状态";
    if (![self containNecessaryItemWithTitle:carSourceStatusTitle]) {
        CYTCarSourcePublishItemModel *carStatusModel = CYTCarSourcePublishItemModel.new;
        carStatusModel.title = carSourceStatusTitle;
        [self addNecessaryItemWithModel:carStatusModel beforeTitle:@"报价"];
    }
    
}


#pragma mark- 根据车源类型不同增减数据
- (void)modifyShowView {

    CYTCarSourcePublishItemModel *itemModel = self.necessaryArray[0];
    CYTCarSourceTypeModel *typeModel = itemModel.carSourceTypeModel;
    if (typeModel.status == 0 && !typeModel.isGuoChan ) {
        //期货
        //增加到港日期
        [self handleArriveTimeAdd:YES];
    }else {
        //非期货
        //删除到港日期
        [self handleArriveTimeAdd:NO];
    }
}

- (void)handleArriveTimeAdd:(BOOL)add {
    //获取index
    NSInteger index = -1;
    CYTCarSourcePublishItemModel *theModel;
    for (int i=0; i<self.necessaryArray.count; i++) {
        CYTCarSourcePublishItemModel *itemModel = self.necessaryArray[i];
        if (itemModel.index == 5) {
            index = i;
            theModel = itemModel;
            break;
        }
    }
    
    if (index == -1) {
        if (add) {
            //添加
            //5-到港日期
            CYTCarSourcePublishItemModel *item5 = [CYTCarSourcePublishItemModel new];
            item5.index = 5;
            item5.title = @"到港日期";
            NSInteger index = self.necessaryArray.count-1;
            [self.necessaryArray insertObject:item5 atIndex:index];
        }
    }else {
        if (!add) {
            //删除
            [self.necessaryArray removeObject:theModel];
        }
    }
}

#pragma mark- 编辑方法
- (void)setEditModel:(CYTCarSourceListModel *)editModel {
    _editModel = editModel;
    //网络请求详情数据
    [self.requestDetailCommand execute:nil];
}

#pragma mark- 获取提交参数
- (NSDictionary *)getSubmitParametersWithType:(BOOL)isEdit {
    CYTCarSourcePublishRequestModel *model = [CYTCarSourcePublishRequestModel new];
    //品牌车型
    CYTCarSourcePublishItemModel *itemModel0 = [self necessaryItemModelWithTitle:@"品牌车型"];
    model.BrandId = [itemModel0.carModel.brandId integerValue];
    model.SerialId = [itemModel0.carModel.seriesId integerValue];
    model.CarId = [itemModel0.carModel.carId integerValue];
    model.CustomCarName = itemModel0.carModel.customCarName;
    //车源类型
    CYTCarSourcePublishItemModel *itemModel1 = [self necessaryItemModelWithTitle:@"车源类型"];
    model.goodsType = itemModel1.carSourceTypeModel.carSourceTypeId;
    
    //外观内饰颜色
    CYTCarSourcePublishItemModel *itemModel2 = [self necessaryItemModelWithTitle:@"颜色"];
    model.ExteriorColor = itemModel2.exColorSel;
    model.InteriorColor = itemModel2.inColorSel;
    
    //到港日期
    CYTCarSourcePublishItemModel *itemModel3 = [self necessaryItemModelWithTitle:@"到港日期"];
    model.ArrivalDate = itemModel3.arrivalModel.idCode;
    
    //车原地-选择大区和省份
    CYTCarSourcePublishItemModel *itemModel6 = [self necessaryItemModelWithTitle:@"车源地"];
    CYTAddressDataItemModel *addressModel = itemModel6.carSourceLocationModel.addressModel.selectProvinceModel;
    model.LocationGroupId = addressModel.locationGroupID;
    model.ProvinceId = addressModel.idCode;
    
    //车源状态
    CYTCarSourcePublishItemModel *itemModel7 = [self necessaryItemModelWithTitle:@"车源状态"];
    model.goodsStatus = itemModel7.carSourceStatus;
    //报价
    CYTCarSourcePublishItemModel *itemModel8 = [self necessaryItemModelWithTitle:@"报价"];
    if (itemModel8.select) {
        model.SalePrice = [itemModel8.content floatValue];
        model.PriceMode = itemModel8.priceMode;
        model.PriceBasePoint = itemModel8.priceValue;
    }

    
    //配置
    CYTCarSourcePublishItemModel *model0 = self.inecessaryArray[0];
    model.CarConfigure = (!model0.content)?@"":model0.content;
    //手续
    CYTCarSourcePublishItemModel *model1 = self.inecessaryArray[1];
    model.CarProcedures = (!model1.content)?@"":model1.content;
    //可售区域
    CYTCarSourcePublishItemModel *model2 = self.inecessaryArray[2];
    model.SalableArea = (!model2.content)?@"":model2.content;
    //图片
    model.Media = [self getImageIdArray].mutableCopy;
    //备注
    CYTCarSourcePublishItemModel *model4 = self.inecessaryArray[4];
    model.Remark = (!model4.content)?@"":model4.content;
    
    if (isEdit) {
        model.CarSourceId = [self.editModel.carSourceInfo.carSourceId integerValue];
    }
    
    NSDictionary *parameters = model.mj_keyValues;
    return parameters;
}

- (NSArray *)getImageIdArray {
    CYTCarSourcePublishItemModel *model3 = [self unnecessaryItemModelWithTitle:@"图片"];
    return model3.fileIdImageArray;
}

#pragma mark- get

#pragma mark - 发布车源
- (RACCommand *)requestCommand {
    if (!_requestCommand) {
        _requestCommand = [self commandWithRequestModel:^FFBasicNetworkRequestModel *{
            FFBasicNetworkRequestModel *model = [FFBasicNetworkRequestModel new];
            model.requestURL = kURL.car_source_add;
            model.needHud = YES;
            model.requestParameters = [self getSubmitParametersWithType:NO];
            return model;
        } andHandle:^(FFBasicNetworkResponseModel *resultModel) {
            if (resultModel.resultEffective) {
                self.carSourceId = [[resultModel.dataDictionary valueForKey:@"carSourceId"] integerValue];
            }
        }];
    }
    return _requestCommand;
}

- (RACSubject *)reloadSubject {
    if (!_reloadSubject) {
        _reloadSubject = [RACSubject new];
    }
    return _reloadSubject;
}

- (RACCommand *)requestDetailCommand {
    if (!_requestDetailCommand) {
        _requestDetailCommand = [self commandWithRequestModel:^FFBasicNetworkRequestModel *{
            FFBasicNetworkRequestModel *model = [FFBasicNetworkRequestModel new];
            model.methodType = NetRequestMethodTypeGet;
            model.requestURL = kURL.car_source_detail;
            model.needHud = YES;
            NSDictionary *parameters = @{@"CarSourceId":self.editModel.carSourceInfo.carSourceId};
            model.requestParameters = parameters;
            
            return model;
        } andHandle:^(FFBasicNetworkResponseModel *resultModel) {
            if (!resultModel.resultEffective) {
                return ;
            }
            
            CarSourceDetailModel *model = [CarSourceDetailModel mj_objectWithKeyValues:resultModel.dataDictionary];
            self.carDetailModel = model;
            
            if (model) {
                //必填
                [self.necessaryArray removeAllObjects];
                [self handleEditNecessoryWithModel:model];
                //选填
                [self.inecessaryArray removeAllObjects];
                [self handleEditInecessoryWithModel:model];
                
                [self.listArray removeAllObjects];
                [self.listArray addObject:self.necessaryArray];
                [self.listArray addObject:self.inecessaryArray];
                
                //请求颜色数据
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.requestColorCommand execute:nil];
                });
                
                //填充页面
                [self.reloadSubject sendNext:@"1"];
            }else {
                //没有数据
                [CYTToast messageToastWithMessage:CYTNetworkError];
                [self.backSubject sendNext:@"1"];
            }
        }];
    }
    return _requestDetailCommand;
}
#pragma mark - 保存发布

- (RACCommand *)editSaveCommond {
    if (!_editSaveCommond) {
        _editSaveCommond = [self commandWithRequestModel:^FFBasicNetworkRequestModel *{
            FFBasicNetworkRequestModel *model = [FFBasicNetworkRequestModel new];
            model.requestURL = kURL.car_source_modify;
            model.needHud = YES;
            model.requestParameters = [self getSubmitParametersWithType:YES];
            return model;
        } andHandle:^(FFBasicNetworkResponseModel *resultModel) {
            self.editSaveCommandResult = resultModel;
            //none
        }];
    }
    return _editSaveCommond;
}


#pragma mark - 根据标题返回模型
/**
 *  获取必填项
 */
- (CYTCarSourcePublishItemModel *)necessaryItemModelWithTitle:(NSString *)title{
    __block CYTCarSourcePublishItemModel *carSourcePublishItemModel;
    [self.necessaryArray enumerateObjectsUsingBlock:^(CYTCarSourcePublishItemModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([title isEqualToString:obj.title]) {
            carSourcePublishItemModel = obj;
            *stop = YES;
        }
    }];
    return carSourcePublishItemModel;
}
/**
 *  获取非必填项
 */
- (CYTCarSourcePublishItemModel *)unnecessaryItemModelWithTitle:(NSString *)title{
    __block CYTCarSourcePublishItemModel *carSourcePublishItemModel;
    [self.inecessaryArray enumerateObjectsUsingBlock:^(CYTCarSourcePublishItemModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([title isEqualToString:obj.title]) {
            carSourcePublishItemModel = obj;
            *stop = YES;
        }
    }];
    return carSourcePublishItemModel;
}

/**
 *  添加必填项
 */
- (void)addNecessaryItemWithModel:(CYTCarSourcePublishItemModel *)model beforeTitle:(NSString *)beforeTitle{
    __block NSInteger index = -1;
    [self.necessaryArray enumerateObjectsUsingBlock:^(CYTCarSourcePublishItemModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([beforeTitle isEqualToString:obj.title]) {
            index = idx;
            *stop = YES;
        }
    }];
    if (index>=0) {
        [self.necessaryArray insertObject:model atIndex:index];
    }
}
/**
 *  是否包含该item
 */
- (BOOL)containNecessaryItemWithTitle:(NSString *)title{
    __block BOOL contain = NO;
    [self.necessaryArray enumerateObjectsUsingBlock:^(CYTCarSourcePublishItemModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([title isEqualToString:obj.title]) {
            contain = YES;
            *stop = YES;
        }
    }];
    return contain;
}
/**
 *  移除必填项
 */
- (void)removeNecessaryItemWithTitle:(NSString *)title{
    [self.necessaryArray enumerateObjectsUsingBlock:^(CYTCarSourcePublishItemModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([title isEqualToString:obj.title]) {
            [self.necessaryArray removeObject:obj];
            *stop = YES;
        }
    }];
}
@end
