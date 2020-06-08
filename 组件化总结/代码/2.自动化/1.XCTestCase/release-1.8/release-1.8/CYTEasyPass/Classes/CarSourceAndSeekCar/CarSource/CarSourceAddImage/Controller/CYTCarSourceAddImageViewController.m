//
//  CYTCarSourceAddImageViewController.m
//  CYTEasyPass
//
//  Created by Jentle on 2017/7/23.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCarSourceAddImageViewController.h"
#import "CYTSelectImageTool.h"
#import "CYTSelectImageModel.h"
#import "CYTImageAssetManager.h"
#import "CYTIndicatorView.h"
#import "CYTImageCompresser.h"

@interface CYTCarSourceAddImageViewController ()

/** 编辑按钮 */
@property(strong, nonatomic) UIButton *editBtn;
/** 图片选择控件 */
@property(strong, nonatomic) CYTSelectImageTool *selectImageTool;
/** 加载动画 */
@property(strong, nonatomic) UIView *indicatorView;
/** 加载信息 */
@property(strong, nonatomic) UILabel *infoLabel;


@end

@implementation CYTCarSourceAddImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self carSourceAddImageBasicConfig];
    [self initCarSourceAddImageComponents];
    [self makeConstrains];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
//    [self.editBtn removeFromSuperview];
//    self.editBtn = nil;
}
/**
 *  基本配置
 */
- (void)carSourceAddImageBasicConfig{
    [self createNavBarWithBackButtonAndTitle:@"添加照片"];
    self.interactivePopGestureEnable = NO;
}

- (void)backButtonClick:(UIButton *)backButton{
    if (self.selectImageTool.imageModels.count) {
        [CYTAlertView alertViewWithTitle:@"提示" message:@"是否确认退出图片编辑？" confirmAction:^{
            [super backButtonClick:backButton];
        } cancelAction:nil];
        return;
    }else{
        [super backButtonClick:backButton];
    }
}
/**
 *  编辑
 */
- (UIButton *)editBtn{
    if (!_editBtn) {
        _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _editBtn.enabled = NO;
        _editBtn.originStatus = YES;
        [_editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        _editBtn.titleLabel.font = CYTFontWithPixel(28.f);
        [_editBtn setTitleColor:kFFColor_title_L2 forState:UIControlStateNormal];
        [_editBtn setTitleColor:kFFColor_title_L2 forState:UIControlStateDisabled];
        CYTWeakSelf
        [[_editBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            [weakSelf editBtnClickAction];
        }];
    }
    return _editBtn;
}

- (CYTSelectImageTool *)selectImageTool{
    if (!_selectImageTool) {
        CYTWeakSelf
        _selectImageTool = [[CYTSelectImageTool alloc] init];
        _selectImageTool.selectedMaxNum = 9;
        _selectImageTool.editAble = ^(BOOL editAble) {
            weakSelf.editBtn.enabled = editAble;
        };
        _selectImageTool.deleteEmpty = ^{
            weakSelf.editBtn.originStatus = YES;
            [weakSelf.editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        };
        
        _selectImageTool.clickEditBtnBlock = ^{
            [weakSelf editBtnClickAction];
        };
        
        _selectImageTool.completion = ^(NSMutableArray<CYTSelectImageModel *> *imageModels) {
            [weakSelf showActivityIndicatorView];
            NSMutableArray *images = [NSMutableArray array];
            NSMutableArray *imageDatas = [NSMutableArray array];
            NSMutableArray *controlCallBackTime = [NSMutableArray array];//防止回调两次
            [imageModels enumerateObjectsUsingBlock:^(CYTSelectImageModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [images addObject:[NSNull null]];
                [imageDatas addObject:[NSNull null]];
                [controlCallBackTime addObject:[NSNull null]];
            }];
            
            dispatch_group_t group = dispatch_group_create();
            for (NSInteger index = 0; index < imageModels.count; index++) {
                [CYTImageAssetManager sharedAssetManager].imageQuality = 1.0f;
                [CYTImageAssetManager sharedAssetManager].imageQualityConfig = 1.0f;
                CYTSelectImageModel *imageModel = imageModels[index];
                imageModel.ID = index;
                if (imageModel.image) {//拍照照片
                    dispatch_group_enter(group);
//                    NSData *imageData = [CYTImageCompresser compressDataWithImage:imageModel.image];
                    NSData *imageData = [imageModel.image dataWithCompressedSize:kImageCompressedMaxSize];
                    imageData.ID = index;
                    [imageDatas replaceObjectAtIndex:index withObject:imageData];
                    dispatch_group_leave(group);
                }else if (imageModel.fileID.length && imageModel.fileID){//已上传的修改
                    dispatch_group_enter(group);
                    NSString *str = [NSString stringWithFormat:@"%ld",index];
                    NSData *tempData = [str dataUsingEncoding:NSUTF8StringEncoding];
                    tempData.fileID = imageModel.fileID;
                    tempData.ID = index;
                    [imageDatas replaceObjectAtIndex:index withObject:tempData];
                    dispatch_group_leave(group);
                }else{//系统相册
                    dispatch_group_enter(group);//与dispatch_group_leave(group)一定成对出现
                    [[CYTImageAssetManager sharedAssetManager] fetchUploadImageWithAsset:imageModel.asset ID:imageModel.ID completion:^(UIImage *result, NSDictionary *info) {
                        UIImage *image = [result compressedToSize:kImageCompressedMaxSize];
                        if ([[controlCallBackTime objectAtIndex:index] isKindOfClass:[NSNumber class]]) return;
                        if (image) {
                            @synchronized(image){
                                [images replaceObjectAtIndex:index withObject:image];}
                        }
//                        NSData *imageData = [CYTImageCompresser compressDataWithImage:result];
                        NSData *imageData = [result dataWithCompressedSize:kImageCompressedMaxSize];
                        imageData.ID = result.ID;
                        if (imageData) {
                            @synchronized(imageDatas){
                                if ([[imageDatas objectAtIndex:index] isKindOfClass:[NSNull class]]) {
                                    [imageDatas replaceObjectAtIndex:index withObject:imageData];
                                    dispatch_group_leave(group);}
                            }
                        }else{
                            [imageDatas replaceObjectAtIndex:index withObject:[NSNull class]];
                            dispatch_group_leave(group);
                        }
                        [controlCallBackTime replaceObjectAtIndex:index withObject:[NSNumber numberWithBool:YES]];
                    }];

                }
            }
            dispatch_group_notify(group, dispatch_get_main_queue(), ^{
                CYTLog(@"图片加载完毕，装备上传。");
                [weakSelf hideActivityIndicatorView];
                __block BOOL imagesSizeCorrect = YES;
                [imageDatas enumerateObjectsUsingBlock:^(NSData  *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    CYTLog(@"%ld",idx);
                    CGFloat dataSize = obj.length/1024.0/1024.f;
                    if (dataSize>= 8.0f) {
                        NSString *tip = [NSString stringWithFormat:@"第%ld张图超过最大文件限制",idx+1];
                        [CYTToast errorToastWithMessage:tip];
                        *stop = true;
                        imagesSizeCorrect = NO;
                        return;
                    }
                }];
                if (imagesSizeCorrect) {
                    !weakSelf.completion?:weakSelf.completion(images,imageDatas,imageModels);
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }
            });
        };
    }
    return _selectImageTool;
}

- (UIView *)indicatorView{
    if (!_indicatorView) {
        _indicatorView = [[UIView alloc] init];
        _indicatorView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7f];
        UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        CGAffineTransform transform = CGAffineTransformMakeScale(1.4f, 1.4f);
        activityIndicatorView.color = [UIColor blackColor];
        activityIndicatorView.transform = transform;
        [activityIndicatorView startAnimating];
        [_indicatorView addSubview:activityIndicatorView];
        [_indicatorView addSubview:self.infoLabel];
        CGFloat activityIndicatorViewWH = CYTAutoLayoutV(60.f);
        [activityIndicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_indicatorView);
            make.centerY.equalTo(_indicatorView).offset(-CYTViewOriginY*0.5);
            make.width.height.equalTo(activityIndicatorViewWH);
        }];

        //加载文字信息
        [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(activityIndicatorView);
            make.top.equalTo(activityIndicatorView.mas_bottom).offset(CYTAutoLayoutV(10));
            make.width.lessThanOrEqualTo(kScreenWidth*0.25f);
        }];

    }
    return _indicatorView;
}

- (UILabel *)infoLabel{
    if (!_infoLabel) {
        _infoLabel = [UILabel labelWithFontPxSize:26.f textColor:CYTHexColor(@"#666666")];
        _infoLabel.textAlignment = NSTextAlignmentCenter;
        _infoLabel.text = @"正在压缩图片...";
        _infoLabel.numberOfLines = 0;
    }
    return _infoLabel;
}

- (void)editBtnClickAction{
    if (_editBtn.originStatus) {
        _editBtn.originStatus = NO;
        [_editBtn setTitle:@"取消" forState:UIControlStateNormal];
    }else{
        _editBtn.originStatus = YES;
        [_editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    }
    self.selectImageTool.editMode = !_editBtn.originStatus;
}

- (void)setAlbumModels:(NSMutableArray<CYTSelectImageModel *> *)albumModels{
    _albumModels = albumModels;
    self.selectImageTool.imageModels = albumModels;
}

/**
 *  初始化子控件
 */
- (void)initCarSourceAddImageComponents{
    //添加编辑按钮
    [self.navigationBar addSubview:self.editBtn];
    //添加图片选中控件
    [self.view addSubview:self.selectImageTool];
    [self.selectImageTool mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(CYTViewOriginY, 0, 0, 0));
    }];
}

- (void)makeConstrains{
    [self.editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-CYTItemMarginH);
        make.centerY.equalTo(self.navigationBar);
    }];
}

#pragma mark - 配置

- (void)showActivityIndicatorView{
    [self.view addSubview:self.indicatorView];
    [self.indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
    }];
}

- (void)hideActivityIndicatorView{
    [self.indicatorView removeFromSuperview];
    [self.infoLabel removeFromSuperview];
    self.indicatorView = nil;
    self.infoLabel = nil;
}

@end
