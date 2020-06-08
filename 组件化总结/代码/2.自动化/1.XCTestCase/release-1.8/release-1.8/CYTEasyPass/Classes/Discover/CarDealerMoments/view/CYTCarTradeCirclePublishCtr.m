//
//  CYTCarTradeCirclePublishCtr.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/3/22.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTCarTradeCirclePublishCtr.h"
#import "CYTAddImageView.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "CYTCarTradeCircleViewModel.h"
#import "CYTPhontoPreviewViewController.h"
#import "CYTImageFileModel.h"
#import "CYTPhotoSelectTool.h"
#import "CYTSignalImageUploadTool.h"

@interface CYTCarTradeCirclePublishCtr ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate>
@property (nonatomic, strong) CYTCarTradeCircleViewModel *viewModel;

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) CYTAddImageView *addImageView;

@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *publishButton;
/** 图片url字典 */
@property (strong, nonatomic) NSMutableArray *imageIdArray;
@property (nonatomic, strong) NSMutableArray *imageModelArray;

@end

@implementation CYTCarTradeCirclePublishCtr

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavBarWithTitle:nil];
    self.imageIdArray = [NSMutableArray array];
    self.imageModelArray = [NSMutableArray array];
    [self bindViewModel];
    [self loadUI];
    
    
    //图片删除的通知
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:CYTDeletePhontoKey object:nil] subscribeNext:^(NSNotification *note) {
        if ([note.object isKindOfClass:[NSNumber class]]) {
            return ;
        }
        
        for (CYTImageFileModel *fileModel in self.imageModelArray) {
            if ([fileModel.imageData isEqual:note.object]) {
                [self.imageIdArray removeObject:fileModel.fileID];
                [self.imageModelArray removeObject:fileModel];
                break;
            }
        }
        
    }];

    [self.textView becomeFirstResponder];
}

- (void)loadUI {
    //取消
    [self.navigationBar addSubview:self.cancelButton];
    CGFloat cancelBtnH = self.cancelButton.titleLabel.font.pointSize+2;
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.navigationBar);
        make.size.equalTo(CGSizeMake(cancelBtnH*2, cancelBtnH));
        make.left.equalTo(self.navigationBar).offset(CYTMarginH);
    }];
    //发布
    [self.navigationBar addSubview:self.publishButton];
    CGFloat publishBtnH = self.publishButton.titleLabel.font.pointSize+2;
    [self.publishButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.navigationBar);
        make.size.equalTo(CGSizeMake(publishBtnH*2, publishBtnH));
        make.right.equalTo(self.navigationBar).offset(-CYTMarginH);
    }];
    [self.view addSubview:self.textView];
    [self.view addSubview:self.numberLabel];
    [self.view addSubview:self.line];
    [self.view addSubview:self.addImageView];
    
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTAutoLayoutH(30));
        make.right.equalTo(-CYTAutoLayoutH(30));
        make.top.equalTo(CYTViewOriginY);
        make.height.equalTo(CYTAutoLayoutV(300-45));
    }];
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textView.mas_bottom);
        make.right.equalTo(-CYTAutoLayoutH(30));
        make.height.equalTo(CYTAutoLayoutV(45));
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTAutoLayoutH(30));
        make.right.equalTo(-CYTAutoLayoutH(30));
        make.top.equalTo(self.numberLabel.bottom);
        make.height.equalTo(CYTLineH);
        
    }];
    [self.addImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTAutoLayoutH(30));
        make.right.equalTo(-CYTAutoLayoutH(30));
        make.top.equalTo(self.line.bottom).offset(CYTAutoLayoutV(30));
    }];
    
}

- (void)bindViewModel {
    @weakify(self);
    //增加阻塞loading
    [self.viewModel.hudSubject subscribeNext:^(id x) {
        if ([x integerValue] == 0) {
            [CYTLoadingView showLoadingWithType:CYTLoadingViewTypeNotEditable];
        }else {
            [CYTLoadingView hideLoadingView];
        }
    }];
    
    [self.viewModel.submitCommand.executionSignals.switchToLatest subscribeNext:^(FFBasicNetworkResponseModel *model) {
        @strongify(self);
        if (model.resultEffective) {
            [self.view endEditing:YES];
            
            if (self.refreshBlock) {
                self.refreshBlock();
            }
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        }else{
            [CYTToast errorToastWithMessage:model.resultMessage];
        }
    }];
}

/**
 * 图片上传
 */
- (void)uploadImageWithImage:(UIImage *)image{
    CYTWeakSelf
    [CYTLoadingView showLoadingWithType:CYTLoadingViewTypeNotEditable];
    [CYTSignalImageUploadTool uploadWithImage:image parameters:nil url:kURL.user_file_uploadImage success:^(CYTUploadImageResult *result) {
        if (result.result) {
            CYTImageFileModel *fileModel = [CYTImageFileModel mj_objectWithKeyValues:result.data];
            fileModel.imageData = image;
            !fileModel?:[self.imageModelArray addObject:fileModel];
            !fileModel.fileID?:[weakSelf.imageIdArray addObject:fileModel.fileID];
            self.addImageView.selectImage = image;
            [self.viewModel.imageArray addObject:image];
        }else{
            [CYTToast errorToastWithMessage:result.message];
        }
    } fail:nil];
}


#pragma mark- get
- (UITextView *)textView {
    if (!_textView) {
        _textView = [UITextView new];
        _textView.font = CYTFontWithPixel(28);
        _textView.textColor = kFFColor_title_L1;
        _textView.placeholder = @"这一刻的想法";
        _textView.placeholderColor = kFFColor_title_L3;
//        _textView.delegate = self;
        
        @weakify(self);
        [[_textView rac_textSignal] subscribeNext:^(NSString *string) {
            @strongify(self);
            
            if (string.length>1000) {
                string = [string substringToIndex:999];
                _textView.text = string;
            }
            
            NSInteger number = string.length;
            NSString *numberString = [NSString stringWithFormat:@"%ld/1000个字",number];
            self.numberLabel.text = numberString;
            
            BOOL valid = (string.length == 0)?NO:YES;
            self.publishButton.enabled = valid;
            UIColor *color = (valid)?kFFColor_green:kFFColor_title_L3;
            [self.publishButton setTitleColor:color forState:UIControlStateNormal];
        
            
            
        }];
    }
    return _textView;
}

- (UILabel *)numberLabel {
    if (!_numberLabel) {
        _numberLabel = [UILabel new];
        _numberLabel.font = CYTFontWithPixel(24);
        _numberLabel.textColor = UIColorFromRGB(0xb6b6b6);
    }
    return _numberLabel;
}

- (UIView *)line {
    if (!_line) {
        _line = [UIView new];
        _line.backgroundColor = kFFColor_line;
    }
    return _line;
}

- (CYTAddImageView *)addImageView {
    if (!_addImageView) {
        CYTAddImageModel *model = [CYTAddImageModel new];
        model.imageMaxNum = 9;
        _addImageView = [[CYTAddImageView alloc] initWithModel:model];
        
        @weakify(self);
        [_addImageView setAddBtnClickBack:^{
            @strongify(self);
            [CYTPhotoSelectTool photoSelectToolWithImageMode:CYTImageModePreview image:^(UIImage *selectedImage) {
                //图片上传
                [self uploadImageWithImage:selectedImage];
            }];
        }];
        
        [_addImageView setImageViewClickBack:^(NSMutableArray *images, NSInteger index) {
            @strongify(self);
            CYTPhontoPreviewViewController *photoPreviewVC = [[CYTPhontoPreviewViewController alloc] init];
            photoPreviewVC.images = images;
            photoPreviewVC.index = index;
            [self.navigationController pushViewController:photoPreviewVC animated:YES];
        }];
    }
    return _addImageView;
}


- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = CYTFontWithPixel(30);
        [_cancelButton setTitleColor:kFFColor_title_L1 forState:UIControlStateNormal];
        @weakify(self);
        [[_cancelButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
           @strongify(self);
            
            [self.view endEditing:YES];
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        }];
    }
    return _cancelButton;
}

- (UIButton *)publishButton {
    if (!_publishButton) {
        _publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_publishButton setTitle:@"发布" forState:UIControlStateNormal];
        _publishButton.titleLabel.font = CYTFontWithPixel(30);
        [_publishButton setTitleColor:kFFColor_title_L3 forState:UIControlStateNormal];
        @weakify(self);
        [[_publishButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            
            self.viewModel.contentString = self.textView.text;
            self.viewModel.imageIdArray = self.imageIdArray.mutableCopy;
            [self.viewModel.submitCommand execute:nil];
            
        }];
    }
    return _publishButton;
}

- (CYTCarTradeCircleViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [CYTCarTradeCircleViewModel new];
    }
    return _viewModel;
}

@end
