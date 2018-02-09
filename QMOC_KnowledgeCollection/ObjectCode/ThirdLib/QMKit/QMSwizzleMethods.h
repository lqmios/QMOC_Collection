//
//  QMSwizzleMethods.h
//  QMOC_KnowledgeCollection
//
//  Created by Match on 2018/1/5.
//  Copyright © 2018年 LuQingMing. All rights reserved.
//

#import <Foundation/Foundation.h>

extern void qm_swizzleMethod(Class class,SEL originalSelector,SEL swizzleSelector);

extern BOOL qm_isKindOfStringClass(id Object);

extern BOOL qm_isKindOfArrayCladd(id Object);

extern BOOL qm_isKindOfDictionaryClass(id Object);

extern BOOL qm_isKindOfMutableStringClass(id Object);

extern BOOL qm_isKindOfMutableArrayClass(id Object);

extern BOOL qm_isKindOfMutableDictionaryClass(id Object);

extern BOOL qm_isKindOfNumberClass(id Object);

extern BOOL qm_isKindOfValueClass(id Object);

@interface QMSwizzleMethods : NSObject

@end
