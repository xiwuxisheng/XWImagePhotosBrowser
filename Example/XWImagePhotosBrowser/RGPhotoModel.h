//
//  RGPhotoModel.h
//  PhotoScanBrowser_Example
//
//  Created by 习武 on 2018/9/4.
//  Copyright © 2018年 xiwuxisheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PhotoBrowserModelProtocol.h"

@interface RGPhotoModel : NSObject<PhotoBrowserModelProtocol>

@property (nonatomic, copy) NSString *url;  //文件地址url

@property (nonatomic, copy) NSString *desc;//图片描述

@property (nonatomic, copy) NSString *title;//图片标题

@end
