//
//  CYTLocationViewController.m
//  CYTEasyPass
//
//  Created by bita on 16/1/18.
//  Copyright (c) 2016年 EasyPass. All rights reserved.
//

#import "CYTLocationSettingsViewController.h"
#import "CYTCarLocationMode.h"
#import "CYTCarNumberPCell.h"
#import "ACEExpandableTextCell.h"
#import "CYTSaleToLocationController.h"
#import "CYTAddressClient.h"
#import "CYTAddressChooseViewController.h"

@interface CYTLocationSettingsViewController () <ACEExpandableTableViewDelegate,CYTSaleToLocationControllerDealegate>
{
    CGFloat _cellHeight[2];
}

//数据源
@property (nonatomic,strong) CYTCarLocationMode *locationMode;

@property (nonatomic, strong) NSMutableArray *cellData;

//详细地址
@property (nonatomic,copy) NSString *locationDetailed;

//省份
@property (nonatomic,copy) NSString *provincesName;
@property (nonatomic,copy) NSString *provincesId;
@property (nonatomic,strong) CYTFilterColorsMode *masterMode;

@property (nonatomic,copy) NSString *receivingId; // 地址id
@property (nonatomic,copy) NSString *cityId; // 城市id
//输入框
@property (nonatomic,strong) SZTextView *textViewLocaiton;

@end

@implementation CYTLocationSettingsViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.locationMode = [[CYTCarLocationMode alloc] init];
        [self.locationMode dictToMode:nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    OnLiveLabel *liveLabel = [[OnLiveLabel alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
    [liveLabel addTarget:self withSelector:@selector(liveSearchLabel:)];
    liveLabel.text = @"保存";
    liveLabel.font = CYTFontWithPixel(30);
    liveLabel.textAlignment = NSTextAlignmentRight;
    liveLabel.textColor = kTitleMainColor;
    
    UIBarButtonItem * right = [[UIBarButtonItem alloc] initWithCustomView:liveLabel];
    self.navigationItem.rightBarButtonItem = right;
    
    
}

#define ksectionOKH_W  75.f
#define ksectionOKDistenceHW 10.f
#define ksectionOKRightAndLeft 15.f


#pragma mark- 保存地址 网络请求
- (void)liveSearchLabel:(id)sender{
    BOOL keyboard = [CYTUMUpdate sharedInstance].keyboardIsVisible;
    if (keyboard) {
        if (self.textViewLocaiton) {
            [self.textViewLocaiton resignFirstResponder]; //取消第一响应者
        }
    }
    
    if (!self.provincesId) {
        [CYTToast messageToastWithMessage:@"请选择省/市"];
    }else if (!self.locationDetailed){
        [CYTToast messageToastWithMessage:@"请输入详细地址"];
    }else{
        if (self.edStatus == CYTEditingAddressStatusAddNew) {
            @weakify(self);
            [CYTAddressClient addAddressPostWithCityid:self.masterMode.filterID DetailAddress:self.locationDetailed Block:^(NSDictionary *retValue, NSString *error) {
                @strongify(self);
                if (!error) {
                    NSString *Result = [NSString stringWithFormat:@"%@",[retValue objectReNullForKey:@"Result"]];
                    NSString *Message = [NSString stringWithFormat:@"%@",[retValue objectReNullForKey:@"Message"]];
                    [CYTToast messageToastWithMessage:Message];
                    
                    if ([Result isEqualToString:@"1"]) {
                        if ([self.locationDegate respondsToSelector:@selector(loactionMode:andWithProvinces:andWithProvincesId:andLocationDetailed:andWithIndexPath:)]) {
                            [self.locationDegate loactionMode:self.masterMode andWithProvinces:self.provincesName andWithProvincesId:self.provincesId andLocationDetailed:self.locationDetailed andWithIndexPath:self.indexPath];
                        }
                        
                        [self.navigationController popViewControllerAnimated:YES];
                    }
                }
            }];
        }else{
            NSString *cityid = self.masterMode.filterID==nil?self.cityId:self.masterMode.filterID;
            @weakify(self);
            [CYTAddressClient editeAddressPostWithCityid:cityid receivingId:self.receivingId DetailAddress:self.locationDetailed Block:^(NSDictionary *retValue, NSString *error) {
                @strongify(self);
                if (!error) {
                    NSString *Result = [NSString stringWithFormat:@"%@",[retValue objectReNullForKey:@"Result"]];
                    NSString *Message = [NSString stringWithFormat:@"%@",[retValue objectReNullForKey:@"Message"]];
                    [CYTToast messageToastWithMessage:Message];
                    
                    if ([Result isEqualToString:@"1"]) {
                        if ([self.locationDegate respondsToSelector:@selector(loactionMode:andWithProvinces:andWithProvincesId:andLocationDetailed:andWithIndexPath:)]) {
                            [self.locationDegate loactionMode:self.masterMode andWithProvinces:self.provincesName andWithProvincesId:self.provincesId andLocationDetailed:self.locationDetailed andWithIndexPath:self.indexPath];
                        }
                        
                        [self popaddressList];
                    }
                }
                
            }];

        }
    }
}


- (void)popaddressList{
    NSArray *controllers = self.navigationController.viewControllers;
    if (controllers.count >2) {
        UIViewController *vc = controllers[controllers.count - 3];
        [self.navigationController popToViewController:vc animated:YES];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.locationMode.carKeyReleaseArray.count;
}

//点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        //跳转到 地址页面
        [self pushCarsTypeViewController];
    }
}

#pragma mark- 设置默认地址
- (void)setDefaultAdderss:(CYTAdressModel *)adressM{
//    self.labelTitle.text = model.carKeyWords;
//    self.showTitle.text = model.carSelectedName;
//    self.showDetialed.text = model.carLocationDetiled;
    
    CYTCarLocationDeatiledMode *detailedMode = (CYTCarLocationDeatiledMode *)[self.locationMode.carKeyReleaseArray objectAtIndex:0];
    detailedMode.carSelectedName = [NSString stringWithFormat:@"%@ %@",adressM.ProvinceName,adressM.CityName];
    self.provincesId = adressM.ProvinceId;
    self.cityId = adressM.CityId;
    self.receivingId = adressM.ReceivingId;
    self.locationDetailed = adressM.Address;
    detailedMode.carSelectedContent = @"1";
    CYTCarLocationDeatiledMode *detailedMode1 = (CYTCarLocationDeatiledMode *)[self.locationMode.carKeyReleaseArray objectAtIndex:1];
    detailedMode1.carSelectedName = adressM.Address;
    detailedMode1.carSelectedContent = @"999";
}

//delegateCell
- (UITableViewCell *)tableViewCellMode:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CYTCarLocationDeatiledMode *detailedMode = (CYTCarLocationDeatiledMode *)[self.locationMode.carKeyReleaseArray objectAtIndex:indexPath.row];
    
    
    if (detailedMode.carId == 1) {
        static NSString * identifier_1 = @"cell_indenx1";
        
        ACEExpandableTextCell *cell = [tableView expandableTextCellBinWithId:identifier_1];
        cell.contentView.backgroundColor = [UIColor whiteColor];
        cell.textView.textCountMax = 50;
        if ([detailedMode.carSelectedContent isEqualToString:@"999"]) {
            cell.textView.text = detailedMode.carSelectedName;
        }else{
            cell.textView.placeholder = detailedMode.carSelectedName;}
        cell.labelTitle.text = detailedMode.carKeyWords;
        cell.labelTitle.textColor = [UIColor grayColor];
        
        [cell updateLine];
        self.textViewLocaiton = cell.textView;
        
        return cell;
    }
    
    
    static NSString * identifier = @"cell_release";
    
    CYTCarNumberPCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[CYTCarNumberPCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.indexCellPath = indexPath;
    [cell freshSearchPublishCarTableCell:(CYTCarLocationDeatiledMode *)[self.locationMode.carKeyReleaseArray objectAtIndex:indexPath.row]];
    
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self tableViewCellMode:tableView cellForRowAtIndexPath:indexPath];
}

#pragma mark - Table View Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CYTCarLocationDeatiledMode *detaileMode = [self.locationMode.carKeyReleaseArray objectAtIndex:indexPath.row];

    if (detaileMode.carId == 1) {
        return  MAX(88.0, _cellHeight[indexPath.section]);
    }
    
    return 44.f;
}

- (void)tableView:(UITableView *)tableView updatedHeight:(CGFloat)height atIndexPath:(NSIndexPath *)indexPath
{
    _cellHeight[indexPath.section] = height;
}

- (void)tableView:(UITableView *)tableView updatedText:(NSString *)text atIndexPath:(NSIndexPath *)indexPath
{
    [_cellData replaceObjectAtIndex:indexPath.section withObject:text];
    self.locationDetailed = text;
}

//跳转卖到哪去
- (void)pushCarsTypeViewController{

    CYTAddressChooseViewController *chooseController = [CYTAddressChooseViewController new];
    
    @weakify(self);
    [chooseController setChooseBlock:^(CYTAddressChooseVM *model) {
        @strongify(self);
        
        NSString *provinceName = model.selectProvinceModel.name;
        NSString *cityName = [NSString stringWithFormat:@"%@ %@",model.selectCityModel.name,model.selectCountyModel.name];
        NSString *provinceId = [NSString stringWithFormat:@"%ld",model.selectProvinceModel.idCode];
        NSString *cityId = [NSString stringWithFormat:@"%ld",model.selectCityModel.idCode];
        
        CYTFilterColorsMode *masterMode = [CYTFilterColorsMode new];
        masterMode.filterID = cityId;
        masterMode.FilterColor = cityName;
        
        self.masterMode = masterMode;
        self.provincesId = provinceId;
        self.provincesName = provinceName;

        //修改数据源
        CYTCarLocationDeatiledMode *detailedMode = (CYTCarLocationDeatiledMode *)[self.locationMode.carKeyReleaseArray objectAtIndex:0];
        detailedMode.carSelectedName = [NSString stringWithFormat:@"%@ %@",provinceName,cityName];
        detailedMode.carSelectedContent = cityId;
        detailedMode.carLocationDetiled = @"";
        
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:0],nil] withRowAnimation:UITableViewRowAnimationNone];
        
        
    }];
    
    [self.navigationController pushViewController:chooseController animated:YES];
    
    
}

@end
