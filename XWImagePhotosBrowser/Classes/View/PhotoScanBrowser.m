//
//  PhotoScanBrowser.m
//  MyClinic
//
//  Created by 习武 on 2018/6/21.
//  Copyright © 2018年 Rograndec. All rights reserved.
//

#import "PhotoScanBrowser.h"
#import "PhotoScanBrowserCollectionViewCell.h"
#import "PhotoBrowserCommon.h"
#import "UIColor+XWUtil.h"

@interface PhotoScanBrowser()<
UICollectionViewDelegate,
UICollectionViewDataSource,
PhotoScanBrowserCollectionViewCellDelegate>

@property (nonatomic, strong) UICollectionView *picCollectionView;

@property (nonatomic, strong) NSMutableArray *imageArr;

@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, strong) UILabel *pageIndicatorLabel; /**< 指示器 */

@end

@implementation PhotoScanBrowser

- (instancetype)initWithPics:(NSArray *)imageArr selectIndex:(NSInteger)selectedIndex{
    self = [super initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        [self createCollectionView];
        if (imageArr) {
            [self.imageArr addObjectsFromArray:imageArr];
            [self.picCollectionView reloadData];
        }
        _currentIndex = selectedIndex;
        self.pageControl.numberOfPages = self.imageArr.count;
        self.pageControl.currentPage = selectedIndex;
        [self showTextPageIndicatorLabel];
    }
    return self;
}

- (void)createCollectionView{
    UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
    flowlayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowlayout.sectionInset = UIEdgeInsetsZero;
    flowlayout.headerReferenceSize = CGSizeZero;
    flowlayout.footerReferenceSize = CGSizeZero;
    flowlayout.minimumLineSpacing = 0.0f;
    flowlayout.minimumInteritemSpacing = 0.0f;
    flowlayout.itemSize = CGSizeMake(self.frame.size.width,self.frame.size.height);
    
    _picCollectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowlayout];
    _picCollectionView.backgroundColor = [UIColor clearColor];
    [_picCollectionView registerClass:[PhotoScanBrowserCollectionViewCell class] forCellWithReuseIdentifier:@"PhotoScanBrowserCollectionViewCell"];
    _picCollectionView.dataSource = self;
    _picCollectionView.delegate = self;
    _picCollectionView.pagingEnabled = YES;
    [self addSubview:_picCollectionView];
}

#pragma mark - lazy data
- (NSMutableArray *)imageArr{
    if (!_imageArr) {
        _imageArr = [NSMutableArray array];
    }
    return _imageArr;
}

#pragma mark - lazy view
- (UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0,self.frame.size.height-60,self.frame.size.width,30)];
        _pageControl.pageIndicatorTintColor = [UIColor colorFromHexRGB:@"999999"];
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.currentPage = 0;
        _pageControl.numberOfPages = self.imageArr.count;
        [self addSubview:_pageControl];
    }
    return _pageControl;
}

- (UILabel *)pageIndicatorLabel{
    if (!_pageIndicatorLabel) {
        _pageIndicatorLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth -65,STATUS_AND_NAVIGATION_HEIGHT, 55, 14)];
        _pageIndicatorLabel.font = [UIFont systemFontOfSize:14];
        _pageIndicatorLabel.textAlignment = NSTextAlignmentCenter;
        _pageIndicatorLabel.textColor = [UIColor colorFromHexRGB:@"999999"];
        [self addSubview:_pageIndicatorLabel];
    }
    return _pageIndicatorLabel;
}

#pragma mark - action

- (void)show{
    CGRect snapRect = CGRectZero;
    __block UIView *snapView = [UIView new];
    if (_delegate&&[_delegate respondsToSelector:@selector(snapViewFromOriginalView:)]) {
        snapView = [_delegate snapViewFromOriginalView:[NSIndexPath indexPathForRow:_currentIndex inSection:0]];
    }
    if (_delegate&&[_delegate respondsToSelector:@selector(snapViewFromOriginalRect:)]) {
        snapRect = [_delegate snapViewFromOriginalRect:[NSIndexPath indexPathForRow:_currentIndex inSection:0]];
    }
    if (snapView) {
        [self.picCollectionView setContentOffset:CGPointMake(_currentIndex*self.frame.size.width, 0) animated:NO];
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        snapView.frame = snapRect;
        [window addSubview:snapView];
        PhotoScanBrowserCollectionViewCell *cocell = [self collectionView:self.picCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:_currentIndex inSection:0]];
        CGRect toFrame = [cocell convertRect:cocell.imageView.frame toView:nil];
        [UIView animateWithDuration:0.3 animations:^{
            snapView.frame = toFrame;
        } completion:^(BOOL finished) {
            if (finished) {
                snapView.hidden = YES;
                [snapView removeFromSuperview];
                snapView = nil;
                [window addSubview:self];
            }
        }];
    }
}


- (void)hideCellAction:(NSIndexPath *)indexPath{
    PhotoScanBrowserCollectionViewCell *cocell = (PhotoScanBrowserCollectionViewCell *)[self.picCollectionView cellForItemAtIndexPath:indexPath];
    if (_delegate&&[_delegate respondsToSelector:@selector(snapViewFromOriginalRect:)]) {
        CGRect snapRect = [_delegate snapViewFromOriginalRect:indexPath];
        CGRect rect = [cocell convertRect:cocell.imageView.frame toView:nil];
        __block UIView *imageView = [cocell.imageView snapshotViewAfterScreenUpdates:NO];
        imageView.frame = rect;
        if (imageView) {
            UIWindow *window = [[UIApplication sharedApplication] keyWindow];
            imageView.frame = rect;
            [window addSubview:imageView];
            [self removeFromSuperview];
            [UIView animateWithDuration:0.3 animations:^{
                imageView.frame = snapRect;
            } completion:^(BOOL finished) {
                if (finished) {
                    [imageView removeFromSuperview];
                    imageView = nil;
                }
            }];
        }
    }else{
       [self removeFromSuperview];
    }
}

- (void)showTextPageIndicatorLabel{
    NSString *pageIndicator = [NSString stringWithFormat:@"%ld/%lu",(long)(_currentIndex+1),(unsigned long)self.imageArr.count];
    NSMutableAttributedString *attr =  [[NSMutableAttributedString alloc] initWithString:pageIndicator];
    [attr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, pageIndicator.length)];
    [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0, pageIndicator.length)];
    self.pageIndicatorLabel.attributedText = attr;
}

#pragma mark - delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger page = round((scrollView.contentOffset.x/self.frame.size.width));
    _pageControl.currentPage = page;
    if (_currentIndex!=page) {
        PhotoScanBrowserCollectionViewCell *cocell = (PhotoScanBrowserCollectionViewCell *)[self.picCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:_currentIndex inSection:0]];
        if (cocell) {
            [cocell.scrollView setZoomScale:1. animated:NO];
        }
        _currentIndex = page;
        [self showTextPageIndicatorLabel];
        if([_delegate respondsToSelector:@selector(photoScanBrowserDidScrollAtIndex:)]){
            [_delegate photoScanBrowserDidScrollAtIndex:page];
        }
    }
}

- (void)singleTap:(NSIndexPath *)indexPath{
    [self hideCellAction:indexPath];
}

- (NSString *)defautBlankImageName{
    NSString *imageName = nil;
    if (_delegate&&[_delegate respondsToSelector:@selector(defautBlankImageName)]) {
        imageName = [_delegate defautBlankImageName];
    }
    return imageName;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imageArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PhotoScanBrowserCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoScanBrowserCollectionViewCell" forIndexPath:indexPath];
    cell.indexPath = indexPath;
    cell.image = [self.imageArr objectAtIndex:indexPath.row];
    cell.delegate = self;
    return cell;
}

@end
