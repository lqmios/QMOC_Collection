//
//  QMPageViewController.m
//  QMOC_KnowledgeCollection
//
//  Created by Match on 2018/1/8.
//  Copyright © 2018年 LuQingMing. All rights reserved.
//

#import "QMPageViewController.h"
#import "QMPageControllerView.h"
#import "QMRecommendViewController.h"
#import "QMChannelViewController.h"
#import "Macro_header.h"

@interface QMPageViewController ()<QMSegmentDelegate>

@property (nonatomic,strong) QMPageControllerView *pageView;

@end

@implementation QMPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.navigationItem.title = @"仿今日头条";
  
    NSArray *titles = @[@"关注",@"推荐",@"体育",@"视频",@"八卦",@"股票",@"美图",@"段子"];
  NSMutableArray *viewControllers = [[NSMutableArray alloc] init];
    for (int i = 0; i < titles.count; i ++) {
 
        UIViewController *vc = [self viewControllerOfIndex:i];
        [viewControllers addObject:vc];
    }
    self.pageView = [[QMPageControllerView alloc]initWithFrame:CGRectMake(0, Navgation_Height, self.view.bounds.size.width, [UIScreen mainScreen].bounds.size.height) Titles:titles viewControllers:viewControllers];
    self.pageView.delegate = self;
    //设置按钮选中和未选中状态的标题颜色
     self.pageView.itemSelectedColor = [UIColor redColor];
    self.pageView.itemNormalColor = [UIColor blackColor];
    [self.pageView showInViewController:self];
    
}
#pragma mark -----QMSegmentDelegate ---

- (void)qmPageControllerViewSwitchDidselectAtIndex:(NSInteger)index{
    NSLog(@"切换了第 --- %zd ----个视图",index);
}

- (UIViewController *)viewControllerOfIndex:(NSInteger)index{
    UIViewController *vc;
    if (index == 0) {
        vc = [[QMRecommendViewController alloc]init];
    }else{
        vc = [[QMChannelViewController alloc]init];
    }
    return vc;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
