//
//  PhotoScanBrowser.h
//  MyClinic
//
//  Created by 习武 on 2018/6/21.
//  Copyright © 2018年 Rograndec. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PhotoScanBrowserDelegate<NSObject>

- (UIView *)snapViewFromOriginalView:(NSIndexPath *)indexPath;
- (CGRect)snapViewFromOriginalRect:(NSIndexPath *)indexPath;
@optional
- (void)photoScanBrowserDidScrollAtIndex:(NSInteger)index;
- (void)hidePhotoScanBrowserAtIndex:(NSInteger)index;
- (NSString *)defautBlankImageName;
@end

@interface PhotoScanBrowser : UIView

@property (nonatomic, weak) id<PhotoScanBrowserDelegate> delegate;

- (instancetype)initWithPics:(NSArray *)imageArr
                 selectIndex:(NSInteger)selectedIndex;

- (void)show;

@end
