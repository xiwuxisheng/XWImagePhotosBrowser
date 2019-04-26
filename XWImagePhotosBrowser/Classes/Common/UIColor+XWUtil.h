//
//  UIColor+XWUtil.h
//  XWImagePhotosBrowser
//
//  Created by 习武 on 2019/4/26.
//

#import <UIKit/UIKit.h>

#define RGBA(r,g,b,a)  [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (XWUtil)

+ (UIColor *)colorFromHexRGB:(NSString *)inColorString;

@end

NS_ASSUME_NONNULL_END
