//
//  PhotoScanBroswerPushViewController.h
//  MyClinic
//
//  Created by 习武 on 2018/6/22.
//  Copyright © 2018年 Rograndec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoScanBroswerPushViewController : UIViewController

//初始化构造方法
- (instancetype)initWithItems:(NSArray *)anItems
                   selectPage:(NSInteger)page;

//设定默认图名，不设置即默认为s_myclinicDefaultImg
@property (nonatomic, copy) NSString *defaultImageName;

@end
