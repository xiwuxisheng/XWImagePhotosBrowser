//
//  PhotoScanBrowserCollectionViewCell.m
//  MyClinic
//
//  Created by 习武 on 2018/6/21.
//  Copyright © 2018年 Rograndec. All rights reserved.
//

#import "PhotoScanBrowserCollectionViewCell.h"
#import "PhotoBrowserModelProtocol.h"
#import "PhotoBrowserCommon.h"
#import "UIImageView+WebCache.h"
#import "Masonry.h"
#import "PhotoScanNavigationBarView.h"
#import "UIColor+XWUtil.h"

@interface PhotoScanBrowserCollectionViewCell()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *descBackview;

@property (nonatomic, strong) UILabel *descLabel;

@property (nonatomic, strong) PhotoScanNavigationBarView *navGationView;

@end


@implementation PhotoScanBrowserCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

#pragma mark - private
- (void)setupViews {
    
    [self.contentView addSubview:self.scrollView];
    [self.scrollView addSubview:self.imageView];
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
    doubleTap.numberOfTapsRequired = 2;
    [singleTap requireGestureRecognizerToFail:doubleTap];
    [self.scrollView addGestureRecognizer:singleTap];
    [self.scrollView addGestureRecognizer:doubleTap];
    
    [self.contentView addSubview:self.navGationView];
    
    [self.contentView addSubview:self.descBackview];
    __weak PhotoScanBrowserCollectionViewCell *weakSelf = self;
    [self.descBackview mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong PhotoScanBrowserCollectionViewCell *strongSelf = weakSelf;
        make.left.equalTo(strongSelf.contentView.mas_left).offset(10);
        make.bottom.equalTo(strongSelf.contentView.mas_bottom).offset(-50);
        make.right.equalTo(strongSelf.contentView.mas_right).offset(-10);
        make.height.equalTo(@85);
    }];
}

- (void)singleTap:(UITapGestureRecognizer *)singleTap {
    if ([self.delegate respondsToSelector:@selector(singleTap:)]) {
        [self.delegate singleTap:_indexPath];
    }
}

- (void)doubleTap:(UITapGestureRecognizer *)doubleTap {
    if (self.scrollView.zoomScale > 1) {
        [self.scrollView setZoomScale:1 animated:YES];
    } else {
        CGPoint touchPoint = [doubleTap locationInView:self.imageView];
        CGFloat newZoomScale = self.scrollView.maximumZoomScale;
        CGFloat xsize = self.frame.size.width / newZoomScale;
        CGFloat ysize = self.frame.size.height / newZoomScale;
        [self.scrollView zoomToRect:CGRectMake(touchPoint.x - xsize/2, touchPoint.y - ysize/2, xsize, ysize) animated:YES];
    }
}

- (void)resizesSubViews {
    
    UIImage *image = self.imageView.image;
    if (!image) return;
    
    CGFloat x = self.imageView.frame.origin.x;
    CGFloat y = self.imageView.frame.origin.y;
    CGFloat w = self.imageView.frame.size.width;
    if (image.size.height / image.size.width > self.contentView.frame.size.height / self.contentView.frame.size.width) {
        
        self.imageView.frame = CGRectMake(x, 0, w, floor(image.size.height / (image.size.width / self.imageView.frame.size.height)));
    } else {
        CGFloat height = image.size.height / image.size.width * self.contentView.frame.size.width;
        if (height < 1 || isnan(height)) height = self.contentView.frame.size.height;
        height = floor(height);
        CGPoint point = self.imageView.center;
        self.imageView.frame = CGRectMake(x, y, w, height);
        self.imageView.center = CGPointMake(point.x, self.contentView.frame.size.height / 2);
    }
    if (self.imageView.frame.size.height > self.frame.size.height && self.imageView.frame.size.height - self.contentView.frame.size.height <= 1) {
        self.imageView.frame = CGRectMake(x, y, w, self.frame.size.height);
    }
    
    _scrollView.contentSize = CGSizeMake(kScreenWidth, MAX(self.imageView.frame.size.height, self.contentView.frame.size.height));
    [_scrollView scrollRectToVisible:_scrollView.bounds animated:NO];
    if (self.imageView.frame.size.height <= self.contentView.frame.size.height) {
        _scrollView.alwaysBounceVertical = NO;
    } else {
        _scrollView.alwaysBounceVertical = YES;
    }
    
}

#pragma mark - overwrite
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

-(void)pinchAction:(UIPinchGestureRecognizer *)pinch {
    self.imageView.transform = CGAffineTransformScale(self.imageView.transform, pinch.scale, pinch.scale);
    pinch.scale = 1;
}

#pragma mark - getter & setter
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.backgroundColor = [UIColor blackColor];
        _scrollView.delegate = self;
    }
    return _scrollView;
}
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _imageView;
}

- (UIView *)descBackview{
    if (!_descLabel) {
        _descBackview = [[UIScrollView alloc] init];
        _descBackview.backgroundColor = RGBA(5, 5, 5, 0.5);
        _descBackview.layer.masksToBounds = YES;
        _descBackview.layer.cornerRadius = 2.0f;
        [_descBackview addSubview:self.descLabel];
    }
    return _descBackview;
}

- (UILabel *)descLabel{
    if (!_descLabel) {
        _descLabel = [[UILabel alloc] initWithFrame:CGRectMake(5,5,kScreenWidth-30,85)];
        _descLabel.font = [UIFont systemFontOfSize:13];
        _descLabel.textColor = [UIColor colorFromHexRGB:@"ffffff"];
        _descLabel.numberOfLines = 0;
    }
    return _descLabel;
}

- (PhotoScanNavigationBarView *)navGationView{
    if (!_navGationView) {
        _navGationView = [[PhotoScanNavigationBarView alloc] initWithFrame:CGRectMake(0, 0,self.frame.size.width, [UIApplication sharedApplication].statusBarFrame.size.height+44.0)];
        _navGationView.type = PhotoScanNavigationBarViewTypeHiddenBack;
    }
    return _navGationView;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?
    (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?
    (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    self.imageView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                                        scrollView.contentSize.height * 0.5 + offsetY);
}

- (void)loadImage:(NSString *)url{
    NSString *defaultImageName = [_delegate defautBlankImageName];
    [_imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:(defaultImageName ? defaultImageName : @"s_myclinicDefaultImg")] options:SDWebImageProgressiveDownload completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (!error) {
            self.scrollView.maximumZoomScale = 3;
            [self resizesSubViews];
        }
    }];
}

- (void)setImage:(id)image{
    [self.scrollView setZoomScale:1. animated:NO];
    self.scrollView.maximumZoomScale = 1;
    if (image) {
        BOOL isModel = [image conformsToProtocol:@protocol(PhotoBrowserModelProtocol)];
        self.descBackview.hidden = self.navGationView.hidden == !isModel;
        if (isModel){
            id<PhotoBrowserModelProtocol> model = image;
            [self loadImage:model.url];
            BOOL isContent = model.desc.length>0;
            BOOL isTitle = model.title.length>0;
            self.descBackview.hidden = !isContent;
            self.navGationView.hidden = !isTitle;
            if (isContent) {
                self.descBackview.contentOffset = CGPointMake(0, 0);
                self.descLabel.text = model.desc;
                [self.descLabel sizeToFit];
                self.descBackview.contentSize = CGSizeMake(kScreenWidth-20, (self.descLabel.frame.size.height > 85 ? self.descLabel.frame.size.height+5 : 85));
            }
            if (isTitle) {
                self.navGationView.titleLbel.text = model.title;
                self.navGationView.hidden = (_type==PhotoScanBrowserCollectionViewCellTypePush);
            }
        }else{
            self.descBackview.hidden = self.navGationView.hidden = YES;
            if ([image isKindOfClass:[NSString class]]) {
                if ([image hasPrefix:@"http"]) {
                    [self loadImage:image];
                }else{
                    _imageView.image = [UIImage imageNamed:image];
                }
            }else if ([image isKindOfClass:[UIImage class]]){
                _imageView.image = image;
            }
        }
    }
}

@end
