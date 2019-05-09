//
//  ShareCommentPicCollectionViewCell.h
//  MyClinic
//
//  Created by 习武 on 2018/6/20.
//  Copyright © 2018年 Rograndec. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoBrowserModelProtocol.h"

@interface ShareCommentPicCollectionViewCell : UICollectionViewCell

//记录位置下标
@property (nonatomic, strong) NSIndexPath *indexPath;

//图片
@property (nonatomic, strong) UIImageView *imagePic;

//图片链接
@property (nonatomic, strong) id imageUrl;

@end
