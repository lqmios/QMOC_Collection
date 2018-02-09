//
//  Macro_header.h
//  QMOC_KnowledgeCollection
//
//  Created by Match on 2018/1/4.
//  Copyright © 2018年 LuQingMing. All rights reserved.
//

#ifndef Macro_header_h
#define Macro_header_h

#define kScreen_Height   ([UIScreen mainScreen].bounds.size.height)
#define kScreen_Width    ([UIScreen mainScreen].bounds.size.width)
#define kRedColor [UIColor colorWithRed:253/255.0 green:51/255.0 blue:67/255.0 alpha:1]
#define kGrayColor [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1]
#define kMaskColor [UIColor colorWithWhite:.5 alpha:.5];
/**状态栏高度*/
#define Navgationbar_Height [UIApplication sharedApplication].statusBarFrame.size.height
/**导航栏高度*/
#define Navgation_Height [UIApplication sharedApplication].statusBarFrame.size.height + 44


#endif /* Macro_header_h */
