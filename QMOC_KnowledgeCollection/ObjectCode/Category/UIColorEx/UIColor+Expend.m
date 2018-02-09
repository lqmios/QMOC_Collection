//
//  UIColor+Expend.m
//  QMOC_KnowledgeCollection
//
//  Created by Match on 2018/1/10.
//  Copyright © 2018年 LuQingMing. All rights reserved.
//

#import "UIColor+Expend.h"

@implementation UIColor (Expend)
/**
 *  用十六进制设置颜色
 *
 */

+(UIColor *)colorWithHex:(long)hexColor
{
    return [UIColor colorWithHex:hexColor alpha:1];
}

/**
 *  用十六进制设置颜色和透明度
 */
+(UIColor *)colorWithHex:(long)hexColor alpha:(float)opacity
{
    float red = ((float)((hexColor & 0xFF0000) >> 16)) / 255.0;
    
    float green = ((float) ((hexColor & 0xFF00) >> 8)) / 255.0;
    
    float blue = ((float)(hexColor & 0xFF)) / 255.0;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:opacity];
}

//添加到pach文件中所有类都可用
#pragma mark - 颜色转换 IOS中十六进制的颜色转换为UIColor
+ (UIColor *) colorWithHexString: (NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
    
}
+ (UIColor*) colorWithHexString:(NSString*)color alpha:(float)opacity
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:opacity];
    
}

+ (UIColor *)colorWithIntegralRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue {
    return [self colorWithIntegralRed:red green:green blue:blue alpha:1];
}
+ (UIColor *)colorWithIntegralRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue alpha:(CGFloat)alpha{
    CGFloat r = red / 255.0f, g = green / 255.0f, b = blue / 255.0f;
    return [UIColor colorWithRed:r green:g blue:b alpha:alpha];
}


+(UIColor*)colorWithColor:(UIColor *)color
{
    UIColor *cl = [color colorWithAlphaComponent:0.5f];
    return  cl;
}


/**
 *  生成随机色
 *
 */
+ (UIColor *)getRandomColor
{
    return [UIColor colorWithRed:(CGFloat)(1+arc4random()%99)/100 green:(CGFloat)(1+arc4random()%99)/100 blue:(CGFloat)(1+arc4random()%99)/100 alpha:1];
}
@end
