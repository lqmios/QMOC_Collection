//
//  QMSwizzleMethods.m
//  QMOC_KnowledgeCollection
//
//  Created by Match on 2018/1/5.
//  Copyright © 2018年 LuQingMing. All rights reserved.
//

#import "QMSwizzleMethods.h"
#import <objc/runtime.h>

BOOL qm_isKindOfStringClass(id Object){
    return [Object isKindOfClass:[NSString class]];
}

BOOL qm_isKindOfArrayCladd(id Object){
    return [Object isKindOfClass:[NSArray class]];
}

BOOL qm_isKindOfDictionaryClass(id Object){
    
    return [Object isKindOfClass:[NSDictionary class]];
}

BOOL qm_isKindOfMutableStringClass(id Object){
    return [Object isKindOfClass:[NSMutableString class]];
}

BOOL qm_isKindOfMutableArrayClass(id Object){
    return [Object isKindOfClass:[NSMutableArray class]];
}

BOOL qm_isKindOfMutableDictionaryClass(id Object){
    return [Object isKindOfClass:[NSMutableDictionary class]];
}

BOOL qm_isKindOfNumberClass(id Object){
    return [Object isKindOfClass:[NSNumber class]];
}

BOOL qm_isKindOfValueClass(id Object){
    return [Object isKindOfClass:[NSValue class]];
}

void qm_swizzleMethod(Class class,SEL originalSelector,SEL swizzleSelector){
    
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzleSelector);
    
    BOOL didAddMethod =
    class_addMethod(class,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzleSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
    
}



@implementation QMSwizzleMethods

@end


































