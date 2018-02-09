//
//  UIImage+Color.h
//  QMOC_KnowledgeCollection
//
//  Created by Match on 2018/1/5.
//  Copyright © 2018年 LuQingMing. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 通过color颜色和size转换成UIImage
 */
@interface UIImage (Color)
/**
 *  用color和size(大小)创建image对象
 *
 *  @param color 颜色
 *  @param size  大小
 *
 *  @return UIImage
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
/**
 *  用color创建uiimage对象
 *
 *  @param color color颜色对象
 *
 *  @return uiimage对象
 */
+ (UIImage*)createImageWithColor: (UIColor*) color;
//+ (UIImage *)createImageWithColor:(UIColor *)color radius:(CGFloat)radius;
- (UIImage *)roundedCornerImageWithCornerRadius:(CGFloat)cornerRadius;

+(UIImage *)imageWithBundleImage:(NSString *)imageNamed;
+(UIImage *)imageWithBundleImage:(NSString *)imageNamed ofType:(NSString *) type;
// 加载最原始的图片，没有渲染
+ (instancetype)imageWithOriginalName:(NSString *)imageName;

+ (instancetype)imageWithStretchableName:(NSString *)imageName;


- (UIImage *)redraw;
@end
