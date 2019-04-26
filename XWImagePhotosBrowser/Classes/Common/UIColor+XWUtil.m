//
//  UIColor+XWUtil.m
//  XWImagePhotosBrowser
//
//  Created by 习武 on 2019/4/26.
//

#import "UIColor+XWUtil.h"

@implementation UIColor (XWUtil)

+ (UIColor *)colorFromHexRGB:(NSString *)inColorString {
    UIColor *result = nil;
    unsigned int colorCode = 0;
    unsigned char redByte, greenByte, blueByte;
    if([inColorString hasPrefix:@"#"]){
        inColorString = [inColorString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    }
    if (inColorString.length == 0)
    {
        inColorString = @"FFFFFF";
    }
    NSScanner *scanner = [NSScanner scannerWithString:inColorString];
    (void) [scanner scanHexInt:&colorCode]; // ignore error
    redByte = (unsigned char) (colorCode >> 16);
    greenByte = (unsigned char) (colorCode >> 8);
    blueByte = (unsigned char) (colorCode); // masks off high bits
    result = [UIColor colorWithRed: (float)redByte / 0xff green: (float)greenByte/ 0xff blue: (float)blueByte / 0xff alpha:1.0];
    return result;
}


@end
