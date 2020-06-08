//
//  CYTDealerCommentPublishContentView.m
//  CYTEasyPass
//
//  Created by xujunquan on 17/8/3.
//  Copyright © 2017年 EasyPass. All rights reserved.
//

#import "CYTDealerCommentPublishContentView.h"

#define kMaxLength  (200)

@interface CYTDealerCommentPublishContentView ()
@property (nonatomic, strong) NSArray *phraseArray;
@property (nonatomic, copy) NSString *phraseString;

@end

@implementation CYTDealerCommentPublishContentView

- (void)ff_initWithViewModel:(id)viewModel {
    [super ff_initWithViewModel:viewModel];
    self.viewModel = viewModel;
    
    if (self.viewModel.type == CommentViewTypeUser) {
        self.phraseArray = @[@"车源靠谱",@"寻车有诚意",@"态度热情",@"价格公道"];
    }else if (self.viewModel.type == CommentViewTypeLogistics) {
        self.phraseArray = @[@"提车快",@"验车仔细",@"价格公道",@"服务热情"];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChanged) name:UITextViewTextDidChangeNotification object:nil];
}

- (void)ff_addSubViewAndConstraints {
    [super ff_addSubViewAndConstraints];
    self.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.cancelButton];
    [self addSubview:self.titleLabel];
    [self addSubview:self.publishButton];
    [self addSubview:self.titleLine];
    [self addSubview:self.scoreView];
    [self addSubview:self.phraseView];
    [self addSubview:self.textView];
    
    [self.publishButton radius:2 borderWidth:0.5 borderColor:kFFColor_green];
    
    [self.cancelButton enlargeWithValue:5];
    [self.cancelButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTAutoLayoutH(36));
        make.top.equalTo(CYTAutoLayoutV(36));
        make.width.height.equalTo(CYTAutoLayoutH(28));
    }];
    [self.titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.cancelButton);
        make.centerX.equalTo(self);
    }];
    [self.publishButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.cancelButton);
        make.right.equalTo(-CYTItemMarginH);
        make.height.equalTo(CYTAutoLayoutV(52));
        make.width.equalTo(CYTAutoLayoutH(114));
    }];
    [self.titleLine makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTMarginH);
        make.right.equalTo(-CYTMarginH);
        make.top.equalTo(CYTAutoLayoutV(99));
        make.height.equalTo(CYTAutoLayoutV(1));
    }];
    [self.scoreView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.equalTo(CYTAutoLayoutV(160));
        make.top.equalTo(CYTAutoLayoutV(100));
    }];
    [self.phraseView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.equalTo(CYTAutoLayoutV(160));
        make.top.equalTo(self.scoreView.bottom);
    }];
    [self.textView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CYTMarginH);
        make.right.equalTo(-CYTMarginH);
        make.top.equalTo(self.phraseView.bottom).offset(CYTAutoLayoutV(10));
        make.height.equalTo(CYTAutoLayoutV(140));
        make.bottom.equalTo(-CYTAutoLayoutV(50));
    }];
    
    [self initData];
}

- (void)initData {
    self.phraseView.phraseArray = self.phraseArray;
    self.scoreView.index = 0;
}

- (void)textDidChanged {
    
    NSString *text = self.textView.text;
    if (text.length>kMaxLength) {
        text = [text substringToIndex:kMaxLength];
        self.textView.text = text;
    }
}

#pragma mark- get
- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton setImage:[UIImage imageNamed:@"dealer_publishComment_cancel"] forState:UIControlStateNormal];
        @weakify(self);
        [[_cancelButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            if (self.cancelBlock) {
                self.cancelBlock();
            }
        }];
    }
    return _cancelButton;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel labelWithFontPxSize:32 textColor:kFFColor_title_L1];
    }
    return _titleLabel;
}

- (UIButton *)publishButton {
    if (!_publishButton) {
        _publishButton = [UIButton buttonWithFontPxSize:28 textColor:[UIColor whiteColor] text:@"发布"];
        _publishButton.backgroundColor = kFFColor_green;
        @weakify(self);
        [[_publishButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            
            self.viewModel.model.content = self.textView.text;
            if (self.publishBlock) {
                self.publishBlock(self.viewModel);
            }
        }];
        
    }
    return _publishButton;
}

- (UIView *)titleLine {
    if (!_titleLine) {
        _titleLine = [UIView new];
        _titleLine.backgroundColor = kFFColor_line;
    }
    return _titleLine;
}

- (CYTCommentScoreView *)scoreView {
    if (!_scoreView) {
        _scoreView = [CYTCommentScoreView new];
        @weakify(self);
        [_scoreView setIndexBlock:^(NSInteger index) {
            @strongify(self);
            NSString *score = [NSString stringWithFormat:@"%ld",index+1];
            self.viewModel.model.evalType = score;
        }];
    }
    return _scoreView;
}

- (CYTCommentPhraseView *)phraseView {
    if (!_phraseView) {
        _phraseView = [CYTCommentPhraseView new];
        @weakify(self);
        [_phraseView setPhraseBlock:^(NSString *string, BOOL insert) {
            @strongify(self);
            //处理评价字符串
            
            if (insert) {
                NSString *text = self.textView.text;
                text = [NSString stringWithFormat:@"%@%@，",text,string];
                self.textView.text = text;
            }else {
                //把所有符合条件的换成@""
                NSString *text = self.textView.text;
                NSString *string2 = [NSString stringWithFormat:@"%@，",string];
                text = [text stringByReplacingOccurrencesOfString:string2 withString:@""];
                text = [text stringByReplacingOccurrencesOfString:string withString:@""];
                self.textView.text = text;
            }
        }];
    }
    return _phraseView;
}

- (UITextView *)textView {
    if (!_textView) {
        _textView = [UITextView new];
        _textView.backgroundColor = UIColorFromRGB(0xF6F7F8);
        _textView.font = [UIFont systemFontOfSize:14];
    }
    return _textView;
}

@end
