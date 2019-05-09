//
//  PhotoScanBrowserCollectionViewCell.h
//  MyClinic
//
//  Created by 习武 on 2018/6/21.
//  Copyright © 2018年 Rograndec. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, PhotoScanBrowserCollectionViewCellType) {
    PhotoScanBrowserCollectionViewCellDefault = 0, //默认当前弹出视图浏览
    PhotoScanBrowserCollectionViewCellTypePush//push到另外一个界面进行浏览
};

@protocol PhotoScanBrowserCollectionViewCellDelegate <NSObject>

- (void)singleTap:(NSIndexPath *)indexPath;

@optional
- (NSString *)defautBlankImageName;

@end

@interface PhotoScanBrowserCollectionViewCell : UICollectionViewCell

@property (nonatomic, assign) id<PhotoScanBrowserCollectionViewCellDelegate> delegate;

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, assign) PhotoScanBrowserCollectionViewCellType type;

@property (nonatomic, strong) id image;

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UIScrollView *scrollView;

@end
