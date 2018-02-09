//
//  QMNavigationViewController.m
//  QMOC_KnowledgeCollection
//
//  Created by Match on 2018/1/3.
//  Copyright © 2018年 LuQingMing. All rights reserved.
//

#import "QMNavigationViewController.h"

@interface QMNavigationViewController ()<UIGestureRecognizerDelegate>

@end

@implementation QMNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    _UIVisualEffectBackdropView
    self.navigationController.navigationBar.translucent = NO;
    self.interactivePopGestureRecognizer.delegate = self;
     [self.navigationBar removeFromSuperview];
    
}


//重写这个方法，在跳转后自动隐藏tabbar
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.viewControllers.count){
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - <UIGestureRecognizerDelegate>
/**
 *  手势识别器对象会调用这个代理方法来决定手势是否有效
 *
 *  @return YES : 手势有效, NO : 手势无效
 */
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    // 手势何时有效 : 当导航控制器的子控制器个数 > 1就有效
    return self.childViewControllers.count > 1;
}

@end
