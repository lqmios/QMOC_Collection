//
//  UIScrollView+QMSwizzle.m
//  QMOC_KnowledgeCollection
//
//  Created by Match on 2018/1/5.
//  Copyright © 2018年 LuQingMing. All rights reserved.
//

#import "UIScrollView+QMSwizzle.h"
#import "QMKit.h"

@implementation UIScrollView (QMSwizzle)

+ (void)load{
    [super load];
 
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        qm_swizzleMethod([self class], @selector(layoutSubviews), @selector(__qm_layoutSubviews));
    });
    
}
- (void)__qm_layoutSubviews{
    [self __qm_layoutSubviews];
    if (@available(iOS 11.0, *)) {
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        
    }
}

@end










