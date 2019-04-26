//
//  PhotoBrowserModelProtocol.h
//  MyClinic
//
//  Created by 习武 on 2018/7/4.
//  Copyright © 2018年 Rograndec. All rights reserved.
//

@protocol PhotoBrowserModelProtocol<NSObject>

@property (nonatomic, copy) NSString *url;  //文件地址url

@property (nonatomic, copy) NSString *desc;//图片描述

@property (nonatomic, copy) NSString *title;//图片标题

@end
