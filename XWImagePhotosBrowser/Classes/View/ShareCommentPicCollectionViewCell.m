//
//  ShareCommentPicCollectionViewCell.m
//  MyClinic
//
//  Created by 习武 on 2018/6/20.
//  Copyright © 2018年 Rograndec. All rights reserved.
//

#import "ShareCommentPicCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "Masonry.h"
#import "UIColor+XWUtil.h"

@interface ShareCommentPicCollectionViewCell()

@end

@implementation ShareCommentPicCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self defaultSet];
    }
    return self;
}

- (void)defaultSet{
    self.layer.borderColor = [UIColor colorFromHexRGB:@"d8d8d8"].CGColor;
    self.layer.borderWidth = 0.5f;
    
    _imagePic = [UIImageView new];
    _imagePic.userInteractionEnabled = YES;
    [self.contentView addSubview:_imagePic];
    
    [_imagePic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

- (void)setImageUrl:(id)imageUrl{
    if(imageUrl){
        if([imageUrl isKindOfClass:[NSString class]]){
            if ([imageUrl hasPrefix:@"http"]) {
                [_imagePic sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"s_myclinicDefaultImg"]];
            }else{
                _imagePic.image = [UIImage imageNamed:imageUrl];
            }
        }else if([imageUrl isKindOfClass:[UIImage class]]){
            _imagePic.image = imageUrl;
        }else if([imageUrl conformsToProtocol:@protocol(PhotoBrowserModelProtocol)]){
            id<PhotoBrowserModelProtocol> model = imageUrl;
            NSString *url = model.url;
            if (url) {
               [_imagePic sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"s_myclinicDefaultImg"]];
            }
        }
    }
}

@end
