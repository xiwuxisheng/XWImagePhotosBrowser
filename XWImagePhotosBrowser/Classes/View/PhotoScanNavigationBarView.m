//
//  PhotoScanNavigationBarView.m
//  MyClinic
//
//  Created by 习武 on 2018/6/22.
//  Copyright © 2018年 Rograndec. All rights reserved.
//

#import "PhotoScanNavigationBarView.h"

@interface PhotoScanNavigationBarView()

@property (nonatomic, strong) UIButton *backBtn;

@end

@implementation PhotoScanNavigationBarView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI{
    _titleLbel = [[UILabel alloc] initWithFrame:CGRectMake(0,[UIApplication sharedApplication].statusBarFrame.size.height, self.frame.size.width, 44)];
    _titleLbel.userInteractionEnabled = YES;
    _titleLbel.textColor = [UIColor whiteColor];
    _titleLbel.font = [UIFont systemFontOfSize:17];
    _titleLbel.textAlignment = NSTextAlignmentCenter;
    _titleLbel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:_titleLbel];
    
    _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    _backBtn.frame = CGRectMake(15,5, 30, 35);
    [_backBtn setImage:[UIImage imageNamed:@"btn_back_noraml"] forState:UIControlStateNormal];
    [_titleLbel addSubview:_backBtn];
}

- (void)setType:(PhotoScanNavigationBarViewType)type{
    _type = type;
    _backBtn.hidden = (_type!=PhotoScanNavigationBarViewTypeDefault);
}

- (void)backAction{
    if (_PhotoScanNavigationBarViewBackBlock) {
        _PhotoScanNavigationBarViewBackBlock();
    }
}

@end
