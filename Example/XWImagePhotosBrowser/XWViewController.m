//
//  XWViewController.m
//  XWImagePhotosBrowser
//
//  Created by xiwuxisheng on 04/25/2019.
//  Copyright (c) 2019 xiwuxisheng. All rights reserved.
//

#import "XWViewController.h"
#import "ShareCommentPicCollectionViewCell.h"
#import "PhotoScanBrowser.h"
#import "PhotoScanBroswerPushViewController.h"
#import "PhotoBrowserCommon.h"
#import "RGPhotoModel.h"

@interface XWViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,PhotoScanBrowserDelegate>

@property (nonatomic, strong) UICollectionView *picCollectionView;

@property (nonatomic, strong) NSMutableArray *imageArr;

@property (nonatomic, strong) UIView *snapView;

@end

@implementation XWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createCollectionView];
}

- (void)createCollectionView{
    
    CGFloat width = (kScreenWidth-60)/5;
    
    UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
    flowlayout.sectionInset = UIEdgeInsetsZero;
    flowlayout.headerReferenceSize = CGSizeZero;
    flowlayout.footerReferenceSize = CGSizeZero;
    flowlayout.minimumLineSpacing = 0.0f;
    flowlayout.minimumInteritemSpacing = 0.0f;
    flowlayout.itemSize = CGSizeMake(width,width);
    
    _picCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(10, STATUS_AND_NAVIGATION_HEIGHT+50,kScreenWidth-20,60) collectionViewLayout:flowlayout];
    _picCollectionView.backgroundColor = [UIColor clearColor];
    [_picCollectionView registerClass:[ShareCommentPicCollectionViewCell class] forCellWithReuseIdentifier:@"ShareCommentPicCollectionViewCell"];
    _picCollectionView.dataSource = self;
    _picCollectionView.delegate = self;
    _picCollectionView.pagingEnabled = YES;
    [self.view addSubview:_picCollectionView];
}


- (NSMutableArray *)imageArr{
    if (!_imageArr) {
        _imageArr = [NSMutableArray array];
        NSMutableArray *arr = @[@"http://upload-images.jianshu.io/upload_images/5350321-ae065c1e5f8ce2d1.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240",
                                @"http://upload-images.jianshu.io/upload_images/3247999-08fc131e165a0855.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240",
                                @"http://upload-images.jianshu.io/upload_images/3247999-ae96f97413c450da.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240",
                                @"http://upload-images.jianshu.io/upload_images/4336008-3da38a32adee02f2.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240",
                                @"http://upload-images.jianshu.io/upload_images/4336008-c89e36f0ab50c5fd.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240"].mutableCopy;
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            RGPhotoModel *model = [[RGPhotoModel alloc] init];
            model.url = obj;
            if (idx!=3) {
                model.title = [NSString stringWithFormat:@"图片标题---%ld",idx];
                model.desc = [NSString stringWithFormat:@"撒发神经架飞机爱福家按实际发就案件发生经发局卡就卡开发库暗示法咖啡那就开始你的就开始打开就尴尬的积分拿进来阿发那算了放哪里是否能阿发哪里看见理科高考两个技能是考虑到该阿黄发哈来递归哈达林更合适的结构化山东理工黑色柳丁高速路口搞技术的---%ld",idx];
            }
            [_imageArr addObject:model];
        }];
    }
    return _imageArr;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imageArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ShareCommentPicCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ShareCommentPicCollectionViewCell" forIndexPath:indexPath];
    cell.imageUrl = [self.imageArr objectAtIndex:indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ShareCommentPicCollectionViewCell *cocell = (ShareCommentPicCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (cocell) {
        [self expandPhotoBroswer:cocell indexPath:indexPath];
    }
}

- (void)expandPhotoBroswer:(ShareCommentPicCollectionViewCell *)cocell
                 indexPath:(NSIndexPath *)indexPath{
    PhotoScanBrowser *broswer = [[PhotoScanBrowser alloc] initWithPics:self.imageArr selectIndex:indexPath.row];
    broswer.delegate = self;
    [broswer show];
    //        PhotoScanBroswerPushViewController *vc = [[PhotoScanBroswerPushViewController alloc] initWithItems:self.imageArr selectPage:indexPath.row];
    //        [self.navigationController pushViewController:vc animated:YES];
}

- (UIView *)snapViewFromOriginalView:(NSIndexPath *)indexPath{
    ShareCommentPicCollectionViewCell *cocell = (ShareCommentPicCollectionViewCell *)[self.picCollectionView cellForItemAtIndexPath:indexPath];
    if (cocell) {
        return [cocell.imagePic snapshotViewAfterScreenUpdates:NO];
    }
    return [cocell snapshotViewAfterScreenUpdates:NO];
}

- (CGRect)snapViewFromOriginalRect:(NSIndexPath *)indexPath{
    ShareCommentPicCollectionViewCell *cocell = (ShareCommentPicCollectionViewCell *)[self.picCollectionView cellForItemAtIndexPath:indexPath];
    if (cocell) {
        CGRect rect = [cocell convertRect:cocell.imagePic.frame toView:nil];
        return rect;
    }
    return CGRectZero;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
