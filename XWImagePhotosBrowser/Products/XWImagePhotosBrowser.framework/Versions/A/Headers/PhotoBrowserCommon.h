//
//  PhotoBrowserCommon.h
//  demo
//
//  Created by 习武 on 2018/8/9.
//  Copyright © 2018年 addcn. All rights reserved.
//
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
//状态栏高度
#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
/**
 判断是否是iphone X系列
 */
#define IsIPhoneX  (kStatusBarHeight==44.0)
//狀態欄高度
#define STATUS_BAR_HEIGHT ((IsIPhoneX) ? (44) : (20))
//導航欄高度
#define NAVIGATION_BAR_HEIGHT 44

//狀態欄 ＋ 導航欄 高度
#define STATUS_AND_NAVIGATION_HEIGHT ((STATUS_BAR_HEIGHT) + (NAVIGATION_BAR_HEIGHT))
