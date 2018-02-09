//
//  AppDelegate+AppService.m
//  QMOC_KnowledgeCollection
//
//  Created by Match on 2018/1/3.
//  Copyright © 2018年 LuQingMing. All rights reserved.
//

#import "AppDelegate+AppService.h"
#import "QMTabBarViewController.h"

@implementation AppDelegate (AppService)
- (void)initWindow{
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [QMTabBarViewController new];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
}
@end
