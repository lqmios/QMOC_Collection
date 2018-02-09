//
//  QMPageControllerView.m
//  QMOC_KnowledgeCollection
//
//  Created by Match on 2018/1/8.
//  Copyright © 2018年 LuQingMing. All rights reserved.
//

#import "QMPageControllerView.h"
#import "QMSegmentCollectionView.h"

@interface QMPageControllerView ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource,QMSlideSegmentDelegate,UIScrollViewDelegate>

@property (nonatomic,strong) QMSegmentCollectionView                     *segmentCollectview;
@property (nonatomic,strong) UIPageViewController                        *pageViewController;

@end

@implementation QMPageControllerView

-(instancetype)initWithFrame:(CGRect)frame Titles:(NSArray <NSString *>*)titles viewControllers:(NSArray <UIViewController *>*) viewControllers{
 
    if (self = [super initWithFrame:frame]) {
        [self addSubview:[UIView new]];
        [self addSubview:self.segmentCollectview];
        [self addSubview:self.pageViewController.view];
        //设置ScrollView代理
        for (UIScrollView *scrollView in self.pageViewController.view.subviews) {
            if ([scrollView isKindOfClass:[UIScrollView class]]) {
                scrollView.delegate = self;
            }
        }        
        self.titles = titles;
        self.viewControllers = viewControllers;
    }
    return self;
    
}
//添加自控制器
- (void)showInViewController:(UIViewController *)viewController{
    [viewController addChildViewController:self.pageViewController];
    [viewController.view addSubview:self];
}
//视图移动前会发出willMoveToSuperview:回调
- (void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    [self switchToIndex:_selectedIndex];
}

#pragma mark -------Setter&Getter-----------

- (void)setViewControllers:(NSArray *)viewControllers{
    _viewControllers = viewControllers;
}
- (void)setTitles:(NSArray *)titles{
    _titles = titles;
    _segmentCollectview.titles = titles;
}
- (void)setItemNormalColor:(UIColor *)itemNormalColor{
    _segmentCollectview.itemNormalColor = itemNormalColor;
}
- (void)setItemSelectedColor:(UIColor *)itemSelectedColor{
    _segmentCollectview.itemSelectedColor = itemSelectedColor;
    
}
- (void)setSelectedIndex:(NSInteger)selectedIndex{
    _selectedIndex = selectedIndex;
    _segmentCollectview.selectedIndex = _selectedIndex;
    [self switchToIndex:_selectedIndex];
}

#pragma mark----------------- SlideSegmentDelegate

- (void)qmSegmentCollectionViewDidSelectedAtIndex:(NSInteger)index {
    if (index == _selectedIndex) {return;}
    [self switchToIndex:index];
    
}
#pragma mark------ UIPageViewControllerDelegate&DataSource
//返回下一个viewController对象
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    UIViewController *vc;
    if (_selectedIndex + 1 < _viewControllers.count) {
        vc = _viewControllers[_selectedIndex + 1];
        vc.view.bounds = pageViewController.view.bounds;
    }
    return vc;
}
//返回上一个viewController对象
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    UIViewController *vc;
    if (_selectedIndex - 1 >= 0) {
        vc = _viewControllers[_selectedIndex - 1];
        vc.view.bounds = pageViewController.view.bounds;
    }
    return vc;
}
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    _selectedIndex = [_viewControllers indexOfObject:pageViewController.viewControllers.firstObject];
    _segmentCollectview.selectedIndex = _selectedIndex;
    [self performSwitchDelegateMethod];
    
}

#pragma ----------------------mark ScrollViewDelegate---------------------------
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

    if (scrollView.contentOffset.x == scrollView.bounds.size.width) {return;}
    CGFloat progress = scrollView.contentOffset.x/scrollView.bounds.size.width;
    _segmentCollectview.progress = progress;
}
#pragma mark 其他方法

- (void)switchToIndex:(NSInteger)index {
    __weak __typeof(self)weakSelf = self;
    
    [self.pageViewController setViewControllers:@[_viewControllers[index]] direction:index<_selectedIndex animated:YES completion:^(BOOL finished) {
        _selectedIndex = index;
        [weakSelf performSwitchDelegateMethod];
    }];
}
#pragma mark -代理方法
- (void)performSwitchDelegateMethod {
    if ([self.delegate respondsToSelector:@selector(qmPageControllerViewSwitchDidselectAtIndex:)]) {
        [self.delegate qmPageControllerViewSwitchDidselectAtIndex:self.selectedIndex];
    }
}

#pragma mark -- lazy ---

- (UIPageViewController *)pageViewController{
    if (!_pageViewController) {
        /**两个View之间间距为10*/
        NSDictionary *options = @{UIPageViewControllerOptionInterPageSpacingKey : @(20)};
        _pageViewController = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:options];
        _pageViewController.view.frame = CGRectMake(0, 45, self.bounds.size.width, self.bounds.size.height - 45);
        _pageViewController.delegate = self;
        _pageViewController.dataSource = self;
    }
    return _pageViewController;
}

- (QMSegmentCollectionView *)segmentCollectview{
    if (!_segmentCollectview) {
        _segmentCollectview = [[QMSegmentCollectionView alloc]init];
        _segmentCollectview.frame = CGRectMake(0, 0, self.bounds.size.width, 45);
        _segmentCollectview.delegate = self;

    }
    return _segmentCollectview;
}

@end












































