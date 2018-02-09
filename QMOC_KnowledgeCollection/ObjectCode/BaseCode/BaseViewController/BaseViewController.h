//
//  BaseViewController.h
//  QMOC_KnowledgeCollection
//
//  Created by Match on 2018/1/3.
//  Copyright © 2018年 LuQingMing. All rights reserved.
//

#import "RequestViewController.h"


@interface BaseViewController : RequestViewController
@property (assign,nonatomic)BOOL                    statusBarHiddenWithoutAnimate;
/** 是否隐藏statusbar */
@property (assign,nonatomic)BOOL                    statusBarShouldHidden;
/**重写navigationBar*/
@property (strong,nonatomic)UINavigationBar         *navBar;

/* 导航栏按钮(重写) */
@property (strong,nonatomic) UINavigationItem        *navigationItem;
/* 返回按钮 */
@property (strong,nonatomic) UIBarButtonItem         *backBarButtonItem;
/* 标题(重写) */
@property (copy,nonatomic)NSString                  *title;
/* 标题label */
@property (strong,nonatomic)UILabel                 *titleLabel;

/**重写返回事件*/
- (void)popNavAction:(id)sender;

@end
