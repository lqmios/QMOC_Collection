//
//  UIColor+Expend.h
//  QMOC_KnowledgeCollection
//
//  Created by Match on 2018/1/10.
//  Copyright © 2018年 LuQingMing. All rights reserved.
//

#import <UIKit/UIKit.h>
#define RGBA_COLOR(R, G, B, A) [UIColor colorWithRed:((R) / 255.0f) green:((G) / 255.0f) blue:((B) / 255.0f) alpha:A]
#define RGB_COLOR(R, G, B) [UIColor colorWithRed:((R) / 255.0f) green:((G) / 255.0f) blue:((B) / 255.0f) alpha:1.0f]
@interface UIColor (Expend)
//参考 http://quding0308.iteye.com/blog/1743221
#pragma mark - 颜色转换 IOS中十六进制的颜色转换为UIColor


/**
 *  用十六进制设置颜色
 *
 */

+(UIColor *)colorWithHex:(long)hexColor;

/**
 *  用十六进制设置颜色和透明度
 */
+(UIColor *)colorWithHex:(long)hexColor alpha:(float)opacity;


+ (UIColor*) colorWithHexString:(NSString*)color;
+ (UIColor*) colorWithHexString:(NSString*)color alpha:(float)opacity;

+ (UIColor *)colorWithIntegralRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue;
+ (UIColor *)colorWithIntegralRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue alpha:(CGFloat)alpha;

+(UIColor*)colorWithColor:(UIColor *)color;

+ (UIColor *)getRandomColor;
@end
