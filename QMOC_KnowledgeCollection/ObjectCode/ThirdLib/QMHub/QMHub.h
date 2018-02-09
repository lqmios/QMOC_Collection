//
//  QMHub.h
//  QMOC_KnowledgeCollection
//
//  Created by Match on 2018/1/10.
//  Copyright © 2018年 LuQingMing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QMHub : NSObject
/**自定义toast
 @parma: titleStr 提示语
 @parma: imgString 添加图片
 */
+ (void)showToastWithTitle:(NSString *) titleStr imgString:(NSString *)imgString;

@end

