//
//  CarSourceDetailVM.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/6/13.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CarSourceDetailVM.h"
#import "CYTImageFileModel.h"
#import "FFSectionHeadView_style0.h"

@implementation CarSourceDetailVM
@synthesize requestCommand = _requestCommand;

-(void)ff_initWithModel:(id)model {
    [super ff_initWithModel:model];
    
    self.listArray = [NSMutableArray array];
    self.section_0Arrary = [NSMutableArray array];
    self.section_1Arrary = [NSMutableArray array];
    self.flowArray = [NSMutableArray array];
    self.routeArray = [NSMutableArray array];
    self.userInfoArray = [NSMutableArray array];
}

///处理详情页数据
- (void)getShowListFromeResponse:(CarSourceDetailModel *)response {
    [self.listArray removeAllObjects];
    [self.section_0Arrary removeAllObjects];
    [self.section_1Arrary removeAllObjects];
    [self.flowArray removeAllObjects];
    [self.routeArray removeAllObjects];
    [self.userInfoArray removeAllObjects];
    
    if (!response) {
        return;
    }
    //构建详情需要的数据数组
    [self handleDataSection_0WithModel:response];
    [self handleDataSection_1WithModel:response];
    [self handleFlowWithModel:response];
    [self handleUserInfoWithModel:response];
}

- (void)getRouteListFromeResponse:(FFBasicNetworkResponseModel *)response {
    if (response.resultEffective) {
        //数据有效,插入到数组中
        NSArray *routeArray = [CarSourceDetailRoutModel mj_objectArrayWithKeyValuesArray:response.dataDictionary[@"data"]].mutableCopy;
        CarSourceDetailItemModel *item = [CarSourceDetailItemModel new];
        item.routeText = @"车销通 - 优势线路";
        item.routeArray = routeArray;
        [self.routeArray addObject:item];
        
        if (self.isMyCarSource || self.fromHisCarSource) {
            //没有经销商数据
            [self.listArray addObject:self.routeArray];
        }else {
            [self.listArray insertObject:self.routeArray atIndex:self.listArray.count-1];
        }
    }
}

#pragma mark-
- (void)handleDataSection_0WithModel:(CarSourceDetailModel *)model {
    CYTCarSourceInfoModel *infoModel = model.carSourceInfo;

    //车信息
    CarSourceDetailItemModel *item0 = [CarSourceDetailItemModel new];
    item0.carInfoString = infoModel.carInfo;
    item0.carTypeString = infoModel.carSourceTypeName;
    [self.section_0Arrary addObject:item0];
    
    //颜色
    CarSourceDetailItemModel *item1 = [CarSourceDetailItemModel new];
    item1.flagString = @"颜\u3000\u3000色:";
    NSString *exColor = (infoModel.exteriorColor.length>0)?[NSString stringWithFormat:@"%@/",infoModel.exteriorColor]:@"";
    item1.contentString = [NSString stringWithFormat:@"%@%@",exColor,infoModel.interiorColor];
    [self.section_0Arrary addObject:item1];
    
    //报价
    CarSourceDetailItemModel *item2 = [CarSourceDetailItemModel new];
    item2.flagString = @"报\u3000\u3000价:";
    item2.contentString = infoModel.salePrice;
    [self.section_0Arrary addObject:item2];
    
    //指导价
    CarSourceDetailItemModel *item3 = [CarSourceDetailItemModel new];
    item3.flagString = @"指  导  价:";
    item3.contentString = infoModel.carReferPriceDesc;
    [self.section_0Arrary addObject:item3];
    
    //到港日期
    CarSourceDetailItemModel *item4 = [CarSourceDetailItemModel new];
    item4.flagString = @"到港日期:";
    item4.contentString = infoModel.arrivalDateDesc;
    if (infoModel.arrivalDate > 0) {
        [self.section_0Arrary addObject:item4];
    }
    
    [self.listArray addObject:self.section_0Arrary];
}

- (void)handleDataSection_1WithModel:(CarSourceDetailModel *)model {
    CYTCarSourceInfoModel *infoModel = model.carSourceInfo;
    
    //可售区域
    CarSourceDetailItemModel *item0 = [CarSourceDetailItemModel new];
    item0.flagString = @"可售区域:";
    item0.index = 0;
    item0.contentString = infoModel.salableArea;
    self.avaliableArea = @"";
    if (item0.contentString.length>0) {
        self.avaliableArea = [NSString stringWithFormat:@"%@,",item0.contentString];
    }else {
        item0.contentString = @"未填写";
    }
    [self.section_1Arrary addObject:item0];
    
    //车源地
    CarSourceDetailItemModel *item1 = [CarSourceDetailItemModel new];
    item1.flagString = @"车  源  地:";
    item1.index = 1;
    item1.contentString = infoModel.carSourceAddress;
    self.carLocation = item1.contentString;
    [self.section_1Arrary addObject:item1];
    
    //手续
    CarSourceDetailItemModel *item2 = [CarSourceDetailItemModel new];
    item2.flagString = @"手\u3000\u3000续:";
    item2.index = 2;
    item2.contentString = infoModel.carProcedures;
    self.procedures = @"";
    if (item2.contentString.length>0) {
        self.procedures = [NSString stringWithFormat:@"%@,",item2.contentString];
        [self.section_1Arrary addObject:item2];
    }
    
    //配置
    CarSourceDetailItemModel *item3 = [CarSourceDetailItemModel new];
    item3.flagString = @"配\u3000\u3000置:";
    item3.index = 3;
    item3.contentString = infoModel.carConfigure;
    self.config = @"";
    if (item3.contentString.length>0) {
        self.config = [NSString stringWithFormat:@"%@,",item3.contentString];
        [self.section_1Arrary addObject:item3];
    }
    
    //更新时间
    CarSourceDetailItemModel *item4 = [CarSourceDetailItemModel new];
    item4.flagString = @"更新时间:";
    item4.index = 4;
    item4.contentString = infoModel.publishTime;
    [self.section_1Arrary addObject:item4];
    
    //图片
    CarSourceDetailItemModel *item5 = [CarSourceDetailItemModel new];
    item5.flagString = @"图\u3000\u3000片:";
    item5.index = 5;
    item5.imageArray = model.media;
    item5.imageCountString = [NSString stringWithFormat:@"（共%ld张）",item5.imageArray.count];
    if (item5.imageArray.count>0) {
        [self.section_1Arrary addObject:item5];
    }
    
    //备注
    CarSourceDetailItemModel *item6 = [CarSourceDetailItemModel new];
    item6.flagString = @"备\u3000\u3000注:";
    item6.index = 6;
    item6.contentString = infoModel.remark;
    self.remark = @"";
    if (item6.contentString.length>0) {
        self.remark = [NSString stringWithFormat:@"%@,",item6.contentString];
        [self.section_1Arrary addObject:item6];
    }
    
    //车源编号
    CarSourceDetailItemModel *item7 = [CarSourceDetailItemModel new];
    item7.flagString = @"车源编号:";
    item7.index = 7;
    item7.contentString = infoModel.sourceCode;
    [self.section_1Arrary addObject:item7];
    
    [self.listArray addObject:self.section_1Arrary];
}

- (void)handleFlowWithModel:(CarSourceDetailModel *)model {
    NSArray *flowArray = [CarSourceDetailDescModel mj_objectArrayWithKeyValuesArray:model.descList];
    for (int i=0; i<flowArray.count; i++) {
        CarSourceDetailDescModel *descModel = flowArray[i];
        CarSourceDetailItemModel *item = [CarSourceDetailItemModel new];
        item.flowModel = descModel;
        [self.flowArray addObject:item];
        
        NSArray *theArray = @[item];
        [self.listArray addObject:theArray];
    }
}

///处理订单流程显示
- (void)handleUserInfoWithModel:(CarSourceDetailModel *)model {
    NSInteger userId = model.dealer.userId;
    
    if (userId != 0 && userId == [CYTUserId integerValue]) {
        self.isMyCarSource = YES;
    }else {
        self.isMyCarSource = NO;
    }
    
    if (model.carSourceInfo.carSourceStatus == 0) {
        self.isUnStore = YES;
    }
    
    if (self.isMyCarSource || self.fromHisCarSource) {
        return;
    }
    
    CarSourceDetailItemModel *item0 = [CarSourceDetailItemModel new];
    item0.dealerInfoModel = model.dealer;
    [self.userInfoArray addObject:item0];
    
    [self.listArray addObject:self.userInfoArray];
}

#pragma mark- method
- (NSMutableArray *)imageURLArray {
    NSArray *imageArray;
    NSMutableArray *result = [NSMutableArray array];
    
    for (int i=0; i<self.section_1Arrary.count; i++) {
        CarSourceDetailItemModel *model = self.section_1Arrary[i];
        if (model.index == 5) {
            //image;
            imageArray = model.imageArray;
        }
    }
    
    if (imageArray.count >0) {
        for (int i=0; i<imageArray.count; i++) {
            NSDictionary *dic = imageArray[i];
            CYTImageFileModel *itemModel = [CYTImageFileModel new];
            itemModel.fileID = [dic valueForKey:@"mediaId"];
            itemModel.url = [dic valueForKey:@"imageUrl"];
            itemModel.thumbnailUrl = [dic valueForKey:@"thumbnailUrl"];
            [result addObject:itemModel];
        }
    }
    
    return result;
}

- (NSString *)titleForSection:(NSInteger)section {
    if (section>=2) {
        NSInteger index = section-2;
        if (index<self.flowArray.count) {
            //定金交易流程
            CarSourceDetailItemModel *model = self.flowArray[index];
            return model.flowModel.title;
        }else if(index<self.flowArray.count+self.routeArray.count){
            //优势路线
            CarSourceDetailItemModel *model = self.routeArray[index-self.flowArray.count];
            return model.routeText;
        }
        return @"";
    }
    return @"";
}

#pragma mark- api
- (NSString *)identifierWithSection:(NSInteger)section {
    if (section>=2) {
        NSInteger index = section-2;
        if (index<self.flowArray.count) {
            //订单流程图
            return @"CYTCarSourceDetailCell_flow";
        }else if (index<self.flowArray.count+self.routeArray.count) {
            //优势线路
            return @"CYTCarSourceDetailCell_route";
        }else if (index<self.flowArray.count+self.routeArray.count+self.userInfoArray.count) {
            //用户信息
            return @"CYTOtherHeaderCell";
        }
    }
    return @"";
}

- (float)heightForHeaderInSection:(NSInteger)section {
    NSString *identifier = [self identifierWithSection:section];
    if ([identifier isEqualToString:@""] || [identifier isEqualToString:@"CYTOtherHeaderCell"]) {
        return (section==self.listArray.count-1)?0.01:CYTItemMarginV;
    }else {
        return CYTAutoLayoutV(90);
    }
}

- (UIView *)viewForHeaderInSection:(NSInteger)section {
    NSString *identifier = [self identifierWithSection:section];
    if ([identifier isEqualToString:@""] || [identifier isEqualToString:@"CYTOtherHeaderCell"]) {
        UIView *view = [UIView new];
        view.backgroundColor = kFFColor_bg_nor;
        return view;
    }else {
        FFSectionHeadView_style0 *header = [FFSectionHeadView_style0 new];
        header.ffServeNameLabel.text = [self titleForSection:section];
        header.ffMoreLabel.hidden = header.ffMoreImageView.hidden = YES;
        header.hLineOffset = CYTMarginH;
        header.leftOffset = CYTMarginH;
        UIView *view = [UIView new];
        view.backgroundColor = kFFColor_bg_nor;
        [view addSubview:header];
        [header makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(0);
            make.top.equalTo(CYTItemMarginV);
            make.height.equalTo(CYTAutoLayoutV(70));
        }];
        return view;
    }
}

#pragma mark- get
- (RACCommand *)requestCommand {
    if (!_requestCommand) {
        _requestCommand = [self commandWithRequestModel:^FFBasicNetworkRequestModel *{
            FFBasicNetworkRequestModel *model = [FFBasicNetworkRequestModel new];
            model.needHud = YES;
            model.methodType = NetRequestMethodTypeGet;
            model.requestURL = kURL.car_source_detail;
            self.carSourceId = (!self.carSourceId)?@"":self.carSourceId;
            model.requestParameters = @{@"CarSourceId":self.carSourceId}.mutableCopy;
            return model;
        } andHandle:^(FFBasicNetworkResponseModel *resultModel) {
            if (resultModel.resultEffective) {
                self.detailModel = [CarSourceDetailModel mj_objectWithKeyValues:resultModel.dataDictionary];
                [self getShowListFromeResponse:self.detailModel];
                //请求优势线路
                CYTCarSourceInfoModel *infoModel = self.detailModel.carSourceInfo;
                self.locationGroupId = [infoModel.locationGroupId integerValue];
                self.provinceId = [infoModel.provinceId integerValue];
                if (self.provinceId==-1) {
                    //接口要求传0
                    self.provinceId = 0;
                }
                [self.routeCommand execute:nil];
            }
        }];
    }
    return _requestCommand;
}

- (RACCommand *)phoneCallCommand {
    if (!_phoneCallCommand) {
        _phoneCallCommand = [self commandWithRequestModel:^FFBasicNetworkRequestModel *{
            FFBasicNetworkRequestModel *model = [FFBasicNetworkRequestModel new];
            
            model.requestURL = kURL.car_source_addContact;
            model.needHud = NO;
            NSString *phone = self.detailModel.dealer.phone;
            NSDictionary *par = @{@"carSourceId":self.carSourceId,
                                  @"phone":phone};
            model.requestParameters = par;
            
            return model;
        } andHandle:^(FFBasicNetworkResponseModel *resultModel) {
            //none
        }];
    }
    return _phoneCallCommand;
}

- (RACCommand *)routeCommand {
    if (!_routeCommand) {
        _routeCommand = [self commandWithRequestModel:^FFBasicNetworkRequestModel *{
            FFBasicNetworkRequestModel *model = [FFBasicNetworkRequestModel new];
            model.needHud = NO;
            model.requestURL = kURL.express_recommend_recommendLine;
            model.requestParameters = @{@"locationGroupId":@(self.locationGroupId),
                                        @"provinceId":@(self.provinceId)
                                        };
            return model;
        } andHandle:^(FFBasicNetworkResponseModel *resultModel) {
            [self getRouteListFromeResponse:resultModel];
        }];
    }
    return _routeCommand;
}

@end
