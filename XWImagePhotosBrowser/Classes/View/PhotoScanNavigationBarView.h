//
//  PhotoScanNavigationBarView.h
//  MyClinic
//
//  Created by 习武 on 2018/6/22.
//  Copyright © 2018年 Rograndec. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, PhotoScanNavigationBarViewType) {
    PhotoScanNavigationBarViewTypeDefault = 0, //默认导航栏视图
    PhotoScanNavigationBarViewTypeHiddenBack//隐藏返回按钮视图
};

@interface PhotoScanNavigationBarView : UIView

@property (nonatomic, copy) void(^PhotoScanNavigationBarViewBackBlock)(void);

@property (nonatomic, strong) UILabel *titleLbel;

@property (nonatomic, assign) PhotoScanNavigationBarViewType type;

@end
