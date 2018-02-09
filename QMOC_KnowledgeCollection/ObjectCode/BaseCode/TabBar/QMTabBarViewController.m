//
//  QMTabBarViewController.m
//  QMOC_KnowledgeCollection
//
//  Created by Match on 2018/1/3.
//  Copyright © 2018年 LuQingMing. All rights reserved.
//

#import "QMTabBarViewController.h"
#import "MainViewController_1.h"
#import "MainViewController_2.h"
#import "MainViewController_3.h"
#import "MainViewController_4.h"
#import "QMTabBar.h"
#import "QMNavigationViewController.h"

#import "Macro_header.h"

@interface QMTabBarViewController ()<UITabBarControllerDelegate>
@property (nonatomic,strong) QMTabBar            *mcTabbar;
@property (nonatomic,strong) UIView              *shadowView;

@end

@implementation QMTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTabBarSubviews];
}

- (void)initTabBarSubviews{
    
    _mcTabbar = [[QMTabBar alloc] init];
    [_mcTabbar.centerBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    //选中时的颜色
    _mcTabbar.tintColor = [UIColor colorWithRed:27.0/255.0 green:118.0/255.0 blue:208/255.0 alpha:1];
    //透明设置为NO，显示白色，view的高度到tabbar顶部截止，YES的话到底部
    _mcTabbar.translucent = NO;
    //利用KVC 将自己的tabbar赋给系统tabBar
    [self setValue:_mcTabbar forKeyPath:@"tabBar"];
    
    self.delegate = self;
    [self addChildViewControllers];
    [self.tabBar insertSubview:self.shadowView atIndex:0];
}

#pragma mark ---添加自控制器---
- (void)addChildViewControllers{
    //图片大小建议32*32
    [self addChildrenViewController:[[MainViewController_1 alloc] init] andTitle:@"首页" andImageName:@"tab1_n" andSelectImage:@"tab1_p"];
    [self addChildrenViewController:[[MainViewController_2 alloc] init] andTitle:@"扩展" andImageName:@"tab2_n" andSelectImage:@"tab2_p"];
    //中间这个不设置东西，只占位
    [self addChildrenViewController:[[UIViewController alloc] init] andTitle:@"旋转" andImageName:@"" andSelectImage:@""];
    [self addChildrenViewController:[[MainViewController_3 alloc] init] andTitle:@"发现" andImageName:@"tab3_n" andSelectImage:@"tab3_p"];
    [self addChildrenViewController:[[MainViewController_4 alloc] init] andTitle:@"我" andImageName:@"tab4_n" andSelectImage:@"tab4_p"];
}
- (void)addChildrenViewController:(UIViewController *)childVC andTitle:(NSString *)title andImageName:(NSString *)imageName andSelectImage:(NSString *)selectedImage{
    childVC.tabBarItem.image = [UIImage imageNamed:imageName];
    childVC.tabBarItem.selectedImage =  [UIImage imageNamed:selectedImage];
    childVC.title = title;
    
    QMNavigationViewController *baseNav = [[QMNavigationViewController alloc] initWithRootViewController:childVC];
    
    [self addChildViewController:baseNav];
}


- (void)buttonAction:(UIButton *)button{
    self.selectedIndex = 2;//关联中间按钮
    [self rotationAnimation];
}


//tabbar选择时的代理
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    if (tabBarController.selectedIndex == 2){//选中中间的按钮
        [self rotationAnimation];
    }else {
        [_mcTabbar.centerBtn.layer removeAllAnimations];
    }
}
//旋转动画
- (void)rotationAnimation{
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI*2.0];
    rotationAnimation.duration = 3.0;
    rotationAnimation.repeatCount = HUGE;
    [_mcTabbar.centerBtn.layer addAnimation:rotationAnimation forKey:@"key"];
}

#pragma mark -- lazy ---
/**tabbar顶部阴影线*/
- (UIView *)shadowView{
    if (!_shadowView) {
        
        _shadowView = [[UIView alloc]initWithFrame:CGRectMake(0, -5, kScreen_Width, 5)];
        /**设置渐变色*/
        CAGradientLayer *gradient = [CAGradientLayer layer];
        gradient.frame = _shadowView.bounds;
        gradient.colors = [NSArray arrayWithObjects:
                           (id)[UIColor colorWithWhite:0 alpha:0].CGColor,
                           (id)[UIColor colorWithWhite:0.1 alpha:0.08].CGColor,nil];
        /**渐变色方向*/
        gradient.startPoint = CGPointMake(0, 0);
        gradient.endPoint = CGPointMake(0, 1);
        [_shadowView.layer insertSublayer:gradient atIndex:0];
    }
    return _shadowView;
}


@end































