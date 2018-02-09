//
//  BaseViewController.m
//  QMOC_KnowledgeCollection
//
//  Created by Match on 2018/1/3.
//  Copyright © 2018年 LuQingMing. All rights reserved.
//

#import "BaseViewController.h"
#import "Macro_header.h"
#import "Category_Header.h"

@interface BaseViewController ()<UINavigationControllerDelegate>
@property (strong,nonatomic) UIView         *statusBarContentView;
@end

@implementation BaseViewController
@synthesize title = _title;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initBaseSubviews];

    
}

- (void)initBaseSubviews{
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController setNavigationBarHidden:YES];

    //自动计算滚动视图的内容边距 iOS11已经废弃
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.navigationController setNavigationBarHidden:YES];
    
    [self.view addSubview:self.navBar];
    [self.navBar addSubview:self.statusBarContentView];
    
    //判断是否这个navigation里面第一个VC，若不是则加上返回按钮
    if (self.navigationController.viewControllers.firstObject != self) {
       _navigationItem.leftBarButtonItems = @[self.backBarButtonItem,[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil]];
    }else{
          _navigationItem.leftBarButtonItem = nil;
    }
    
    
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    [self.view bringSubviewToFront:self.navBar];
    [self.view bringSubviewToFront:self.statusBarContentView];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.statusBarContentView.frame = CGRectMake(0, -Navgationbar_Height, self.view.bounds.size.width, Navgationbar_Height);
    self.navBar.frame = CGRectMake(0, Navgationbar_Height, self.view.bounds.size.width, 44);
}

#pragma mark ---重写返回按钮
- (void)popNavAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -- setter ---

- (void)setTitle:(NSString *)title
{
    _title = [title copy];
    super.title = title;
    self.titleLabel.text = title;
    [self.titleLabel sizeToFit];
}
- (void)setStatusBarShouldHidden:(BOOL)statusBarShouldHidden{
    if (_statusBarShouldHidden!=statusBarShouldHidden){
        _statusBarShouldHidden = statusBarShouldHidden;
        if (self.statusBarShouldHidden) {
            self.navBar.hidden = YES;
        }
    }
}
#pragma mark ---lazy----

- (UINavigationBar *)navBar{
    if (!_navBar) {
        _navBar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, Navgationbar_Height, self.view.bounds.size.width, 44)];
        _navBar.items = @[self.navigationItem];
        [_navBar setBackgroundImage:[UIImage createImageWithColor:kRedColor] forBarMetrics:UIBarMetricsDefault];
        _navBar.tintColor = [UIColor whiteColor];
        _navBar.shadowImage = [UIImage new];
    }
    return _navBar;
}

- (UIView *)statusBarContentView{
    if (!_statusBarContentView) {
        _statusBarContentView = [[UIView alloc]init];
        _statusBarContentView.backgroundColor = kRedColor;
    }
    return _statusBarContentView;
}

- (UIBarButtonItem *)backBarButtonItem{
    if (!_backBarButtonItem){
        _backBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"ic_back"] style:UIBarButtonItemStylePlain target:self action:@selector(popNavAction:)];
    }
    return _backBarButtonItem;
}
- (UINavigationItem *)navigationItem{
    if (!_navigationItem){
        _navigationItem = [[UINavigationItem alloc]initWithTitle:@""];
    
    }
    return _navigationItem;
}

- (UILabel *)titleLabel{
    if (!_titleLabel){
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _titleLabel.font = [UIFont boldSystemFontOfSize:18];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end






















































