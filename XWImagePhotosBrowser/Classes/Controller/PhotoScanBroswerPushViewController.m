//
//  PhotoScanBroswerPushViewController.m
//  MyClinic
//
//  Created by 习武 on 2018/6/22.
//  Copyright © 2018年 Rograndec. All rights reserved.
//

#import "PhotoScanBroswerPushViewController.h"
#import "PhotoScanBrowserCollectionViewCell.h"
#import "PhotoScanNavigationBarView.h"
#import "PhotoBrowserModelProtocol.h"
#import "UIColor+XWUtil.h"

@interface PhotoScanBroswerPushViewController ()<
UICollectionViewDelegate,
UICollectionViewDataSource,
PhotoScanBrowserCollectionViewCellDelegate>

@property (nonatomic, strong) UICollectionView *picCollectionView;

@property (nonatomic, strong) NSMutableArray *imageArr;

@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, strong) PhotoScanNavigationBarView *navigationBarView;

@property (nonatomic, assign) BOOL isHidden;

@end

@implementation PhotoScanBroswerPushViewController

#pragma mark - init
- (instancetype)initWithItems:(NSArray *)anItems
                   selectPage:(NSInteger)page{
    self = [super init];
    if (self) {
        if (anItems.count) {
            [self.imageArr addObjectsFromArray:anItems];
        }
        _currentIndex = page;
    }
    return self;
}

#pragma mark - life style
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initConfig];
    [self initUI];
    [self navigationBarView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.picCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.currentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setHidden:NO];
}

#pragma mark - lazy view
- (UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0,self.view.frame.size.height-60,self.view.frame.size.width,30)];
        _pageControl.pageIndicatorTintColor = [UIColor colorFromHexRGB:@"999999"];
        _pageControl.currentPageIndicatorTintColor = [UIColor colorFromHexRGB:@"ffffff"];
        _pageControl.currentPage = 0;
        _pageControl.numberOfPages = self.imageArr.count;
        [self.view addSubview:_pageControl];
    }
    return _pageControl;
}

- (PhotoScanNavigationBarView *)navigationBarView{
    if (!_navigationBarView) {
        _navigationBarView = [[PhotoScanNavigationBarView alloc] initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, [UIApplication sharedApplication].statusBarFrame.size.height+44.0)];
        _navigationBarView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
        _navigationBarView.titleLbel.text = @"图片浏览";
        [self.view addSubview:_navigationBarView];
        __weak typeof(self) weakSelf = self;
        _navigationBarView.PhotoScanNavigationBarViewBackBlock = ^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
    }
    return _navigationBarView;
}

#pragma mark - lazy data
- (NSMutableArray *)imageArr{
    if (!_imageArr) {
        _imageArr = [NSMutableArray array];
    }
    return _imageArr;
}

#pragma mark - private action
- (void)initConfig{
    self.view.backgroundColor = [UIColor blackColor];
    [self.navigationController.navigationBar setHidden:YES];
}

- (void)initUI{
    [self createCollectionView];
    self.pageControl.numberOfPages = self.imageArr.count;
    self.pageControl.currentPage = _currentIndex;
    [self.picCollectionView reloadData];
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf.picCollectionView setContentOffset:CGPointMake(weakSelf.view.frame.size.width*weakSelf.currentIndex, 0) animated:NO];
    });
}

- (void)createCollectionView{
    UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
    flowlayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowlayout.sectionInset = UIEdgeInsetsZero;
    flowlayout.headerReferenceSize = CGSizeZero;
    flowlayout.footerReferenceSize = CGSizeZero;
    flowlayout.minimumLineSpacing = 0.0f;
    flowlayout.minimumInteritemSpacing = 0.0f;
    flowlayout.itemSize = CGSizeMake(self.view.frame.size.width,self.view.frame.size.height);
    
    _picCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowlayout];
    _picCollectionView.backgroundColor = [UIColor clearColor];
    [_picCollectionView registerClass:[PhotoScanBrowserCollectionViewCell class] forCellWithReuseIdentifier:@"PhotoScanBrowserCollectionViewCell"];
    _picCollectionView.dataSource = self;
    _picCollectionView.delegate = self;
    _picCollectionView.pagingEnabled = YES;
    [self.view addSubview:_picCollectionView];
    if (@available(iOS 11.0, *)) {
        _picCollectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (void)changeNavigationTitle:(NSIndexPath *)indexPath{
    id image = [self.imageArr objectAtIndex:indexPath.row];
    if ([image conformsToProtocol:@protocol(PhotoBrowserModelProtocol)]) {
        id<PhotoBrowserModelProtocol> model = image;
        if (model.title.length>0) {
            self.navigationBarView.titleLbel.text = model.title;
            return;
        }
    }
    self.navigationBarView.titleLbel.text = @"图片浏览";
}

#pragma mark - delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger page = round((scrollView.contentOffset.x/self.view.frame.size.width));
    _pageControl.currentPage = page;
    if (_currentIndex!=page) {
        PhotoScanBrowserCollectionViewCell *cocell = (PhotoScanBrowserCollectionViewCell *)[self.picCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:_currentIndex inSection:0]];
        if (cocell) {
            [cocell.scrollView setZoomScale:1. animated:NO];
        }
        _currentIndex = page;
    }
}

- (void)singleTap:(NSIndexPath *)indexPath{
    _isHidden = (_isHidden ? NO : YES);
    [UIView animateWithDuration:0.3 animations:^{
        self.navigationBarView.frame = CGRectMake(0, (self->_isHidden ? -([UIApplication sharedApplication].statusBarFrame.size.height+44.0) : 0),self.view.frame.size.width,[UIApplication sharedApplication].statusBarFrame.size.height+44.0);
    } completion:^(BOOL finished) {
        
    }];
}

- (NSString *)defautBlankImageName{
    return _defaultImageName;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imageArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PhotoScanBrowserCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoScanBrowserCollectionViewCell" forIndexPath:indexPath];
    cell.indexPath = indexPath;
    cell.type = PhotoScanBrowserCollectionViewCellTypePush;
    cell.image = [self.imageArr objectAtIndex:indexPath.row];
    cell.delegate = self;
    [self changeNavigationTitle:indexPath];
    return cell;
}

#pragma mark - other
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
